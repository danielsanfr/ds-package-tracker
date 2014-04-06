/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "applicationui.hpp"

using namespace bb::system;
using namespace bb::cascades;
using namespace bb::cascades::advertisement;
using namespace brpackagetracking;
using namespace datamodel;
using namespace db;

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
		QObject(app) {
	DataBaseController *dataBaseController = DataBaseController::getInstance(
			this);
	QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty(
			"_db", dataBaseController);
	ApplicationInfo::registerQmlTypes();
	SqlDataModel::registerQmlTypes();
	const char *uri = "bb.cascades.advertisement";
	qmlRegisterType<Banner>(uri, 1, 0, "Banner");
	// prepare the localization
	m_pTranslator = new QTranslator(this);
	m_pLocaleHandler = new LocaleHandler(this);

	DataBaseController::createDB();
	DataBaseController::createTables();

	bool res = QObject::connect(m_pLocaleHandler,
			SIGNAL(systemLanguageChanged()), this,
			SLOT(onSystemLanguageChanged()));
	// This is only available in Debug builds
	Q_ASSERT(res);
	// Since the variable is not used in the app, this is added to avoid a
	// compiler warning
	Q_UNUSED(res);

	// initial load
	onSystemLanguageChanged();

	// Create scene document from main.qml asset, the parent is set
	// to ensure the document gets destroyed properly at shut down.
	QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

//    const QString uuid(QLatin1String("76a353d0-bd9c-11e3-b1b6-0800200c9a66")); // full version
	const QString uuid(QLatin1String("f0af2ec0-bd9b-11e3-b1b6-0800200c9a66")); // free version
	RegistrationHandler *registrationHandler = new RegistrationHandler(uuid,
			app);
	m_inviteToDownload = new InviteToDownload(registrationHandler->context(),
			app);
	res = connect(registrationHandler, SIGNAL(registered()), m_inviteToDownload,
			SLOT(show()));
	Q_ASSERT(res);
	Q_UNUSED(res);

	ActiveFrameQML *activeFrame = new ActiveFrameQML(this);
	Application::instance()->setCover(activeFrame);

	// Create root object for the UI
	AbstractPane *root = qml->createRootObject<AbstractPane>();
	qml->setContextProperty("_app", this);
	qml->documentContext()->setContextProperty("_settings",
			Settings::getInstance(this));
	qml->documentContext()->setContextProperty("_notification",
			new Notification(this));
	qml->documentContext()->setContextProperty("_packageCtrl",
			PackagesController::getInstance(this));
	Settings::getInstance(this)->setParent(this);
	Settings::getInstance(this)->emitObjectName("last_update_date");

	registrationHandler->registerApplication();

	// Set created root object as the application scene
	app->setScene(root);
}

void ApplicationUI::sendInvite() {
	m_inviteToDownload->sendInvite();
}

void ApplicationUI::sendEmail() {
	ApplicationInfo appInfo(this);
	InvokeManager *manager = new InvokeManager(this);
	InvokeRequest request;
	request.setTarget("sys.pim.uib.email.hybridcomposer");
	request.setAction("bb.action.COMPOSE");
	request.setMimeType("message/rfc822");
	QVariantMap contentMap;
	contentMap.insert("to", QVariantList() << "daniel.sam123@hotmail.com");
	contentMap.insert("subject", "[DS Package Tracking] Support or suggestion");
	contentMap.insert("body", "App version: " + appInfo.version());
	QVariantMap data;
	data.insert("data", contentMap);
	bool ok;
	request.setData(bb::PpsObject::encode(data, &ok));
	manager->invoke(request);
//	InvokeTargetReply* reply =
	manager->invoke(request); // #include <bb/system/InvokeTargetReply>
}

QByteArray ApplicationUI::encode(const QVariantMap& data, bool* ok) {
	return bb::PpsObject::encode(data, ok);
}

void ApplicationUI::onSystemLanguageChanged() {
	QCoreApplication::instance()->removeTranslator(m_pTranslator);
	// Initiate, load and install the application translation files.
	QString locale_string = QLocale().name();
	QString file_name = QString("DSPackageTracking_%1").arg(locale_string);
	if (m_pTranslator->load(file_name, "app/native/qm")) {
		QCoreApplication::instance()->installTranslator(m_pTranslator);
	}
}
