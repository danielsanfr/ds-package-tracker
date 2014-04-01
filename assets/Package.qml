import bb.system 1.0
import bb.cascades 1.0
import bb.cascades.advertisement 1.0
import "AssetsGetter.js" as AssetsGetter

Page {
    id: self
    property int packageId: -1
    property alias code: hdCode.title
    property alias lastUpdate: hdCode.subtitle
    titleBar: TitleBar {
        title: qsTr("Notebook's case") + Retranslate.onLocaleOrLanguageChanged
    }
    actions: [
        ActionItem {
            title: qsTr("Edit") + Retranslate.onLocaleOrLanguageChanged
            imageSource: "asset:///images/ic_edit.png"
            onTriggered: {
            }
        },
        ActionItem {
            title: qsTr("Delivered") + Retranslate.onLocaleOrLanguageChanged
            imageSource: "asset:///images/ic_delivered.png"
//            enabled: (ListItemData.status != "delivered")
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
//                var pack = lstItm.ListItem.view.dataModel.data(lstItm.ListItem.indexPath)
//                pack["status"] = "delivered"
                sysDlg.title = qsTr("Mark as delivered") + Retranslate.onLocaleOrLanguageChanged
                sysDlg.body = qsTr("You would like to mark this package as delivered") + "?" + Retranslate.onLocaleOrLanguageChanged
//                sysDlg.pack = pack
                sysDlg.delPgk = false
                sysDlg.show()
            }
        },
        ActionItem {
            title: qsTr("Archive") + Retranslate.onLocaleOrLanguageChanged
            imageSource: "asset:///images/ic_archived.png"
//            enabled: (ListItemData.status != "archived")
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
//                var pack = lstItm.ListItem.view.dataModel.data(lstItm.ListItem.indexPath)
//                pack["status"] = "archived"
                sysDlg.title = qsTr("Archive") + Retranslate.onLocaleOrLanguageChanged
                sysDlg.body = qsTr("Would you like to archive this package") + "?" + Retranslate.onLocaleOrLanguageChanged
//                sysDlg.pack = pack
                sysDlg.delPgk = false
                sysDlg.show()
            }
        },
        InvokeActionItem {
            title: qsTr("Share") + Retranslate.onLocaleOrLanguageChanged
            query {
                mimeType: "text/plain"
                invokeActionId: "bb.action.SHARE"
            }
            onTriggered: {
                data = ""
            }
        },
        DeleteActionItem {
            onTriggered: {
                sysDlg.title = qsTr("Delete package") + Retranslate.onLocaleOrLanguageChanged
                sysDlg.body = qsTr("Do you want to delete this package") + "? "
                + qsTr("This action can not be undone") + "." + Retranslate.onLocaleOrLanguageChanged
                sysDlg.delPgk = true
                sysDlg.show()
            }
        }
    ]
    attachedObjects: [
        SystemDialog {
            id: sysDlg
            property variant pack
            property bool delPgk: false
            onFinished: {
                if (value == SystemUiResult.ConfirmButtonSelection) {
                    var del = delPgk
                    if (! del) {
                        console.log("Update item")
                    } else
                        console.log("Delete item")
                }
            }
        },
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
                            imageSource: AssetsGetter.getIcon(ListItemData.situation)
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
            id: hdCode
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
        Container {
            topMargin: 10
            bottomPadding: 10
            minHeight: 50
            maxHeight: 50
            preferredHeight: 50
            horizontalAlignment: HorizontalAlignment.Center
            //! [0]
            // this component is used for displaying banner Ad's
            Banner {
                // zone id is used to identify your application and to track Ad performance
                // metrics by the Advertising Service
                zoneId: 117145
                refreshRate: 180
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