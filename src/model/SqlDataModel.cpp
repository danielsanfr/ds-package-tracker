/*
 * SqlDataModel.cpp
 *
 *  Created on: 06/02/2014
 *      Author: daniel
 */

#include "SqlDataModel.hpp"

using namespace bb::cascades;
using namespace db;

namespace datamodel {

SqlDataModel::SqlDataModel(QObject *parent) :
		ArrayDataModel(parent), m_table(""), m_dataBaseController(
				DataBaseController::getInstance(this)) {
	m_dbAccessUUID = m_dataBaseController->getUUID();
	emit sizeChanged();
	bool isOk = connect(m_dataBaseController,
			SIGNAL(tableNameChanged(int, const QString &)), this,
			SLOT(onTableNameChanged(int, const QString &)));
	Q_ASSERT(isOk);
	isOk =
			connect(m_dataBaseController,
					SIGNAL(createdRecord(int, const QString &, const QVariantMap &, const qlonglong &)),
					this,
					SLOT(onCreatedRecord(int, const QString &, const QVariantMap &, const qlonglong &)));
	Q_ASSERT(isOk);
	isOk = connect(m_dataBaseController,
			SIGNAL(deletedRecord(int, const QString &, const int &)), this,
			SLOT(onDeletedRecord(int, const QString &, const int &)));
	Q_ASSERT(isOk);
	isOk =
			connect(m_dataBaseController,
					SIGNAL(deletedRecord(int, const QString &, const QVariantMap &, const QString &)),
					this,
					SLOT(onDeletedRecord(int, const QString &, const QVariantMap &, const QString &)));
	Q_ASSERT(isOk);
	isOk =
			connect(m_dataBaseController,
					SIGNAL(updatedRecord(int, const QString &, const QVariantMap &)),
					this,
					SLOT(onUpdatedRecord(int, const QString &, const QVariantMap &)));
	Q_ASSERT(isOk);

	// connect size signais
	isOk = connect(this,
			SIGNAL(itemsChanged(bb::cascades::DataModelChangeType::Type)),
			this, SIGNAL(sizeChanged()));
	Q_ASSERT(isOk);
	isOk = connect(this, SIGNAL(itemAdded(QVariantList)), this,
			SIGNAL(sizeChanged()));
	Q_ASSERT(isOk);
	isOk = connect(this, SIGNAL(itemRemoved(QVariantList)), this,
			SIGNAL(sizeChanged()));
	Q_ASSERT(isOk);
	isOk = connect(this, SIGNAL(itemUpdated(QVariantList)), this,
			SIGNAL(sizeChanged()));
	Q_ASSERT(isOk);
}

SqlDataModel::~SqlDataModel() {
}

const QString& SqlDataModel::table() {
	return m_table;
}

void SqlDataModel::setTable(const QString& table) {
	m_table = table;
	m_dataBaseController->setTableName(table, m_dbAccessUUID);
	emit tableChanged();
}

qlonglong SqlDataModel::create(const QVariantMap& data) {
	m_dataBaseController->setTableName(m_table);
	int id = m_dataBaseController->create(data, m_dbAccessUUID);
	QVariantMap newData = data;
	newData[FIELD_ID] = id;
	append(newData);
	return id;
}

void SqlDataModel::deleteRecordById(const int& id) {
	deleteRecord(getIndexPathByID(id));
}

void SqlDataModel::deleteRecord(const QVariantList& indexPath) {
	m_dataBaseController->setTableName(m_table);
	m_dataBaseController->deleteRecord(
			data(indexPath).toMap()[FIELD_ID].toInt(), m_dbAccessUUID);
	int index = indexPath.back().toInt();
	if (index != -1)
		removeAt(index);
}

void SqlDataModel::deleteRecord(const QVariantMap& arguments,
		const QString& conditions) {
	m_dataBaseController->setTableName(m_table);
}

void SqlDataModel::update(const QVariantMap& data) {
	m_dataBaseController->setTableName(m_table);
	m_dataBaseController->update(data, m_dbAccessUUID);
	QVariantList indexPath = getIndexPathByID(data[FIELD_ID].toInt());
	replace(indexPath.back().toInt(), data);
}

QVariantMap SqlDataModel::read(const int& id) {
	m_dataBaseController->setTableName(m_table);
	return m_dataBaseController->read(id);
}

QVariantList SqlDataModel::read() {
	m_dataBaseController->setTableName(m_table);
	m_lastLoadConditions = "";
	return m_dataBaseController->read();
}

QVariantList SqlDataModel::read(const QVariantMap& arguments,
		const QString& conditions) {
	m_dataBaseController->setTableName(m_table);
	m_lastLoadConditions = conditions;
	m_lastLoadArguments = arguments;
	return m_dataBaseController->read(arguments, conditions);
}

int SqlDataModel::count() {
	m_dataBaseController->setTableName(m_table);
	return m_dataBaseController->count();
}

int SqlDataModel::count(const QVariantMap& arguments,
		const QString& conditions) {
	m_dataBaseController->setTableName(m_table);
	return m_dataBaseController->count(arguments, conditions);
}

void SqlDataModel::load() {
	m_dataBaseController->setTableName(m_table);
	int length = size();
	for (int i = 0; i < length; ++i)
		removeAt(0);
	append(m_dataBaseController->read());
}

void SqlDataModel::load(const QVariantMap& arguments,
		const QString& conditions) {
	m_lastLoadArguments = arguments;
	m_lastLoadConditions = conditions;
	m_dataBaseController->setTableName(m_table);
	int length = size();
	for (int i = 0; i < length; ++i)
		removeAt(0);
	append(m_dataBaseController->read(arguments, conditions));
}

void SqlDataModel::clearRecords() {
	m_dataBaseController->setTableName(m_table);
	int length = size();
	for (int i = 0; i < length; ++i) {
		m_dataBaseController->deleteRecord(value(0).toMap()["id"].toInt());
		removeAt(0);
	}
}

void SqlDataModel::onTableNameChanged(int uuid, const QString& tableName) {
}

void SqlDataModel::onCreatedRecord(int uuid, const QString &tableName,
		const QVariantMap& data, const qlonglong& id) {
	if (uuid != m_dbAccessUUID && tableName == m_table) {
//		QVariantMap newData = data;
//		newData[FIELD_ID] = id;
//		append(newData);
		if (m_lastLoadConditions == "")
			load();
		else
			load(m_lastLoadArguments, m_lastLoadConditions);
	}
}

void SqlDataModel::onDeletedRecord(int uuid, const QString &tableName,
		const int& id) {
	if (uuid != m_dbAccessUUID && tableName == m_table) {
//		QVariantList indexPath = getIndexPathByID(id);
//		int index = indexPath.back().toInt();
//		if (index != -1)
//			removeAt(index);
		if (m_lastLoadConditions == "")
			load();
		else
			load(m_lastLoadArguments, m_lastLoadConditions);
	}
}

void SqlDataModel::onDeletedRecord(int uuid, const QString &tableName,
		const QVariantMap& arguments, const QString& conditions) {
	Q_UNUSED(arguments);
	Q_UNUSED(conditions);
	if (uuid != m_dbAccessUUID && tableName == m_table) {
		if (m_lastLoadConditions == "")
			load();
		else
			load(m_lastLoadArguments, m_lastLoadConditions);
	}
}

void SqlDataModel::onUpdatedRecord(int uuid, const QString &tableName,
		const QVariantMap& data) {
	Q_UNUSED(data);
	if (tableName == m_table) {
		QVariantList indexPath = getIndexPathByID(data[FIELD_ID].toInt());
//		replace(indexPath.back().toInt(), data);
		if (m_lastLoadConditions == "")
			load();
		else
			load(m_lastLoadArguments, m_lastLoadConditions);
	}
}

QVariantList SqlDataModel::getIndexPathByID(const int& id) {
	int length = size();
	for (int i = 0; i < length; ++i) {
		if (value(i).toMap()[FIELD_ID].toInt() == id)
			return QVariantList() << i;
	}
	return QVariantList() << -1;
}

} /* namespace model */
