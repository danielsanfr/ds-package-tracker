/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: Notification.hpp
 *     Author: daniel
 * Created on: 29/03/2014
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

#ifndef NOTIFICATION_HPP_
#define NOTIFICATION_HPP_

#include <QUrl>
#include <QDebug>
#include <QObject>

#include <bb/device/Led>
#include <bb/device/VibrationController>
#include <bb/multimedia/SystemSound>
#include <bb/platform/Notification>
#include <bb/platform/NotificationDialog>

#include "Settings.hpp"
#include "applicationinfo.hpp"

class Notification: public QObject {
Q_OBJECT
public:
	Notification(QObject *parent = 0);
	~Notification();
	Q_INVOKABLE void testLED();
private:
	bb::device::Led *m_led;
	bb::device::VibrationController *m_vibrationCtrl;
	bb::platform::Notification *m_notification;
	bb::platform::NotificationDialog *m_notificationDialog;
};

#endif /* NOTIFICATION_HPP_ */
