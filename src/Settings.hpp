/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: Settings.hpp
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

#ifndef SETTINGS_HPP_
#define SETTINGS_HPP_

#include <QDebug>
#include <QObject>
#include <QString>
#include <QVariant>
#include <QSettings>


class Settings: public QObject {
Q_OBJECT
Q_PROPERTY(const QString &objectName READ objectName NOTIFY objectNameChanged FINAL)
public:
	static Settings *getInstance(QObject *parent = 0) {
		static Settings *m_settings;
		if(!m_settings)
			m_settings = new Settings(parent);
		return m_settings;
	}
	virtual ~Settings();
	/**
	 * This Invokable function gets a value from the QSettings,
	 * if that value does not exist in the QSettings database, the default value is returned.
	 *
	 * @param objectName Index path to the item
	 * @param defaultValue Used to create the data in the database when adding
	 * @return If the objectName exists, the value of the QSettings object is returned.
	 * If the objectName doesn't exist, the default value is returned.
	 */
	Q_INVOKABLE
	QVariant getValueFor(const QString &objectName,
			const QVariant &defaultValue) const;
	/**
	 * This function sets a value in the QSettings database. This function should to be called
	 * when a data value has been updated from QML
	 *
	 * @param objectName Index path to the item
	 * @param inputValue new value to the QSettings database
	 */
	Q_INVOKABLE
	void saveValueFor(const QString &objectName, const QVariant &inputValue);
	void emitObjectName(const QString &objectName);
	Q_INVOKABLE const QString &objectName();
	Q_SIGNAL void objectNameChanged();
private:
	Settings(QObject * parent = 0);
	QString m_objectName;
};

#endif /* SETTINGS_HPP_ */
