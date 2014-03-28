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
			PACKAGE_CREATED + "," +
			PACKAGE_LAST_UPDATE + "," +
			PACKAGE_SHORT_DESCR + "," +
			PACKAGE_CODE + "," +
			PACKAGE_SENDING + "," +
			PACKAGE_DESCRIPTION +
			") VALUES (" +
			":" + PACKAGE_ID + "," +
			":" + PACKAGE_CREATED + "," +
			":" + PACKAGE_LAST_UPDATE + "," +
			":" + PACKAGE_SHORT_DESCR + "," +
			":" + PACKAGE_CODE + "," +
			":" + PACKAGE_SENDING + "," +
			":" + PACKAGE_DESCRIPTION + ")");
	bindValues(query, data, false);
}

void PackageCRUD::prepareUpdateQuery(QSqlQuery& query,
		const QVariantMap& data) const {
	query.prepare("UPDATE " + PACKAGE_TABLE + " SET " +
			PACKAGE_CREATED + " = :" + PACKAGE_CREATED + ", " +
			PACKAGE_LAST_UPDATE + " = :" + PACKAGE_LAST_UPDATE + ", " +
			PACKAGE_SHORT_DESCR + " = :" + PACKAGE_SHORT_DESCR + ", " +
			PACKAGE_CODE + " = :" + PACKAGE_CODE + ", " +
			PACKAGE_SENDING + " = :" + PACKAGE_SENDING + ", " +
			PACKAGE_DESCRIPTION + " = :" + PACKAGE_DESCRIPTION +
			" WHERE " + PACKAGE_ID + " = :" + PACKAGE_ID);
	bindValues(query, data, true);
}

const QVariantMap PackageCRUD::createModel(const QSqlQuery& query) const {
	QVariantMap map;
	map[PACKAGE_ID] = query.value(0).toInt();
	map[PACKAGE_CREATED] = query.value(1).toString();
	map[PACKAGE_LAST_UPDATE] = query.value(2).toDate();
	map[PACKAGE_SHORT_DESCR] = query.value(3).toString();
	map[PACKAGE_CODE] = query.value(4).toString();
	map[PACKAGE_SENDING] = query.value(5).toBool();
	map[PACKAGE_DESCRIPTION] = query.value(6).toString();
	return map;
}

void PackageCRUD::bindValues(QSqlQuery& query, const QVariantMap& data,
		const bool& bindId) const {
	if (bindId)
		query.bindValue(":" + PACKAGE_ID, data[PACKAGE_ID].toInt());
	query.bindValue(":" + PACKAGE_CREATED, data[PACKAGE_CREATED].toString());
	query.bindValue(":" + PACKAGE_LAST_UPDATE, data[PACKAGE_LAST_UPDATE].toDate());
	query.bindValue(":" + PACKAGE_SHORT_DESCR, data[PACKAGE_SHORT_DESCR].toString());
	query.bindValue(":" + PACKAGE_CODE, data[PACKAGE_CODE].toString());
	query.bindValue(":" + PACKAGE_SENDING, data[PACKAGE_SENDING].toBool());
	query.bindValue(":" + PACKAGE_DESCRIPTION, data[PACKAGE_DESCRIPTION].toString());
}

} /* namespace db */
