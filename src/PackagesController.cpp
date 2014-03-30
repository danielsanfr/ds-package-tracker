/*
 * PackagesController.cpp
 *
 *  Created on: 28/03/2014
 *      Author: daniel
 */

#include "PackagesController.hpp"

using namespace brpackagetracking;
using namespace brpackagetracking::util;
using namespace brpackagetracking::model;
using namespace db;

QString packageTable("package");
QString infosTable("infos");

PackagesController::PackagesController(QObject *parent) :
		QObject(parent), m_dataBaseController(
				DataBaseController::getInstance(this)), m_util(
				Util::getInstance(this)) {
	onReLoad(-1, packageTable);
	update();
	bool isOk = connect(m_dataBaseController,
			SIGNAL(tableNameChanged(int, const QString &)), this,
			SLOT(onReLoad(int, const QString &)));
	Q_ASSERT(isOk);
	isOk =
			connect(m_dataBaseController,
					SIGNAL(createdRecord(int, const QString &, const QVariantMap &, const qlonglong &)),
					this, SLOT(onReLoad(int, const QString &)));
	Q_ASSERT(isOk);
	isOk = connect(m_dataBaseController,
			SIGNAL(deletedRecord(int, const QString &, const int &)), this,
			SLOT(onReLoad(int, const QString &)));
	Q_ASSERT(isOk);
	isOk =
			connect(m_dataBaseController,
					SIGNAL(deletedRecord(int, const QString &, const QVariantMap &, const QString &)),
					this, SLOT(onReLoad(int, const QString &)));
	Q_ASSERT(isOk);
	isOk = connect(m_dataBaseController,
			SIGNAL(updatedRecord(int, const QString &, const QVariantMap &)),
			this, SLOT(onReLoad(int, const QString &)));
	Q_ASSERT(isOk);
}

PackagesController::~PackagesController() {
	// TODO Auto-generated destructor stub
}

void PackagesController::create(const QVariantMap& data) {
	m_dataBaseController->setTableName(packageTable);
	qlonglong longId = m_dataBaseController->create(data);
	int id = QVariant(longId).toInt();
	m_packagesMap.insert(id, Package(data.value("code").toString(), this));
	update(id);
}

int PackagesController::validateCode(const QString& code) {
	m_packageAux.setCode(code);
	return m_packageAux.validateCode();
}

QVariantList PackagesController::countyAndService() {
	return QVariantList() << m_packageAux.countryName()
			<< m_packageAux.serviceName();
}

QVariantList PackagesController::informationList(const int& id) {
	QVariantList list;
	if (m_packagesMap.contains(id)) {
		Package package = m_packagesMap.value(id);
		QList<Information> infos = package.checkpoints();
		foreach (Information info, infos)
			list.append(informationToMap(info));
		qDebug() << "PackagesController::informationList:load at pending list"
				<< infos.size();
	} else {
		QVariantMap args;
		args.insert(":package_id", id);
		m_dataBaseController->setTableName(infosTable);
		list.append(
				m_dataBaseController->read(args,
						"(package_id=:package_id) ORDER BY package_id;"));
		qDebug() << "PackagesController::informationList:load at data base"
				<< m_dataBaseController->read(args,
						"(package_id=:package_id) ORDER BY package_id;").size();
	}
	return list;
}

void PackagesController::update(const int& id) {
	Package *package = new Package(m_packagesMap.value(id), this);
	bool isOk = connect(package,
			SIGNAL(loadCompleted(brpackagetracking::Package*)), this,
			SLOT(handler(brpackagetracking::Package*)));
	Q_ASSERT(isOk);
	isOk = connect(package, SIGNAL(loadError(QString)), this,
			SLOT(handlerError(QString)));
	Q_ASSERT(isOk);
	package->validateCode();
	if (package->isValidCode())
		package->load();
}

void PackagesController::update() {
	QList<int> ids = m_packagesMap.keys();
	foreach (int id, ids)
	{
		Package *package = new Package(m_packagesMap.value(id), this);
		bool isOk = connect(package,
				SIGNAL(loadCompleted(brpackagetracking::Package*)), this,
				SLOT(handler(brpackagetracking::Package*)));
		Q_ASSERT(isOk);
		isOk = connect(package, SIGNAL(loadError(QString)), this,
				SLOT(handlerError(QString)));
		Q_ASSERT(isOk);
		package->validateCode();
		if (package->isValidCode())
			package->load();
	}
}

QVariantMap PackagesController::informationToMap(const Information& info) {
	QVariantMap map;
	map.insert("date", info.date());
	map.insert("location", info.location());
	map.insert("situation", info.situation());
	return map;
}

void PackagesController::onReLoad(int uuid, const QString &tableName) {
	Q_UNUSED(uuid);
	if (tableName == packageTable) {
		m_dataBaseController->setTableName(packageTable);
		m_packagesMap.clear();
		QVariantMap args;
		args.insert(":status", "pending");
		QVariantList packages = m_dataBaseController->read(args,
				"status=:status");
		foreach (QVariant package, packages)
		{
			m_packagesMap.insert(package.toMap()["id"].toInt(),
					Package(package.toMap()["code"].toString(), this));
		}
	}
}

void PackagesController::handler(Package* package) {
	int id = idByCode(package->code());
	qDebug() << "PackagesController::handler" << id;
	m_dataBaseController->setTableName(infosTable);
	QList<Information> infos = package->checkpoints();
	QVariantMap args;
	args.insert(":package_id", id);
	int newInfosSize = infos.size(), oldInfosSize = m_dataBaseController->count(
			args, "package_id=:package_id");
	if (newInfosSize > oldInfosSize) {
		for (int i = oldInfosSize; i < newInfosSize; ++i) {
			Information info = infos.at(i);
			QVariantMap map;
			map.insert("date", info.date());
			map.insert("situation", info.situation());
			map.insert("location", info.location());
			map.insert("package_id", id);
			m_dataBaseController->create(map);
		}
		m_dataBaseController->setTableName(packageTable);
		QVariantMap packageMap = m_dataBaseController->read(id);
		packageMap.remove("last_update_date");
		packageMap.remove("last_situation");
		packageMap.insert("last_update_date", QDate::currentDate());
		packageMap.insert("last_situation",
				package->checkpoints().at(0).situation());
		m_dataBaseController->update(packageMap);
	}
	m_packagesMap.remove(id);
	m_packagesMap.insert(id, *package);

	bool isOk = disconnect(package,
			SIGNAL(loadCompleted(brpackagetracking::Package*)), this,
			SLOT(handler(brpackagetracking::Package*)));
	Q_ASSERT(isOk);
	isOk = connect(package, SIGNAL(loadError(QString)), this,
			SLOT(handlerError(QString)));
	Q_ASSERT(isOk);
}

void PackagesController::handlerError(QString message) {
	qDebug() << "PackagesController::handlerError:" << message;
	Q_ASSERT(false);
}

int PackagesController::idByCode(const QString& code) {
	QList<int> ids = m_packagesMap.keys();
	foreach(int id, ids)
	{
		if (code == m_packagesMap.value(id).code())
			return id;
	}
	return -1;
}
