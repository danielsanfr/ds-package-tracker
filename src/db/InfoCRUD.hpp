/*
 * InfoCRUD.hpp
 *
 *  Created on: 27/03/2014
 *      Author: daniel
 */

#ifndef INFOCRUD_HPP_
#define INFOCRUD_HPP_

#include "DataBaseCRUD.hpp"

namespace db {

class InfoCRUD: public db::DataBaseCRUD {
public:
	InfoCRUD();
	virtual ~InfoCRUD();
	const QString getCRUDName() const;
	const QString getTableName() const;
	void prepareCreateQuery(QSqlQuery &query, const QVariantMap &data) const;
	void prepareUpdateQuery(QSqlQuery &query, const QVariantMap &data) const;
	const QVariantMap createModel(const QSqlQuery &query) const;
	void bindValues(QSqlQuery &query, const QVariantMap &data, const bool &bindId) const;
};

} /* namespace db */
#endif /* INFOCRUD_HPP_ */
