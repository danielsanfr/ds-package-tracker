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
	m_uuid = m_dataBaseController->getUUID();
	onReLoad(-1, packageTable);
	bool isOk =
			connect(m_dataBaseController,
					SIGNAL(createdRecord(int, const QString &, const QVariantMap &, const qlonglong &)),
					this, SLOT(onReLoad(int, const QString &)));
	Q_ASSERT(isOk);
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
	qlonglong longId = m_dataBaseController->create(data, m_uuid);
	int id = QVariant(longId).toInt();
	QSharedPointer<Package> package = QSharedPointer<Package>(new Package(data.value("code").toString()));
	package->validateCode();
	if (package->isValidCode()) {
		bool isOk = connect(package.data(),
				SIGNAL(loadCompleted(brpackagetracking::Package*)),
				this, SLOT(handler(brpackagetracking::Package*)));
		Q_ASSERT(isOk);
		isOk = connect(package.data(), SIGNAL(loadError(QString)), this,
				SLOT(handlerError(QString)));
		Q_ASSERT(isOk);
		isOk = connect(this, SIGNAL(load(const QString&)), package.data(),
				SLOT(load(const QString&)));
		Q_ASSERT(isOk);
		m_packagesMap.insert(id, package);
		emit load(data.value("code").toString());
	}
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
		QList<Information> infos = m_packagesMap.value(id)->checkpoints();
		foreach (Information info, infos)
			list.append(informationToMap(info));
		qDebug() << "PackagesController::informationList:load at pending list";
	} else {
		QVariantMap args;
		args.insert(":package_id", id);
		m_dataBaseController->setTableName(infosTable);
		list.append(
				m_dataBaseController->read(args,
						"(package_id=:package_id) ORDER BY package_id;"));
		qDebug() << "PackagesController::informationList:load at data base";
	}
	return list;
}

void PackagesController::update(const int& id) {
	if (m_packagesMap.contains(id))
		emit load(m_packagesMap.value(id)->code());
}

void PackagesController::update() {
	QList<int> ids = m_packagesMap.keys();
	foreach (int id, ids)
		emit load(m_packagesMap.value(id)->code());
}

QString PackagesController::sendFrom(const int& id) {
	return m_packagesMap.value(id)->countryName();
}

QString PackagesController::serviceName(const int& id) {
	return m_packagesMap.value(id)->serviceName();
}

QVariantMap PackagesController::informationToMap(const Information& info) {
	QVariantMap map;
	map.insert("date", info.date());
	map.insert("location", info.location());
	map.insert("situation", info.situation());
	return map;
}

void PackagesController::onReLoad(int uuid, const QString &tableName) {
	if (tableName == packageTable && uuid != m_uuid) {
		m_dataBaseController->setTableName(packageTable);
		m_packagesMap.clear();
		QVariantMap args;
		args.insert(":status", "pending");
		QVariantList packages = m_dataBaseController->read(args,
				"status=:status");
		foreach (QVariant packageV, packages)
		{
			QSharedPointer<Package> package = QSharedPointer<Package>(new Package(packageV.toMap().value("code").toString()));
			package->validateCode();
			if (package->isValidCode()) {
				bool isOk = connect(package.data(),
						SIGNAL(loadCompleted(brpackagetracking::Package*)),
						this, SLOT(handler(brpackagetracking::Package*)));
				Q_ASSERT(isOk);
				isOk = connect(package.data(), SIGNAL(loadError(QString)), this,
						SLOT(handlerError(QString)));
				Q_ASSERT(isOk);
				isOk = connect(this, SIGNAL(load(const QString&)), package.data(),
						SLOT(load(const QString&)));
				Q_ASSERT(isOk);
				m_packagesMap.insert(packageV.toMap()["id"].toInt(), package);
				emit load(packageV.toMap().value("code").toString());
			}
		}
	}
}

void PackagesController::handler(Package* package) {
	int id = idByCode(package->code());
	m_dataBaseController->setTableName(infosTable);
	QList<Information> infos = package->checkpoints();
	QVariantMap args;
	args.insert(":package_id", id);
	int newInfosSize = infos.size();
	int oldInfosSize = m_dataBaseController->count(args,
			"package_id=:package_id");
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
		m_dataBaseController->update(packageMap, m_uuid);
	}
}

void PackagesController::handlerError(QString message) {
	qDebug() << "PackagesController::handlerError:" << message;
	Q_ASSERT(false);
}

int PackagesController::idByCode(const QString& code) {
	QList<int> ids = m_packagesMap.keys();
	foreach(int id, ids)
	{
		if (code == m_packagesMap.value(id)->code())
			return id;
	}
	return -1;
}

void PackagesController::debug(const QString& file, const int& line,
		const QVariant& data) {
	qDebug() << file << ":" << line << "-" << data;
}
