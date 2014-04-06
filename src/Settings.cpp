/*
 * Settings.cpp
 *
 *  Created on: 06/03/2014
 *      Author: daniel
 */

#include "Settings.hpp"

Settings::Settings(QObject *parent) : QObject(parent) {
	qDebug() << "Settings::Settings";
}

Settings::~Settings() {
	// TODO Auto-generated destructor stub
}

QVariant Settings::getValueFor(const QString& objectName,
		const QVariant& defaultValue) const {
	QSettings settings("Daniel San Ferreira da Rocha", "DS Package Tracking");
	// If no value has been saved, return the default value.
	if (settings.value(objectName).isNull()) {
		return defaultValue;
	}
	// Otherwise, return the value stored in the settings object.
	return settings.value(objectName);
}

void Settings::saveValueFor(const QString& objectName,
		const QVariant& inputValue) {
    // A new value is saved to the application settings object.
	QSettings settings("Daniel San Ferreira da Rocha", "DS Package Tracking");
    settings.setValue(objectName, inputValue);
	emitObjectName(objectName);
}

void Settings::emitObjectName(const QString &objectName) {
    m_objectName = "";
    emit objectNameChanged();
    m_objectName = objectName;
    emit objectNameChanged();
}

const QString &Settings::objectName() {
	return m_objectName;
}
