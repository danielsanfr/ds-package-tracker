/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: Settings.qml
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

import bb.cascades 1.0

Sheet {
    id: self
    property bool isFullVersion: false
    Page {
        titleBar: TitleBar {
            title: qsTr("Settings") + Retranslate.onLocaleOrLanguageChanged
            acceptAction: ActionItem {
                title: "Ok"
                onTriggered: {
                    self.close()
                }
            }
        }
        ScrollView {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            Container {
                topPadding: 20
                bottomPadding: 20
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                Container {
                    leftPadding: 20
                    rightPadding: 20
                    DropDown {
                        title: qsTr("Application theme") + Retranslate.onLocaleOrLanguageChanged
                        options: [
                            Option {
                                text: qsTr("System bright") + Retranslate.onLocaleOrLanguageChanged
                                value: "bright"
                            },
                            Option {
                                text: qsTr("System dark") + Retranslate.onLocaleOrLanguageChanged
                                value: "dark"
                            }
                        ]
                        onCreationCompleted: {
                            var selectedTheme = _settings.getValueFor("theme", "")
                            if (selectedTheme.toString() == "") {
                                selectedTheme = Application.themeSupport.theme.colorTheme.style
                                if (selectedTheme == VisualStyle.Bright)
                                    selectedIndex = 0;
                                else
                                    selectedIndex = 1
                            } else if (selectedTheme == "bright")
                                selectedIndex = 0;
                            else if (selectedTheme == "dark")
                                selectedIndex = 1
                        }
                        onSelectedValueChanged: {
                            _settings.saveValueFor("theme", selectedValue)
                        }
                    }
                    Container {
                        Label {
                            multiline: true
                            textStyle.textAlign: TextAlign.Justify
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            text: qsTr("Note: You must restart the application to apply this theme.") + Retranslate.onLocaleOrLanguageChanged
                        }
                    }
                }
                /*Divider {
                }
                Container {
                    topMargin: 20
                    leftPadding: 20
                    rightPadding: 20
                    horizontalAlignment: HorizontalAlignment.Fill
                    CheckBox {
                        id: chkBoxNotify
                        enabled: isFullVersion
                        text: qsTr("Notifications") + Retranslate.onLocaleOrLanguageChanged
                        onCreationCompleted: {
                            var notify = _settings.getValueFor("notify", false)
                            checked = notify
                        }
                        onCheckedChanged: {
                            _settings.saveValueFor("notify", checked)
                        }
                    }
                    DropDown {
                        enabled: chkBoxNotify.checked
                        title: qsTr("LED Color") + Retranslate.onLocaleOrLanguageChanged
                        Option {
                            text: qsTr("Red") + Retranslate.onLocaleOrLanguageChanged
                            imageSource: "asset:///images/red.png"
                        }
                        Option {
                            text: qsTr("Green") + Retranslate.onLocaleOrLanguageChanged
                            imageSource: "asset:///images/green.png"
                        }
                        Option {
                            text: qsTr("Blue") + Retranslate.onLocaleOrLanguageChanged
                            imageSource: "asset:///images/blue.png"
                        }
                        Option {
                            text: qsTr("Yellow") + Retranslate.onLocaleOrLanguageChanged
                            imageSource: "asset:///images/yellow.png"
                        }
                        Option {
                            text: qsTr("Cyan") + Retranslate.onLocaleOrLanguageChanged
                            imageSource: "asset:///images/cyan.png"
                        }
                        Option {
                            text: qsTr("Magenta") + Retranslate.onLocaleOrLanguageChanged
                            imageSource: "asset:///images/magenta.png"
                        }
                        Option {
                            text: qsTr("White") + Retranslate.onLocaleOrLanguageChanged
                            imageSource: "asset:///images/white.png"
                        }
                        onCreationCompleted: {
                            var selectedColor = _settings.getValueFor("led_color", 0)
                            selectedIndex = selectedColor
                        }
                        onSelectedIndexChanged: {
                            _settings.saveValueFor("led_color", selectedIndex)
                        }
                    }
                    DropDown {
                        title: qsTr("Sound") + Retranslate.onLocaleOrLanguageChanged
                        enabled: chkBoxNotify.checked
                        Option {
                            text: qsTr("Battery Alarm") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("Browser Start Event") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("Camera Burst Event") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("Camera Shutter Event") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("Device Lock Event") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("Device Unlock Event") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("Device Tether Event") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("Device Untether Event") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("General Notification") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("Input Keypress") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("Recording Start Event") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("Recording Stop Event") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("Sapphire Notification") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("System Master Volume Reference") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("Video Call Event") + Retranslate.onLocaleOrLanguageChanged
                        }
                        Option {
                            text: qsTr("Video Call Outgoing Event") + Retranslate.onLocaleOrLanguageChanged
                        }
                        onCreationCompleted: {
                            var selectedColor = _settings.getValueFor("sound", 8)
                            selectedIndex = selectedColor
                        }
                        onSelectedIndexChanged: {
                            _settings.saveValueFor("sound", selectedIndex)
                        }
                    }
                    Container {
                        topMargin: 20
                        horizontalAlignment: HorizontalAlignment.Fill
                        layout: DockLayout {
                        }
                        Label {
                            text: qsTr("Vibration") + Retranslate.onLocaleOrLanguageChanged
                            enabled: chkBoxNotify.checked
                            textStyle.fontSize: FontSize.Large
                            verticalAlignment: VerticalAlignment.Center
                        }
                        ToggleButton {
                            enabled: chkBoxNotify.checked
                            horizontalAlignment: HorizontalAlignment.Right
                            onCreationCompleted: {
                                var vibrate = _settings.getValueFor("vibrate", false)
                                checked = vibrate
                            }
                            onCheckedChanged: {
                                _settings.saveValueFor("vibrate", checked)
                            }
                        }
                    }
                }
                Divider {
                }
                Container {
                    topMargin: 20
                    leftPadding: 20
                    rightPadding: 20
                    horizontalAlignment: HorizontalAlignment.Fill
                    CheckBox {
                        id: chkBoxAutoRefresh
                        enabled: isFullVersion
                        text: qsTr("Automatic refresh") + Retranslate.onLocaleOrLanguageChanged
                        onCreationCompleted: {
                            var autoRefresh = _settings.getValueFor("auto_refresh", false)
                            checked = autoRefresh
                        }
                        onCheckedChanged: {
                            _settings.saveValueFor("auto_refresh", checked)
                        }
                    }
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Container {
                            Label {
                                text: qsTr("Refresh interval") + ": " + Retranslate.onLocaleOrLanguageChanged
                                textStyle.fontSize: FontSize.Large
                            }
                        }
                        Container {
                            Label {
                                id: lblUpdateTime
                                text: "0 h"
                                textStyle.fontSize: FontSize.Large
                            }
                        }
                    }
                    Slider {
                        property bool created: false
                        toValue: 24.0
                        fromValue: 1.0
                        enabled: chkBoxAutoRefresh.checked
                        horizontalAlignment: HorizontalAlignment.Fill
                        onCreationCompleted: {
                            var savedValue = _settings.getValueFor("auto_refresh_interval", 5.0)
                            setValue(savedValue)
                            created = true
                        }
                        onValueChanged: {
                            var newValue = Number(value).toFixed(0)
                            var rest = value - newValue
                            if (rest > 0.5)
                                ++ newValue
                            lblUpdateTime.text = newValue + " h"
                            setValue(newValue)
                            if (created)
                                _settings.saveValueFor("auto_refresh_interval", newValue)
                        }
                    }
                    Container {
                        Label {
                            multiline: true
                            textStyle.textAlign: TextAlign.Justify
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            text: qsTr("This is the time between updates of the status of the packages. But you can always upgrade the status of the packages by clicking the refresh button.") + Retranslate.onLocaleOrLanguageChanged
                        }
                    }
                }*/
            }
        }
    }
}