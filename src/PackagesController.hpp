/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: PackagesController.cpp
 *     Author: daniel
 * Created on: 28/03/2014
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

#ifndef PACKAGESCONTROLLER_HPP_
#define PACKAGESCONTROLLER_HPP_

#include <QMap>
#include <QDate>
#include <QList>
#include <QTimer>
#include <QDebug>
#include <QObject>
#include <QString>
#include <QVariant>
#include <QVariantMap>
#include <QVariantList>
#include <QSharedPointer>
#include <QNetworkConfigurationManager>

#include "brpackagetracking/util/util.h"
#include "brpackagetracking/package.h"

#include "Settings.hpp"
#include "db/DataBaseController.hpp"

class PackagesController: public QObject {
	Q_OBJECT
public:
    static PackagesController *getInstance(QObject *parent = 0) {
        static PackagesController *m_packagesController;
        if (!m_packagesController)
        	m_packagesController = new PackagesController(parent);
        return m_packagesController;
    }
	virtual ~PackagesController();
	Q_INVOKABLE void create(const QVariantMap& data);
	Q_INVOKABLE int validateCode(const QString& code);
	Q_INVOKABLE QVariantList countyAndService();
	Q_INVOKABLE QVariantList informationList(const int &id);
	Q_INVOKABLE bool update();
	Q_INVOKABLE void update(const int &id);
	Q_INVOKABLE void debug(const QString &file, const int &line, const QVariant &data);
	Q_SIGNAL void load(const QString &code);
private:
	PackagesController(QObject *parent = 0);
	QVariantMap informationToMap(const brpackagetracking::model::Information &info);
	Q_SLOT void onReLoad(int uuid, const QString &tableName);
	Q_SLOT void handler(brpackagetracking::Package* package);
	Q_SLOT void handlerError(QString message);
	Q_SLOT void onTimeout();
	int idByCode(const QString &code);
	bool connectionTest();
	db::DataBaseController *m_dataBaseController;
	brpackagetracking::util::Util *m_util;
	brpackagetracking::Package m_packageAux;
	QMap<int, QSharedPointer<brpackagetracking::Package> > m_packagesMap;
	int m_uuid;
	int m_updateCounter;
	QTimer *m_timer;
	bool m_cretion;
};

#endif /* PACKAGESCONTROLLER_HPP_ */
