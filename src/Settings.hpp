/*
 * Settings.hpp
 *
 *  Created on: 06/03/2014
 *      Author: daniel
 */

#ifndef SETTINGS_HPP_
#define SETTINGS_HPP_

#include <QDebug>
#include <QObject>
#include <QString>
#include <QVariant>
#include <QSettings>

class Settings: public QObject {
Q_OBJECT
public:
	Settings(QObject * parent = 0);
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
};

#endif /* SETTINGS_HPP_ */
