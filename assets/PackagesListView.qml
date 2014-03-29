import bb.cascades 1.0
import model.custom 1.0

NavigationPane {
    id: navigationPane
    property alias title: titleBar.title
    onPopTransitionEnded: {
        //        page.deleteLater()
        page.destroy()
    }
    Page {
        titleBar: TitleBar {
            id: titleBar
            title: qsTr("Package list") + Retranslate.onLocaleOrLanguageChanged
        }
        attachedObjects: [
            ComponentDefinition {
                id: addPackageDefinition
                AddPackage {
                }
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
                dataModel: SqlDataModel {
                    table: "package"
                }
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
                onCreationCompleted: {
                    dataModel.load()
//                    dataModel.append({"code":"RA12345789BR", "short_description":"Notebook's case", "flag":Color.Yellow, "last_situation": "Encaminhado"})
//                    dataModel.append({"code":"RA12345789BR", "short_description":"Notebook's case", "flag":Color.Green, "last_situation": "Encaminhado"})
//                    dataModel.append({"code":"RA12345789BR", "short_description":"Notebook's case", "flag":Color.Red, "last_situation": "Encaminhado"})
//                    dataModel.append({"code":"RA12345789BR", "short_description":"Notebook's case", "flag":Color.Magenta, "last_situation": "Encaminhado"})
//                    dataModel.append({"code":"RA12345789BR", "short_description":"Notebook's case", "flag":Color.Blue, "last_situation": "Encaminhado"})
//                    dataModel.append({"code":"RA12345789BR", "short_description":"Notebook's case", "flag":Color.Cyan, "last_situation": "Encaminhado"})
//                    dataModel.append({"code":"RA12345789BR", "short_description":"Notebook's case", "flag":Color.Gray, "last_situation": "Encaminhado"})
//                    dataModel.append({"code":"RA12345789BR", "short_description":"Notebook's case", "flag":Color.Black, "last_situation": "Encaminhado"})
//                    dataModel.append({"code":"RA12345789BR", "short_description":"Notebook's case", "flag":Color.DarkBlue, "last_situation": "Encaminhado"})
//                    dataModel.append({"code":"RA12345789BR", "short_description":"Notebook's case", "flag":Color.DarkGreen, "last_situation": "Encaminhado"})
//                    dataModel.append({"code":"RA12345789BR", "short_description":"Notebook's case", "flag":Color.DarkRed, "last_situation": "Encaminhado"})
//                    dataModel.append({"code":"RA12345789BR", "short_description":"Notebook's case", "flag":Color.DarkYellow, "last_situation": "Encaminhado"})
//                    dataModel.append({"code":"RA12345789BR", "short_description":"Notebook's case", "flag":Color.LightGray, "last_situation": "Encaminhado"})
                }
                onTriggered: {
                    var packagePage = packageDefinition.createObject(navigationPane)
                    navigationPane.push(packagePage)
                }
            }
        }
    }
}
