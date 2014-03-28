/*
 * EmailCRUD.hpp
 *
 *  Created on: 27/03/2014
 *      Author: daniel
 */

#ifndef EMAILCRUD_HPP_
#define EMAILCRUD_HPP_

#include "DataBaseCRUD.hpp"

namespace db {

class EmailCRUD: public db::DataBaseCRUD {
public:
	EmailCRUD();
	virtual ~EmailCRUD();
	const QString getCRUDName() const;
	const QString getTableName() const;
	void prepareCreateQuery(QSqlQuery &query, const QVariantMap &data) const;
	void prepareUpdateQuery(QSqlQuery &query, const QVariantMap &data) const;
	const QVariantMap createModel(const QSqlQuery &query) const;
	void bindValues(QSqlQuery &query, const QVariantMap &data, const bool &bindId) const;
};

} /* namespace db */
#endif /* EMAILCRUD_HPP_ */
