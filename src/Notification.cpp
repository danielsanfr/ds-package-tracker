/*
 * Notification.cpp
 *
 *  Created on: 29/03/2014
 *      Author: daniel
 */

#include "Notification.hpp"

using namespace bb::device;
using namespace bb::multimedia;
using namespace bb::platform;

::Notification::Notification(QObject* parent) :
		QObject(parent), m_led(new Led(this)), m_vibrationCtrl(
				new VibrationController(this)), m_notification(
				new bb::platform::Notification(this)), m_notificationDialog(
				new NotificationDialog(this)) {
}

::Notification::~Notification() {
}

void ::Notification::testLED() {
	Settings *settings = Settings::getInstance(this);
	int selectedColor = settings->getValueFor("led_color", 0).toInt();
	switch (selectedColor) {
	case 1:
		m_led->setColor(LedColor::Green);
		break;
	case 2:
		m_led->setColor(LedColor::Blue);
		break;
	case 3:
		m_led->setColor(LedColor::Yellow);
		break;
	case 4:
		m_led->setColor(LedColor::Cyan);
		break;
	case 5:
		m_led->setColor(LedColor::Magenta);
		break;
	case 6:
		m_led->setColor(LedColor::White);
		break;
	case 0:
	default:
		m_led->setColor(LedColor::Red);
		break;
	}
	qDebug() << "Notification::testLED:" << selectedColor << m_led->color()
			<< LedColor::toName(m_led->color());
	m_led->flash(3);
	if (m_vibrationCtrl->isSupported())
		m_vibrationCtrl->start(80, 1000);
	int selectedSound = settings->getValueFor("sound", 0).toInt();
	switch (selectedSound) {
	case 0:
		SystemSound::play(SystemSound::BatteryAlarm);
		break;
	case 1:
		SystemSound::play(SystemSound::BrowserStartEvent);
		break;
	case 2:
		SystemSound::play(SystemSound::CameraBurstEvent);
		break;
	case 3:
		SystemSound::play(SystemSound::CameraShutterEvent);
		break;
	case 4:
		SystemSound::play(SystemSound::DeviceLockEvent);
		break;
	case 5:
		SystemSound::play(SystemSound::DeviceUnlockEvent);
		break;
	case 6:
		SystemSound::play(SystemSound::DeviceTetherEvent);
		break;
	case 7:
		SystemSound::play(SystemSound::DeviceUntetherEvent);
		break;
	case 8:
	default:
		SystemSound::play(SystemSound::GeneralNotification);
		break;
	case 9:
		SystemSound::play(SystemSound::InputKeypress);
		break;
	case 10:
		SystemSound::play(SystemSound::RecordingStartEvent);
		break;
	case 11:
		SystemSound::play(SystemSound::RecordingStopEvent);
		break;
	case 12:
		SystemSound::play(SystemSound::SapphireNotification);
		break;
	case 13:
		SystemSound::play(SystemSound::SystemMasterVolumeReference);
		break;
	case 14:
		SystemSound::play(SystemSound::VideoCallEvent);
		break;
	case 15:
		SystemSound::play(SystemSound::VideoCallOutgoingEvent);
		break;
	}
	m_notification->setTitle("TITLE");
	m_notification->setBody("BODY");
	ApplicationInfo appInfo;
	m_notification->setSoundUrl(appInfo.currentPath() + QString("/app/public/silence.wav"));
	m_notification->notify();
}
