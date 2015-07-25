/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: applicationui.cpp
 *     Author: daniel
 * Created on:
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

#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QDebug>
#include <QObject>
#include <QByteArray>
#include <QVariantMap>
#include <QVariantList>

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/PpsObject>
#include <bb/system/InvokeManager>
#include <bb/system/InvokeTargetReply>

#include "social/InviteToDownload.hpp"
#include "social/RegistrationHandler.hpp"

#include "brpackagetracking/package.h"

#include "PackagesController.hpp"
#include "Settings.hpp"
#include "ActiveFrameQML.hpp"
#include "applicationinfo.hpp"
#include "Notification.hpp"
#include "model/SqlDataModel.hpp"
#include "db/DataBaseController.hpp"

namespace bb
{
    namespace cascades
    {
        class Application;
        class LocaleHandler;
    }
}

class QTranslator;

/*!
 * @brief Application object
 *
 *
 */

class ApplicationUI : public QObject
{
    Q_OBJECT
public:
    ApplicationUI(bb::cascades::Application *app);
    virtual ~ApplicationUI() { }
    Q_INVOKABLE void sendInvite();
    Q_INVOKABLE void sendEmail();
    Q_INVOKABLE QByteArray encode(const QVariantMap &data, bool *ok = 0);
private slots:
    void onSystemLanguageChanged();
private:
    QTranslator* m_pTranslator;
    bb::cascades::LocaleHandler* m_pLocaleHandler;
    InviteToDownload *m_inviteToDownload;
};

#endif /* ApplicationUI_HPP_ */
