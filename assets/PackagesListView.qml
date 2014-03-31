import bb.system 1.0
import bb.cascades 1.0
import model.custom 1.0

NavigationPane {
    id: navigationPane
    property alias title: titleBar.title
    onPopTransitionEnded: {
        //        page.deleteLater()
        page.destroy()
    }
    function load(args, conditions) {
        ctnLastUpdate.visible = (args[":status"] == "pending")
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
            }
        ]
        actions: [
            ActionItem {
                title: qsTr("Add") + Retranslate.onLocaleOrLanguageChanged
                imageSource: "asset:///images/ic_add_package.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    addPackageDefinition.createObject(navigationPane).open()
                }
            },
            ActionItem {
                title: qsTr("Search") + Retranslate.onLocaleOrLanguageChanged
                imageSource: "asset:///images/ic_search.png"
                onTriggered: {
                    searchDelagate.delegateActive = ! searchDelagate.delegateActive
                }
            },
            ActionItem {
                title: qsTr("Refresh") + Retranslate.onLocaleOrLanguageChanged
                imageSource: "asset:///images/ic_reload.png"
                onTriggered: {
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
                id: ctnLastUpdate
                layout: DockLayout {
                }
                Header {
                    id: hdrLastUpdate
                    title: qsTr("Last update") + ": 28/03/14 - 01:05" + Retranslate.onLocaleOrLanguageChanged
                }
                Container {
                    rightPadding: 15
                    bottomPadding: 3
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Right
	                ActivityIndicator {
	                    maxHeight: 100
	                    running: true
	                }
                }
            }
            ControlDelegate {
                id: searchDelagate
                delegateActive: false
                sourceComponent: searchCtnDefinition
            }
            ListView {
                id: packageListView
                dataModel: dtMd
                leadingVisual: Container {
                    topPadding: 20
                    leftPadding: 20
                    rightPadding: 20
                    DropDown {
                        title: qsTr("Sort by") + Retranslate.onLocaleOrLanguageChanged
                        options: [
                            Option {
                                text: qsTr("Sending") + Retranslate.onLocaleOrLanguageChanged
                            },
                            Option {
                                text: qsTr("Tag") + Retranslate.onLocaleOrLanguageChanged
                            },
                            Option {
                                text: qsTr("Code") + Retranslate.onLocaleOrLanguageChanged
                            },
                            Option {
                                text: qsTr("Country") + Retranslate.onLocaleOrLanguageChanged
                            },
                            Option {
                                text: qsTr("Service") + Retranslate.onLocaleOrLanguageChanged
                            },
                            Option {
                                text: qsTr("Date")
                                selected: true
                            }
                        ]
                    }
                    Divider {
                    }
                }
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
                                                    if (!del) {
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
                                        onTriggered: {
                                        }
                                    }
                                    ActionItem {
                                        title: qsTr("Mark as delivered") + Retranslate.onLocaleOrLanguageChanged
                                        imageSource: "asset:///images/ic_delivered.png"
                                        enabled: (ListItemData.status != "delivered")
                                        onTriggered: {
                                            var pack = lstItm.ListItem.view.dataModel.data(lstItm.ListItem.indexPath)
                                            pack["status"] = "delivered"
                                            sysDlg.title = qsTr("Mark as delivered") + Retranslate.onLocaleOrLanguageChanged
                                            sysDlg.body = qsTr("You would like to mark this package as delivered") + "?" + Retranslate.onLocaleOrLanguageChanged
                                            sysDlg.pack = pack
                                            sysDlg.delPgk = false
                                            sysDlg.show()
                                        }
                                    }
                                    ActionItem {
                                        title: qsTr("Archive") + Retranslate.onLocaleOrLanguageChanged
                                        imageSource: "asset:///images/ic_archived.png"
                                        enabled: (ListItemData.status != "archived")
                                        onTriggered: {
                                            var pack = lstItm.ListItem.view.dataModel.data(lstItm.ListItem.indexPath)
                                            pack["status"] = "archived"
                                            sysDlg.title = qsTr("Archive") + Retranslate.onLocaleOrLanguageChanged
                                            sysDlg.body = qsTr("Would you like to archive this package") + "?" + Retranslate.onLocaleOrLanguageChanged
                                            sysDlg.pack = pack
                                            sysDlg.delPgk = false
                                            sysDlg.show()
                                        }
                                    }
                                    InvokeActionItem {
                                        title: qsTr("Share") + Retranslate.onLocaleOrLanguageChanged
                                        query {
                                            mimeType: "text/plain"
                                            invokeActionId: "bb.action.SHARE"
                                        }
                                        onTriggered: {
                                            data = ""
                                        }
                                    }
                                    DeleteActionItem {
                                        onTriggered: {
                                            sysDlg.title = qsTr("Delete package") + Retranslate.onLocaleOrLanguageChanged
                                            sysDlg.body = qsTr("Do you want to delete this package") + "? "
                                            + qsTr("This action can not be undone") + "." + Retranslate.onLocaleOrLanguageChanged
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
                    var packagePage = packageDefinition.createObject(navigationPane),
                    data = dataModel.data(indexPath)
                    packagePage.code = qsTr("Code") + ": " + data.code + Retranslate.onLocaleOrLanguageChanged
                    packagePage.lastUpdate = qsTr("Last update") + ": " + data.last_update_date.toDateString() + Retranslate.onLocaleOrLanguageChanged
                    packagePage.packageId = data.id
                    navigationPane.push(packagePage)
                }
            }
        }
    }
}
