/*
 * InfoCRUD.cpp
 *
 *  Created on: 27/03/2014
 *      Author: daniel
 */

#include "InfoCRUD.hpp"

namespace db {

InfoCRUD::InfoCRUD() {
	// TODO Auto-generated constructor stub
}

InfoCRUD::~InfoCRUD() {
	// TODO Auto-generated destructor stub
}

const QString InfoCRUD::getCRUDName() const {
	return QString("InfoCRUD");
}

const QString InfoCRUD::getTableName() const {
	return INFO_TABLE;
}

void InfoCRUD::prepareCreateQuery(QSqlQuery& query,
		const QVariantMap& data) const {
	query.prepare("INSERT INTO " + INFO_TABLE + " (" +
			INFO_ID + "," +
			INFO_PACKAGE_ID + "," +
			INFO_DATE + "," +
			INFO_LOCATION + "," +
			INFO_SITUATION +
			") VALUES (" +
			":" + INFO_ID + "," +
			":" + INFO_PACKAGE_ID + "," +
			":" + INFO_DATE + "," +
			":" + INFO_LOCATION + "," +
			":" + INFO_SITUATION + ")");
	bindValues(query, data, false);
}

void InfoCRUD::prepareUpdateQuery(QSqlQuery& query,
		const QVariantMap& data) const {
	query.prepare("UPDATE " + INFO_TABLE + " SET " +
			INFO_ID + " = :" + INFO_ID + ", " +
			INFO_PACKAGE_ID + " = :" + INFO_PACKAGE_ID + ", " +
			INFO_DATE + " = :" + INFO_DATE + ", " +
			INFO_LOCATION + " = :" + INFO_LOCATION + ", " +
			INFO_SITUATION + " = :" + INFO_SITUATION +
			" WHERE " + INFO_ID + " = :" + INFO_ID);
	bindValues(query, data, true);
}

const QVariantMap InfoCRUD::createModel(const QSqlQuery& query) const {
	QVariantMap map;
	map[INFO_ID] = query.value(0).toInt();
	map[INFO_PACKAGE_ID] = query.value(1).toInt();
	map[INFO_DATE] = query.value(2).toString();
	map[INFO_LOCATION] = query.value(3).toString();
	map[INFO_SITUATION] = query.value(4).toString();
	return map;
}

void InfoCRUD::bindValues(QSqlQuery& query, const QVariantMap& data,
		const bool& bindId) const {
	if (bindId)
		query.bindValue(":" + INFO_ID, data[INFO_ID].toInt());
	query.bindValue(":" + INFO_PACKAGE_ID, data[INFO_PACKAGE_ID].toInt());
	query.bindValue(":" + INFO_DATE, data[INFO_DATE].toString());
	query.bindValue(":" + INFO_LOCATION, data[INFO_LOCATION].toString());
	query.bindValue(":" + INFO_SITUATION, data[INFO_SITUATION].toString());
}

} /* namespace db */
