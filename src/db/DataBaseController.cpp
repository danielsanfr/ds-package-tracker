/*
 * DataBaseController.cpp
 *
 *  Created on: 07/02/2014
 *      Author: daniel
 */

#include "DataBaseController.hpp"

namespace db {

DataBaseController::DataBaseController(QObject *parent) :
		QObject(parent), m_tableName(PACKAGE_TABLE), m_dataBaseCRUD(0) {
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
			+ PACKAGE_CREATED + " TEXT NOT NULL, " + PACKAGE_LAST_UPDATE + " DATE NOT NULL, "
			+ PACKAGE_SHORT_DESCR + " TEXT NOT NULL, " + PACKAGE_CODE + " TEXT NOT NULL, "
			+ PACKAGE_SENDING + " BOOLEAN NOT NULL, " + PACKAGE_DESCRIPTION + " TEXT);";
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

	const QString emailTableQuery = "CREATE TABLE IF NOT EXISTS " + EMAIL_TABLE
				+ " (" + EMAIL_PACKAGE_ID + " INTEGER NOT NULL, FOREIGN KEY ("
				+ INFO_PACKAGE_ID + ") REFERENCES " + PACKAGE_TABLE + " (" + PACKAGE_ID + "));";
		if (!query.exec(emailTableQuery))
				qDebug()
						<< "DataBaseController::createTables:: Create email table error: "
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

	const QString emailTableQuery = "DROP TABLE IF EXISTS " + EMAIL_TABLE;
	if (!query.exec(emailTableQuery))
		qDebug()
				<< "DataBaseController::dropTables: Drop email table error: "
						+ query.lastError().text();
	database.close();
}

void DataBaseController::setTableName(const QString &tableName) {
	Q_ASSERT(tableName == PACKAGE_TABLE || tableName == INFO_TABLE || tableName == EMAIL_TABLE);
	if (m_tableName != tableName) {
		m_tableName = tableName;
		emit tableNameChanged(tableName);
		setCRUBInstanceByTableName();
	}
}

const QString& DataBaseController::tableName() {
	return m_tableName;
}

qlonglong DataBaseController::create(const QVariantMap& data) {
	qlonglong id =  m_dataBaseCRUD->create(data);
	emit createdRecord(m_tableName, data, id);
	return id;
}

void DataBaseController::deleteRecord(const int& id) {
	emit deletedRecord(m_tableName, id);
	m_dataBaseCRUD->deleteRecord(id);
}

void DataBaseController::deleteRecord(const QVariantMap& arguments,
		const QString& conditions) {
	emit deletedRecord(m_tableName, arguments, conditions);
	m_dataBaseCRUD->deleteRecord(arguments, conditions);
}

void DataBaseController::update(const QVariantMap& data) {
	emit updatedRecord(m_tableName, data);
	m_dataBaseCRUD->update(data);
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

void DataBaseController::setCRUBInstanceByTableName() {
	if (m_tableName == PACKAGE_TABLE)
		m_dataBaseCRUD = new PackageCRUD();
	else if (m_tableName == INFO_TABLE)
		m_dataBaseCRUD = new InfoCRUD();
	else if (m_tableName == EMAIL_TABLE)
		m_dataBaseCRUD = new EmailCRUD();
}

} /* namespace db */
