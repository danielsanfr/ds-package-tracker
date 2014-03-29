/*
 * TableDefinitions.hpp
 *
 *  Created on: 09/02/2014
 *      Author: dielson
 */

#ifndef TABLEDEFINITIONS_HPP_
#define TABLEDEFINITIONS_HPP_

#include <QString>

#define DB_PATH QString("./data/dspackagetracking.db")

#define PACKAGE_TABLE			QString("package")
#define PACKAGE_ID				QString("id")
#define PACKAGE_STATUS			QString("status")
#define PACKAGE_CREATED			QString("created_date")
#define PACKAGE_LAST_UPDATE		QString("last_update_date")
#define PACKAGE_SITUATION		QString("last_situation")
#define PACKAGE_SHORT_DESCR		QString("short_descr")
#define PACKAGE_CODE			QString("code")
#define PACKAGE_SENDING			QString("sending")
#define PACKAGE_URL_TO_STORE	QString("url_to_store")
#define PACKAGE_DESCRIPTION		QString("description")
#define PACKAGE_EMAILS			QString("emails")

#define INFO_TABLE				QString("infos")
#define INFO_ID					QString("id")
#define INFO_PACKAGE_ID			QString("package_id")
#define INFO_DATE				QString("date")
#define INFO_LOCATION			QString("location")
#define INFO_SITUATION			QString("situation")

#endif /* TABLEDEFINITIONS_HPP_ */
