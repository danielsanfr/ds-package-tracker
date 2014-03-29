/*
 * Notification.hpp
 *
 *  Created on: 29/03/2014
 *      Author: daniel
 */

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
