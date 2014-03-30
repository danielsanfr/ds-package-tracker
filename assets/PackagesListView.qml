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
                                            lstItm.ListItem.view.dataModel.deleteRecord(lstItm.ListItem.indexPath)
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
                    packagePage.packageId = data.id
                    navigationPane.push(packagePage)
                }
            }
        }
    }
}
