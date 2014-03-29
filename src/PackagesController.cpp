/*
 * PackagesController.cpp
 *
 *  Created on: 28/03/2014
 *      Author: daniel
 */

#include "PackagesController.hpp"

using namespace brpackagetracking;
using namespace brpackagetracking::util;
using namespace db;

PackagesController::PackagesController(QObject *parent) :
		QObject(parent), m_dataBaseController(
				DataBaseController::getInstance(this)), m_util(
				Util::getInstance(this)) {
	foreach (QVariant package, m_dataBaseController->read()) {
		m_packagesMap.insert(package.toMap()["id"].toInt(), Package(package.toMap()["code"].toString(), this));
	}
}

PackagesController::~PackagesController() {
	// TODO Auto-generated destructor stub
}

void PackagesController::create(const QVariantMap& data) {
	m_dataBaseController->create(data);
}

int PackagesController::validateCode(const QString& code) {
	m_packageAux.setCode(code);
	return m_packageAux.validateCode();
}

QVariantList PackagesController::countyAndService() {
	return QVariantList() << m_packageAux.countryName() << m_packageAux.serviceName();
}
