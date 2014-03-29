/*
 * PackageCRUD.cpp
 *
 *  Created on: 27/03/2014
 *      Author: daniel
 */

#include "PackageCRUD.hpp"

namespace db {

PackageCRUD::PackageCRUD() {
	// TODO Auto-generated constructor stub
}

PackageCRUD::~PackageCRUD() {
	// TODO Auto-generated destructor stub
}

const QString PackageCRUD::getCRUDName() const {
	return QString("PackageCRUD");
}

const QString PackageCRUD::getTableName() const {
	return PACKAGE_TABLE;
}

void PackageCRUD::prepareCreateQuery(QSqlQuery& query,
		const QVariantMap& data) const {
	query.prepare("INSERT INTO " + PACKAGE_TABLE + " (" +
			PACKAGE_ID + "," +
			PACKAGE_STATUS + "," +
			PACKAGE_CREATED + "," +
			PACKAGE_LAST_UPDATE + "," +
			PACKAGE_SITUATION + "," +
			PACKAGE_SHORT_DESCR + "," +
			PACKAGE_CODE + "," +
			PACKAGE_SENDING + "," +
			PACKAGE_URL_TO_STORE + "," +
			PACKAGE_DESCRIPTION + "," +
			PACKAGE_EMAILS +
			") VALUES (" +
			":" + PACKAGE_ID + "," +
			":" + PACKAGE_STATUS + "," +
			":" + PACKAGE_CREATED + "," +
			":" + PACKAGE_LAST_UPDATE + "," +
			":" + PACKAGE_SITUATION + "," +
			":" + PACKAGE_SHORT_DESCR + "," +
			":" + PACKAGE_CODE + "," +
			":" + PACKAGE_SENDING + "," +
			":" + PACKAGE_URL_TO_STORE + "," +
			":" + PACKAGE_DESCRIPTION + "," +
			":" + PACKAGE_EMAILS + ")");
	bindValues(query, data, false);
}

void PackageCRUD::prepareUpdateQuery(QSqlQuery& query,
		const QVariantMap& data) const {
	query.prepare("UPDATE " + PACKAGE_TABLE + " SET " +
			PACKAGE_STATUS + " = :" + PACKAGE_STATUS + ", " +
			PACKAGE_CREATED + " = :" + PACKAGE_CREATED + ", " +
			PACKAGE_LAST_UPDATE + " = :" + PACKAGE_LAST_UPDATE + ", " +
			PACKAGE_SITUATION + " = :" + PACKAGE_SITUATION + ", " +
			PACKAGE_SHORT_DESCR + " = :" + PACKAGE_SHORT_DESCR + ", " +
			PACKAGE_CODE + " = :" + PACKAGE_CODE + ", " +
			PACKAGE_SENDING + " = :" + PACKAGE_SENDING + ", " +
			PACKAGE_URL_TO_STORE + " = :" + PACKAGE_URL_TO_STORE + ", " +
			PACKAGE_DESCRIPTION + " = :" + PACKAGE_DESCRIPTION + ", " +
			PACKAGE_EMAILS + " = :" + PACKAGE_EMAILS +
			" WHERE " + PACKAGE_ID + " = :" + PACKAGE_ID);
	bindValues(query, data, true);
}

const QVariantMap PackageCRUD::createModel(const QSqlQuery& query) const {
	QVariantMap map;
	map[PACKAGE_ID] = query.value(0).toInt();
	map[PACKAGE_STATUS] = query.value(1).toString();
	map[PACKAGE_CREATED] = query.value(2).toString();
	map[PACKAGE_LAST_UPDATE] = query.value(3).toDate();
	map[PACKAGE_SITUATION] = query.value(4).toString();
	map[PACKAGE_SHORT_DESCR] = query.value(5).toString();
	map[PACKAGE_CODE] = query.value(6).toString();
	map[PACKAGE_SENDING] = query.value(7).toBool();
	map[PACKAGE_URL_TO_STORE] = query.value(8).toUrl();
	map[PACKAGE_DESCRIPTION] = query.value(9).toString();
	map[PACKAGE_EMAILS] = query.value(10).toString();
	return map;
}

void PackageCRUD::bindValues(QSqlQuery& query, const QVariantMap& data,
		const bool& bindId) const {
	if (bindId)
		query.bindValue(":" + PACKAGE_ID, data[PACKAGE_ID].toInt());
	query.bindValue(":" + PACKAGE_STATUS, data[PACKAGE_STATUS].toString());
	query.bindValue(":" + PACKAGE_CREATED, data[PACKAGE_CREATED].toString());
	query.bindValue(":" + PACKAGE_LAST_UPDATE, data[PACKAGE_LAST_UPDATE].toDate());
	query.bindValue(":" + PACKAGE_SITUATION, data[PACKAGE_SITUATION].toString());
	query.bindValue(":" + PACKAGE_SHORT_DESCR, data[PACKAGE_SHORT_DESCR].toString());
	query.bindValue(":" + PACKAGE_CODE, data[PACKAGE_CODE].toString());
	query.bindValue(":" + PACKAGE_SENDING, data[PACKAGE_SENDING].toBool());
	if (data[PACKAGE_URL_TO_STORE].toString() == "")
		query.bindValue(":" + PACKAGE_URL_TO_STORE, QVariant());
	else
		query.bindValue(":" + PACKAGE_URL_TO_STORE, data[PACKAGE_URL_TO_STORE].toString());
	if (data[PACKAGE_DESCRIPTION].toString() == "")
		query.bindValue(":" + PACKAGE_DESCRIPTION, QVariant());
	else
		query.bindValue(":" + PACKAGE_DESCRIPTION, data[PACKAGE_DESCRIPTION].toString());
	if (data[PACKAGE_EMAILS].toString() == "")
		query.bindValue(":" + PACKAGE_EMAILS, QVariant());
	else
		query.bindValue(":" + PACKAGE_EMAILS, data[PACKAGE_EMAILS].toString());
}

} /* namespace db */
