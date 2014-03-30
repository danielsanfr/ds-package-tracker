import bb.cascades 1.0

Page {
    id: self
    property int packageId: -1
    titleBar: TitleBar {
        title: qsTr("Notebook's case") + Retranslate.onLocaleOrLanguageChanged
    }
    actions: [
        ActionItem {
            title: qsTr("Delivered") + Retranslate.onLocaleOrLanguageChanged
            imageSource: "asset:///images/ic_delivered.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
            }
        },
        DeleteActionItem {
            onTriggered: {
            }
        }
    ]
    attachedObjects: [
        ComponentDefinition {
            id: checkpointsListDefinition
            ListView {
                id: lstVwInfos
                property int packageId: self.packageId
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                dataModel: ArrayDataModel {
                    id: dtMd
                }
                listItemComponents: [
                    ListItemComponent {
                        StandardListItem {
                            title: ListItemData.situation
                            description: ListItemData.location
                            status: ListItemData.date
                            imageSource: ListItemData.flag_icon
                        }
                    }
                ]
                onPackageIdChanged: {
                    var pkgId = lstVwInfos.packageId
                    if (pkgId != -1) {
                        var list = _packageCtrl.informationList(pkgId)
                        dataModel.append(list)
                    }
                }
            }
        },
        ComponentDefinition {
            id: detailDefinition
            ScrollView {
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                Container {
                    bottomPadding: 20
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill
                    DSHImageDobleLabel {
                        leftPadding: 10
                        rightPadding: 10
                        title: qsTr("Description") + ":" + Retranslate.onLocaleOrLanguageChanged
                        text: "Estou estando isso aqui para ver como isso irá ficar. Acho que ja esta bom esa quantidade de coisa escrita"
                        imageSource: "asset:///images/ic_description.png"
                    }
                    DSHImageDobleLabel {
                        leftPadding: 10
                        rightPadding: 10
                        title: "Country:"
                        text: "Estados Unidos"
                        imageSource: "asset:///images/ic_country.png"
                    }
                    DSHImageDobleLabel {
                        leftPadding: 10
                        rightPadding: 10
                        title: "Service:"
                        text: "Carta registrada"
                        imageSource: "asset:///images/ic_mail.png"
                    }
                    DSHImageDobleLabel {
                        leftPadding: 10
                        rightPadding: 10
                        title: "Dirction:"
                        text: "Enviado"
                        imageSource: "asset:///images/ic_sender.png"
                    }
                    DSHImageDobleLabel {
                        leftPadding: 10
                        rightPadding: 10
                        title: "E-mail(s)"
                        text: "sample@sample.com, friend@friend.com"
                        imageSource: "asset:///images/ic_mail.png"
                    }
                    DSHImageDobleLabel {
                        leftPadding: 10
                        rightPadding: 10
                        title: "Tags"
                        text: "Tags, asda, dadas,dasdas,asd, sad,gfd, dsgdfs, gfdgd, gfdfg"
                        imageSource: "asset:///images/ic_htags.png"
                    }
                }
            }
        }
    ]
    Container {
        topPadding: 20
        verticalAlignment: VerticalAlignment.Fill
        horizontalAlignment: HorizontalAlignment.Fill
        Container {
            leftPadding: 20
            rightPadding: 20
            horizontalAlignment: HorizontalAlignment.Fill
            SegmentedControl {
                horizontalAlignment: HorizontalAlignment.Fill
                options: [
                    Option {
                        text: qsTr("Checkpoins") + Retranslate.onLocaleOrLanguageChanged
                    },
                    Option {
                        text: qsTr("Details") + Retranslate.onLocaleOrLanguageChanged
                    }
                ]
                onCreationCompleted: {
                    selectedIndex = 0
                }
                onSelectedIndexChanged: {
                    checkpointsListDelegate.delegateActive = ! (Boolean(selectedIndex))
                }
            }
        }
        Container {
            topMargin: 20
            Divider {
            }
        }
        Header {
            title: qsTr("Code") + ": " + "RA123456789BR" + Retranslate.onLocaleOrLanguageChanged
            subtitle: qsTr("Added") + ": " + "06-03-14 02:29" + Retranslate.onLocaleOrLanguageChanged
        }
        Container {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            layout: DockLayout {
            }
            ControlDelegate {
                id: detailDelegate
                visible: delegateActive
                delegateActive: ! checkpointsListDelegate.delegateActive
                sourceComponent: detailDefinition
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
            }
            ControlDelegate {
                id: checkpointsListDelegate
                visible: delegateActive
                sourceComponent: checkpointsListDefinition
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
            }
        }
    }
}