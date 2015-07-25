import bb.system 1.0
import bb.cascades 1.0
import model.custom 1.0
import bb.cascades.advertisement 1.0

NavigationPane {
    id: navigationPane
//    property bool isFullVersion: false
    property alias title: titleBar.title
    onPopTransitionEnded: {
        page.destroy()
    }
    function load(args, conditions) {
        ctnHaveCtnLastUpdate.visible = (args[":status"] == "pending")
        dtMd.load(args, conditions)
    }
    Page {
        titleBar: TitleBar {
            id: titleBar
        }
        attachedObjects: [
            ComponentDefinition {
                id: addPackageDefinition
                AddPackage {
                }
            },
            SqlDataModel {
                id: dtMd
                table: "package"
                onSizeChanged: {
                    var length = dtMd.size()
                    if (length == 0)
                        emptyListMessage.visible = true
                    else
                    	emptyListMessage.visible = false
                }
            }
        ]
        actions: [
            ActionItem {
                title: qsTr("Add") + Retranslate.onLocaleOrLanguageChanged
                imageSource: "asset:///images/ic_add_package.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                attachedObjects: [
                    SystemToast {
                        id: sysTst
                        body: qsTr("More than 5 packs only in the full version") + Retranslate.onLocaleOrLanguageChanged
                    }
                ]
                onTriggered: {
                    _db.setTableName("package")
//                    if (isFullVersion || _db.count() < 5)
                        addPackageDefinition.createObject(navigationPane).open();
//                    else
//                        sysTst.show()
                }
            },
//            ActionItem {
//                title: qsTr("Search") + Retranslate.onLocaleOrLanguageChanged
//                imageSource: "asset:///images/ic_search.png"
//                enabled: isFullVersion
//                onTriggered: {
//                    searchDelagate.delegateActive = ! searchDelagate.delegateActive
//                }
//            },
            ActionItem {
                title: qsTr("Refresh") + Retranslate.onLocaleOrLanguageChanged
                imageSource: "asset:///images/ic_reload.png"
                attachedObjects: [
                    SystemToast {
                        id: sysTstConnected
                        body: qsTr("Check your internet connection.") + Retranslate.onLocaleOrLanguageChanged
                    }
                ]
                onTriggered: {
                    ctnLastUpdate.visible = true
                    if (! _packageCtrl.update())
                        sysTstConnected.show();
                    else
                        actIndRefresh.running = true
                }
            }
        ]
        Container {
            attachedObjects: [
                ComponentDefinition {
                    id: searchCtnDefinition
                    Container {
                        topPadding: 10
                        horizontalAlignment: HorizontalAlignment.Fill
                        Container {
                            leftPadding: 20
                            rightPadding: 20
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            TextField {
                                id: txtFldSearch
                                verticalAlignment: VerticalAlignment.Center
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 2.8
                                }
                                onTextChanged: {
                                }
                            }
                            Button {
                                text: qsTr("Cancel") + Retranslate.onLocaleOrLanguageChanged
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1.2
                                }
                                onClicked: {
                                    txtFldSearch.text = ""
                                    searchDelagate.delegateActive = ! searchDelagate.delegateActive
                                }
                            }
                        }
                        Container {
                            topMargin: 10
                            Divider {
                            }
                        }
                    }
                }
            ]
            Container {
                id: ctnHaveCtnLastUpdate
                Container {
                    id: ctnLastUpdate
                    property int count: 1
                    property string savedValue: _settings.objectName
                    layout: DockLayout {
                    }
                    onSavedValueChanged: {
                        if (savedValue == "last_update_date") {
                            if (count == 0)
                                ctnLastUpdate.visible = false;
                            else {
                                var aux = count
                                count = -- aux
                            }
                            actIndRefresh.running = false
                            hdrLastUpdate.title = qsTr("Last update") + ": " + _settings.getValueFor("last_update_date", new Date()).toDateString() + Retranslate.onLocaleOrLanguageChanged
                        }
                    }
                    Header {
                        id: hdrLastUpdate
                    }
                    Container {
                        rightPadding: 15
                        bottomPadding: 3
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Right
                        ActivityIndicator {
                            id: actIndRefresh
                            maxHeight: 100
                            running: false
                        }
                    }
                }
            }
            ControlDelegate {
                id: searchDelagate
                delegateActive: false
                sourceComponent: searchCtnDefinition
            }
            Container {
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                layout: DockLayout {
                }
                ScrollView {
                    id: emptyListMessage
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    EmptyListMessage {
                        visible: emptyListMessage.visible
                        title: qsTr("You don't have packages") + Retranslate.onLocaleOrLanguageChanged
                        description: qsTr("Add a package by clicking on the action \"Add\" which is just below the action bar.") + Retranslate.onLocaleOrLanguageChanged
                    }
                }
                ListView {
                    visible: !emptyListMessage.visible
                    dataModel: dtMd
//                    leadingVisual: Container {
//                        topPadding: 20
//                        leftPadding: 20
//                        rightPadding: 20
//                        DropDown {
//                            title: qsTr("Sort by") + Retranslate.onLocaleOrLanguageChanged
//                            options: [
//                                Option {
//                                    text: qsTr("Sending") + Retranslate.onLocaleOrLanguageChanged
//                                },
//                                Option {
//                                    text: qsTr("Tag") + Retranslate.onLocaleOrLanguageChanged
//                                },
//                                Option {
//                                    text: qsTr("Code") + Retranslate.onLocaleOrLanguageChanged
//                                },
//                                Option {
//                                    text: qsTr("Country") + Retranslate.onLocaleOrLanguageChanged
//                                },
//                                Option {
//                                    text: qsTr("Service") + Retranslate.onLocaleOrLanguageChanged
//                                },
//                                Option {
//                                    text: qsTr("Date")
//                                    selected: true
//                                }
//                            ]
//                        }
//                        Divider {
//                        }
//                    }
                    listItemComponents: [
                        ListItemComponent {
                            PackageListItem {
                                id: lstItm
                                contextActions: [
                                    ActionSet {
                                        title: qsTr("Package's action") + Retranslate.onLocaleOrLanguageChanged
                                        attachedObjects: [
                                            SystemDialog {
                                                id: sysDlg
                                                property variant pack
                                                property bool delPgk: false
                                                onFinished: {
                                                    if (value == SystemUiResult.ConfirmButtonSelection) {
                                                        var del = delPgk
                                                        if (! del) {
                                                            var pkg = pack
                                                            lstItm.ListItem.view.dataModel.update(pkg)
                                                        } else
                                                            lstItm.ListItem.view.dataModel.deleteRecord(lstItm.ListItem.indexPath)
                                                    }
                                                }
                                            }
                                        ]
                                        ActionItem {
                                            title: qsTr("Edit") + Retranslate.onLocaleOrLanguageChanged
                                            imageSource: "asset:///images/ic_edit.png"
                                            enabled: false
                                            onTriggered: {
                                            }
                                        }
                                        ActionItem {
                                            title: qsTr("Mark as delivered") + Retranslate.onLocaleOrLanguageChanged
                                            imageSource: "asset:///images/ic_delivered.png"
                                            enabled: (ListItemData.status != "delivered")
                                            onTriggered: {
                                                var pack = ListItemData
                                                pack["status"] = "delivered"
                                                sysDlg.title = qsTr("Mark as delivered") + Retranslate.onLocaleOrLanguageChanged
                                                sysDlg.body = qsTr("You would like to mark this package as delivered") + "?" + Retranslate.onLocaleOrLanguageChanged
                                                sysDlg.pack = pack
                                                sysDlg.delPgk = false
                                                sysDlg.show()
                                            }
                                        }
//                                        ActionItem {
//                                            property bool isFullVersion: false
//                                            title: qsTr("Archive") + Retranslate.onLocaleOrLanguageChanged
//                                            imageSource: "asset:///images/ic_archived.png"
//                                            enabled: isFullVersion && (ListItemData.status != "archived")
//                                            onTriggered: {
//                                                var pack = ListItemData
//                                                pack["status"] = "archived"
//                                                sysDlg.title = qsTr("Archive") + Retranslate.onLocaleOrLanguageChanged
//                                                sysDlg.body = qsTr("Would you like to archive this package") + "?" + Retranslate.onLocaleOrLanguageChanged
//                                                sysDlg.pack = pack
//                                                sysDlg.delPgk = false
//                                                sysDlg.show()
//                                            }
//                                        }
                                        InvokeActionItem {
                                            title: qsTr("Share") + Retranslate.onLocaleOrLanguageChanged
                                            query {
                                                mimeType: "text/plain"
                                                invokeActionId: "bb.action.SHARE"
                                            }
                                            onTriggered: {
                                                data = "Code: " + ListItemData.code + "\nLast update date: " + ListItemData.last_update_date.toDateString() + "\nLast update informations: " + ListItemData.last_situation + "\n\nYou also can download the DS Package Tracking: http://appworld.blackberry.com/webstore/content/52504888/"
                                            }
                                        }
                                        DeleteActionItem {
                                            onTriggered: {
                                                sysDlg.title = qsTr("Delete package") + Retranslate.onLocaleOrLanguageChanged
                                                sysDlg.body = qsTr("Do you want to delete this package") + "? " + qsTr("This action can not be undone") + "." + Retranslate.onLocaleOrLanguageChanged
                                                sysDlg.delPgk = true
                                                sysDlg.show()
                                            }
                                        }
                                    }
                                ]
                            }
                        }
                    ]
                    attachedObjects: [
                        ComponentDefinition {
                            id: packageDefinition
                            Package {
                            }
                        }
                    ]
                    onTriggered: {
                        var packagePage = packageDefinition.createObject(navigationPane), data = dataModel.data(indexPath)
                        packagePage.packageData = data
                        navigationPane.push(packagePage)
                    }
                }
            }
            Container {
                visible: false
                topMargin: 10
                bottomPadding: 10
                minHeight: 50
                maxHeight: 50
                minWidth: 320
                maxWidth: 320
                preferredWidth: 320
                preferredHeight: 50
                horizontalAlignment: HorizontalAlignment.Center
                //! [0]
                // this component is used for displaying banner Ad's
                Banner {
                    // zone id is used to identify your application and to track Ad performance
                    // metrics by the Advertising Service
                    zoneId: 261652 //117145
                    refreshRate: 60
                    borderWidth: 2
                    preferredWidth: 320
                    preferredHeight: 50
                    transitionsEnabled: true
                    // Place holder used when there is no connection to the Advertising Service
                    placeHolderURL: "asset:///images/noconnection_728x90.png"
                    borderColor: Color.Gray
                    backgroundColor: Color.Green
                }
            }
        }
    }
}
