/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: Settings.cpp
 *     Author: daniel
 * Created on: 06/03/2014
 *    Version:
 *
 * This file is part of the DS Package Tracker.
 *
 * DS Package Tracker is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 3 of the
 * License, or (at your option) any later version.
 *
 * DS Package Tracker is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with DS Package Tracker. If not, see <http://www.gnu.org/licenses/>.
 *
 ***************************************************************************/

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
