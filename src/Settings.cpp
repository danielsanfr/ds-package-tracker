/*
 * Settings.cpp
 *
 *  Created on: 06/03/2014
 *      Author: daniel
 */

#include "Settings.hpp"

Settings::Settings(QObject *parent) : QObject(parent) {
	// TODO Auto-generated constructor stub
}

Settings::~Settings() {
	// TODO Auto-generated destructor stub
}

QString Settings::getValueFor(const QString objectName,
		const QString defaultValue) const {
	QSettings settings;
	// If no value has been saved, return the default value.
	if (settings.value(objectName).isNull()) {
		return defaultValue;
	}
	// Otherwise, return the value stored in the settings object.
	return settings.value(objectName).toString();
}

void Settings::saveValueFor(const QString objectName,
		const QString inputValue) {
    // A new value is saved to the application settings object.
    QSettings settings;
    settings.setValue(objectName, QVariant(inputValue));
}
