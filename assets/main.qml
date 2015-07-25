/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: main.qml
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


import bb.system 1.0
import bb.cascades 1.0

TabbedPane {
    //    property bool isFullVersion: false
    property string settingsObjectName: _settings.objectName
    attachedObjects: [
        ComponentDefinition {
            id: settingsDefinition
            Settings {
            }
        },
        ComponentDefinition {
            id: aboutDefinition
            About {
            }
        },
        SystemDialog {
            id: sysDlg
        }
    ]
    Menu.definition: MenuDefinition {
//        helpAction: HelpActionItem {
//            onTriggered: {
                //                helpSheet.createObject().open()
//            }
//        }
        settingsAction: SettingsActionItem {
            onTriggered: {
                settingsDefinition.createObject().open()
            }
        }
        actions: [
            ActionItem {
                title: qsTr("About") + Retranslate.onLocaleOrLanguageChanged
                imageSource: "asset:///images/ic_info.png"
                onTriggered: {
                    aboutDefinition.createObject().open()
                }
            },
            ActionItem {
                title: qsTr("Invite") + Retranslate.onLocaleOrLanguageChanged
                imageSource: "asset:///images/ic_bbm.png"
                onTriggered: {
                    _app.sendInvite();
                }
            }
        ]
    }
    tabs: [
        Tab {
            title: qsTr("On the way") + Retranslate.onLocaleOrLanguageChanged
//            newContentAvailable: true
            imageSource: "asset:///images/ic_peding.png"
            PackagesListView {
                title: qsTr("Packages on the way") + Retranslate.onLocaleOrLanguageChanged
                onCreationCompleted: {
                    var args = {
                        ":status": "pending"
                    }
                    load(args, "status=:status")
                }
            }
        },
        Tab {
            title: qsTr("Delivered") + Retranslate.onLocaleOrLanguageChanged
//            newContentAvailable: true
            imageSource: "asset:///images/ic_delivered.png"
            PackagesListView {
                title: qsTr("Delivered packages") + Retranslate.onLocaleOrLanguageChanged
                onCreationCompleted: {
                    var args = {
                        ":status": "delivered"
                    }
                    load(args, "status=:status")
                }
            }
/*        },
        Tab {
            title: qsTr("Archived") + Retranslate.onLocaleOrLanguageChanged
            description: qsTr("Available for full version") + Retranslate.onLocaleOrLanguageChanged
            imageSource: "asset:///images/ic_archived.png"
            enabled: isFullVersion
            PackagesListView {
                title: qsTr("Archived packages") + Retranslate.onLocaleOrLanguageChanged
                onCreationCompleted: {
                    var args = {
                        ":status": "archived"
                    }
                    load(args, "status=:status")
                }
            }
        },
        Tab {
            title: qsTr("Statistics") + Retranslate.onLocaleOrLanguageChanged
            description: qsTr("Available for full version") + Retranslate.onLocaleOrLanguageChanged
            imageSource: "asset:///images/ic_statistics.png"
            enabled: isFullVersion
            Statistics {
            }*/
        }
    ]
    onSettingsObjectNameChanged: {
        var firstOpened = _settings.getValueFor("first_opened", true)
        if (firstOpened === true) {
            _settings.saveValueFor("first_opened", false)
            sysDlg.title = qsTr("Warning") + Retranslate.onLocaleOrLanguageChanged
            sysDlg.body = qsTr("Unfortunately it is no longer interesting to develop for BlackBerry 10.\nI will be making available the source code of this application on GitHub, so that those who want to continue their development, can do it.\nBut if only 5 people contact me (in the About screen) asking to develop the paid version, I'll be very happy to do it!") + Retranslate.onLocaleOrLanguageChanged
            sysDlg.show()
        }
    }
}