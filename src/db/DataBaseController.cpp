/*
 * DataBaseController.cpp
 *
 *  Created on: 07/02/2014
 *      Author: daniel
 */

#include "DataBaseController.hpp"

namespace db {

DataBaseController::DataBaseController(QObject *parent) :
		QObject(parent), m_UUIDs(-1), m_tableName(PACKAGE_TABLE), m_dataBaseCRUD(0) {
	setCRUBInstanceByTableName();
}

DataBaseController::~DataBaseController() {
}

bool DataBaseController::createDB() {
	QSqlDatabase database = QSqlDatabase::addDatabase("QSQLITE");
	bool success = false;
	database.setDatabaseName(DB_PATH);
	if (database.open()) {
		qDebug() << "DataBaseController::createDB: Database created/registered.";
		success = true;
	} else {
		qDebug()
				<< "DataBaseController::createDB: Error opening connection to the database: "
						+ database.lastError().text();
	}
	database.close();
	return success;
}

void DataBaseController::createTables() {
	QSqlDatabase database = QSqlDatabase::database();
	QSqlQuery query(database);

	const QString packageTableQuery = "CREATE TABLE IF NOT EXISTS " + PACKAGE_TABLE
			+ " (" + PACKAGE_ID + " INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "
			+ PACKAGE_STATUS + " TEXT NOT NULL, " + PACKAGE_CREATED + " TEXT NOT NULL, "
			+ PACKAGE_LAST_UPDATE + " DATE NOT NULL, " + PACKAGE_SITUATION + " TEXT NOT NULL, "
			+ PACKAGE_SHORT_DESCR + " TEXT NOT NULL, " + PACKAGE_CODE + " TEXT NOT NULL, "
			+ PACKAGE_SENDING + " BOOLEAN NOT NULL, " + PACKAGE_URL_TO_STORE + " TEXT, "
			+ PACKAGE_DESCRIPTION + " TEXT, " + PACKAGE_EMAILS + " TEXT);";
	if (!query.exec(packageTableQuery))
		qDebug()
				<< "DataBaseController::createTables:: Create package table error: "
						+ query.lastError().text();

	const QString infoTableQuery = "CREATE TABLE IF NOT EXISTS " + INFO_TABLE
			+ " (" + INFO_ID + " INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "
			+ INFO_PACKAGE_ID + " INTEGER NOT NULL, " + INFO_DATE + "TEXT NOT NULL, "
			+ INFO_LOCATION + " TEXT NOT NULL, " + INFO_SITUATION
			+ " TEXT NOT NULL, FOREIGN KEY (" + INFO_PACKAGE_ID + ") REFERENCES "
			+ PACKAGE_TABLE + " (" + PACKAGE_ID + "));";
	if (!query.exec(infoTableQuery))
			qDebug()
					<< "DataBaseController::createTables:: Create info table error: "
							+ query.lastError().text();

	qDebug() << "DataBaseController::createTables: Created tables";
	database.close();
}

void DataBaseController::dropTables() {
	QSqlDatabase database = QSqlDatabase::database();
	QSqlQuery query(database);

	const QString packageTableQuery = "DROP TABLE IF EXISTS " + PACKAGE_TABLE;
	if (!query.exec(packageTableQuery))
		qDebug()
				<< "DataBaseController::dropTables: Drop package table error: "
						+ query.lastError().text();

	const QString infoTableQuery = "DROP TABLE IF EXISTS " + INFO_TABLE;
	if (!query.exec(infoTableQuery))
		qDebug()
				<< "DataBaseController::dropTables: Drop infos table error: "
						+ query.lastError().text();

	database.close();
}

void DataBaseController::setTableName(const QString &tableName, int uuid) {
	Q_ASSERT(tableName == PACKAGE_TABLE || tableName == INFO_TABLE);
	if (m_tableName != tableName) {
		m_tableName = tableName;
		setCRUBInstanceByTableName();
		emit tableNameChanged(uuid, tableName);
	}
}

const QString& DataBaseController::tableName() {
	return m_tableName;
}

qlonglong DataBaseController::create(const QVariantMap& data, int uuid) {
	qlonglong id =  m_dataBaseCRUD->create(data);
	emit createdRecord(uuid, m_tableName, data, id);
	return id;
}

void DataBaseController::deleteRecord(const int& id, int uuid) {
	m_dataBaseCRUD->deleteRecord(id);
	emit deletedRecord(uuid, m_tableName, id);
}

void DataBaseController::deleteRecord(const QVariantMap& arguments,
		const QString& conditions, int uuid) {
	m_dataBaseCRUD->deleteRecord(arguments, conditions);
	emit deletedRecord(uuid, m_tableName, arguments, conditions);
}

void DataBaseController::update(const QVariantMap& data, int uuid) {
	m_dataBaseCRUD->update(data);
	emit updatedRecord(uuid, m_tableName, data);
}

const QVariantMap DataBaseController::read(const int& id) {
	return m_dataBaseCRUD->read(id);
}

const QVariantList DataBaseController::read() {
	return m_dataBaseCRUD->read();
}

const QVariantList DataBaseController::read(const QVariantMap& arguments,
		const QString& conditions) {
	return m_dataBaseCRUD->read(arguments, conditions);
}

int DataBaseController::count() {
	return m_dataBaseCRUD->count();
}

int DataBaseController::count(const QVariantMap& arguments,
		const QString& conditions) {
	return m_dataBaseCRUD->count(arguments, conditions);
}

int DataBaseController::getUUID() {
	++m_UUIDs;
	return m_UUIDs;
}

void DataBaseController::setCRUBInstanceByTableName() {
	if (m_tableName == PACKAGE_TABLE)
		m_dataBaseCRUD = new PackageCRUD();
	else if (m_tableName == INFO_TABLE)
		m_dataBaseCRUD = new InfoCRUD();
}

} /* namespace db */






























