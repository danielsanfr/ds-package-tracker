/*
 * PackageCRUD.hpp
 *
 *  Created on: 27/03/2014
 *      Author: daniel
 */

#ifndef PACKAGECRUD_HPP_
#define PACKAGECRUD_HPP_

#include "DataBaseCRUD.hpp"

namespace db {

class PackageCRUD: public db::DataBaseCRUD {
public:
	PackageCRUD();
	virtual ~PackageCRUD();
	const QString getCRUDName() const;
	const QString getTableName() const;
	void prepareCreateQuery(QSqlQuery &query, const QVariantMap &data) const;
	void prepareUpdateQuery(QSqlQuery &query, const QVariantMap &data) const;
	const QVariantMap createModel(const QSqlQuery &query) const;
	void bindValues(QSqlQuery &query, const QVariantMap &data, const bool &bindId) const;
};

} /* namespace db */
#endif /* PACKAGECRUD_HPP_ */
