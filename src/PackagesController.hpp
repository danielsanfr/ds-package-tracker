/*
 * PackagesController.hpp
 *
 *  Created on: 28/03/2014
 *      Author: daniel
 */

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
