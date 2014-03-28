/*
 * EmailCRUD.cpp
 *
 *  Created on: 27/03/2014
 *      Author: daniel
 */

#include "EmailCRUD.hpp"

namespace db {

EmailCRUD::EmailCRUD() {
	// TODO Auto-generated constructor stub
}

EmailCRUD::~EmailCRUD() {
	// TODO Auto-generated destructor stub
}

const QString EmailCRUD::getCRUDName() const {
	return QString("EmailCRUD");
}

const QString EmailCRUD::getTableName() const {
	return EMAIL_TABLE;
}

void EmailCRUD::prepareCreateQuery(QSqlQuery& query,
		const QVariantMap& data) const {
	query.prepare("INSERT INTO " + EMAIL_TABLE + " (" +
			EMAIL_PACKAGE_ID + "," +
			EMAIL_CONTENT +
			") VALUES (" +
			":" + EMAIL_PACKAGE_ID + "," +
			":" + EMAIL_CONTENT + ")");
	bindValues(query, data, false);
}

void EmailCRUD::prepareUpdateQuery(QSqlQuery& query,
		const QVariantMap& data) const {
	query.prepare("UPDATE " + EMAIL_TABLE + " SET " +
			EMAIL_PACKAGE_ID + " = :" + EMAIL_PACKAGE_ID + ", " +
			EMAIL_CONTENT + " = :" + EMAIL_CONTENT +
			" WHERE " + EMAIL_PACKAGE_ID + " = :" + EMAIL_PACKAGE_ID);
	bindValues(query, data, true);
}

const QVariantMap EmailCRUD::createModel(const QSqlQuery& query) const {
	QVariantMap map;
	map[EMAIL_PACKAGE_ID] = query.value(0).toInt();
	map[EMAIL_CONTENT] = query.value(1).toString();
	return map;
}

void EmailCRUD::bindValues(QSqlQuery& query, const QVariantMap& data,
		const bool& bindId) const {
	Q_UNUSED(bindId);
	query.bindValue(":" + EMAIL_PACKAGE_ID, data[EMAIL_PACKAGE_ID].toInt());
	query.bindValue(":" + EMAIL_CONTENT, data[EMAIL_CONTENT].toString());
}

} /* namespace db */
