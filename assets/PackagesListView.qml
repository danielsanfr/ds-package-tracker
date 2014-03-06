import bb.cascades 1.0

NavigationPane {
    id: navigationPane
    property alias title: titleBar.title
    onPopTransitionEnded: {
        page.deleteLater();
    }
    Page {
        titleBar: TitleBar {
            id: titleBar
            title: qsTr("Package list")
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
                title: qsTr("Add")
                imageSource: "asset:///images/ic_add.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    addPackageDefinition.createObject(navigationPane).open()
                }
            },
            ActionItem {
                title: qsTr("Search")
                imageSource: "asset:///images/ic_search.png"
                onTriggered: {
                    searchDelagate.delegateActive = !searchDelagate.delegateActive
                }
            },
            ActionItem {
                title: qsTr("Refresh")
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
                                text: qsTr("Cancel")
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1.2
                                }
                                onClicked: {
                                    txtFldSearch.text = ""
                                    searchDelagate.delegateActive = !searchDelagate.delegateActive
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
            ControlDelegate {
                id: searchDelagate
                delegateActive: false
                sourceComponent: searchCtnDefinition
            }
            ListView {
                id: packageListView
                dataModel: ArrayDataModel {
                }
                leadingVisual: Container {
                    topPadding: 20
                    leftPadding: 20
                    rightPadding: 20
                    DropDown {
                        title: qsTr("Sort by")
                        options: [
                            Option {
                                text: qsTr("Sending")
                            },
                            Option {
                                text: qsTr("Tag")
                            },
                            Option {
                                text: qsTr("Code")
                            },
                            Option {
                                text: qsTr("Country")
                            },
                            Option {
                                text: qsTr("Service")
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
                    PackageListItem {
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
                    dataModel.append({"code":"RA12345789BR", "tags":"notebook, pc", "flag":Color.Yellow, "date": "19/12/13 - 18:10"})
                    dataModel.append({"code":"RA12345789BR", "tags":"notebook, pc", "flag":Color.Green, "date": "19/12/13 - 18:10"})
                    dataModel.append({"code":"RA12345789BR", "tags":"notebook, pc", "flag":Color.Red, "date": "19/12/13 - 18:10"})
                    dataModel.append({"code":"RA12345789BR", "tags":"notebook, pc", "flag":Color.Magenta, "date": "19/12/13 - 18:10"})
                    dataModel.append({"code":"RA12345789BR", "tags":"notebook, pc", "flag":Color.Blue, "date": "19/12/13 - 18:10"})
                    dataModel.append({"code":"RA12345789BR", "tags":"notebook, pc", "flag":Color.Cyan, "date": "19/12/13 - 18:10"})
                    dataModel.append({"code":"RA12345789BR", "tags":"notebook, pc", "flag":Color.Gray, "date": "19/12/13 - 18:10"})
                    dataModel.append({"code":"RA12345789BR", "tags":"notebook, pc", "flag":Color.Black, "date": "19/12/13 - 18:10"})
                    dataModel.append({"code":"RA12345789BR", "tags":"notebook, pc", "flag":Color.DarkBlue, "date": "19/12/13 - 18:10"})
                    dataModel.append({"code":"RA12345789BR", "tags":"notebook, pc", "flag":Color.DarkGreen, "date": "19/12/13 - 18:10"})
                    dataModel.append({"code":"RA12345789BR", "tags":"notebook, pc", "flag":Color.DarkRed, "date": "19/12/13 - 18:10"})
                    dataModel.append({"code":"RA12345789BR", "tags":"notebook, pc", "flag":Color.DarkYellow, "date": "19/12/13 - 18:10"})
                    dataModel.append({"code":"RA12345789BR", "tags":"notebook, pc", "flag":Color.LightGray, "date": "19/12/13 - 18:10"})
                }
                onTriggered: {
                    var packagePage = packageDefinition.createObject(navigationPane)
                    navigationPane.push(packagePage)
                }
            }
        }
    }
}
