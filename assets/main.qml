/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.0

TabbedPane {
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
        }
    ]
    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
            onTriggered: {
                //                helpSheet.createObject().open()
            }
        }
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
                    //                    _viewController.callBBMCard();
                }
            }
        ]
    }
    tabs: [
        Tab {
            title: qsTr("Pending") + Retranslate.onLocaleOrLanguageChanged
            newContentAvailable: true
            imageSource: "asset:///images/ic_peding.png"
            PackagesListView {
                title: qsTr("Pending packages")
            }
        },
        Tab {
            title: qsTr("Delivered") + Retranslate.onLocaleOrLanguageChanged
            newContentAvailable: true
            imageSource: "asset:///images/ic_delivered.png"
            PackagesListView {
                title: qsTr("Delivered packages")
            }
        },
        Tab {
            title: qsTr("Archived") + Retranslate.onLocaleOrLanguageChanged
            imageSource: "asset:///images/ic_archived.png"
            PackagesListView {
                title: qsTr("Archived packages")
            }
        },
        Tab {
            title: qsTr("Statistics") + Retranslate.onLocaleOrLanguageChanged
            imageSource: "asset:///images/ic_statistics.png"
            Statistics {
            }
        }
    ]
}