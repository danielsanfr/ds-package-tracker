import bb.system 1.0
import bb.cascades 1.0
import bb.cascades.advertisement 1.0
import "AssetsGetter.js" as AssetsGetter

Page {
    id: self
    property bool isFullVersion: false
    property variant packageData: 0
    titleBar: TitleBar {
        id: titleBar
    }
    actions: [
        ActionItem {
            title: qsTr("Edit") + Retranslate.onLocaleOrLanguageChanged
            imageSource: "asset:///images/ic_edit.png"
            enabled: false
            onTriggered: {
            }
        },
        ActionItem {
            title: qsTr("Delivered") + Retranslate.onLocaleOrLanguageChanged
            imageSource: "asset:///images/ic_delivered.png"
            enabled: (packageData.status != "delivered")
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                var pack = packageData
                pack["status"] = "delivered"
                sysDlg.title = qsTr("Mark as delivered") + Retranslate.onLocaleOrLanguageChanged
                sysDlg.body = qsTr("You would like to mark this package as delivered") + "?" + Retranslate.onLocaleOrLanguageChanged
                sysDlg.pack = pack
                sysDlg.delPgk = false
                sysDlg.show()
            }
        },
        ActionItem {
            title: qsTr("Archive") + Retranslate.onLocaleOrLanguageChanged
            imageSource: "asset:///images/ic_archived.png"
            enabled: isFullVersion && (packageData.status != "archived")
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                var pack = packageData
                pack["status"] = "archived"
                sysDlg.title = qsTr("Archive") + Retranslate.onLocaleOrLanguageChanged
                sysDlg.body = qsTr("Would you like to archive this package") + "?" + Retranslate.onLocaleOrLanguageChanged
                sysDlg.pack = pack
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
                data = "Code: " + packageData.code + "\nLast update date: " + packageData.last_update_date.toDateString() + "\nLast update informations: " + packageData.last_situation + "\n\nYou also can download the DS Package Tracking: http://appworld.blackberry.com/webstore/content/52504888/"
            }
        },
        DeleteActionItem {
            onTriggered: {
                sysDlg.title = qsTr("Delete package") + Retranslate.onLocaleOrLanguageChanged
                sysDlg.body = qsTr("Do you want to delete this package") + "? " + qsTr("This action can not be undone") + "." + Retranslate.onLocaleOrLanguageChanged
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
                        var pkg = pack
                        _db.setTableName("package")
                        _db.update(pkg)
                        self.packageData = pkg
                    } else {
                        var pkg = self.packageData
                        _db.setTableName("package")
                        _db.deleteRecord(pkg.id)
                        navigationPane.pop()
                    }
                }
            }
        },
        ComponentDefinition {
            id: checkpointsListDefinition
            Container {
                layout: DockLayout {
                }
                ScrollView {
                    id: emptyListMessage
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    EmptyListMessage {
                        visible: emptyListMessage.visible
                        title: qsTr("No checkpoints") + Retranslate.onLocaleOrLanguageChanged
                        description: qsTr("This may have occurred because there is still no update on the site of the post office or a problem connecting to the internet. Try refreshing the inspection points on the previous page.") + Retranslate.onLocaleOrLanguageChanged
//                        Isso pode ter ocorrido porque ainda não existe atualização no site dos correios ou por algum problema de conexão com a internet. Tente refrescar os pontos de inspeção na página anterior.
                    }
                }
                ListView {
                    id: lstVwInfos
                    visible: false
                    property variant packageData: self.packageData
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
                    onPackageDataChanged: {
                        var pkgData = lstVwInfos.packageData
                        if (pkgData != 0) {
                            var list = _packageCtrl.informationList(pkgData.id)
                            dataModel.append(list)
	                        if (dataModel.size() == 0) {
	                            emptyListMessage.visible = true
	                            lstVwInfos.visible = false
	                        } else {
	                            emptyListMessage.visible = false
	                            lstVwInfos.visible = true
	                        }
                        }
                    }
                }
            }
        },
        ComponentDefinition {
            id: detailDefinition
            ScrollView {
                id: srlVwDetail
                property variant packageData: self.packageData
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                onPackageDataChanged: {
                    var pkgData = srlVwDetail.packageData
                    if (pkgData != 0) {
                        pkgItDtlDesc.text = pkgData.description
                        _packageCtrl.validateCode(pkgData.code)
                        var countyAndService = _packageCtrl.countyAndService()
                        pkgItDtlSendFrom.text = countyAndService[0]
                        pkgItDtlServiceName.text = countyAndService[1]
                        pkgItDtlDirection.text = (pkgData.sending) ? qsTr("Sender") : qsTr("Addressee")
                        pkgItDtlDirection.imageSource = (pkgData.sending) ? "asset:///images/ic_sender.png" : "asset:///images/ic_reciver.png"
                        pkgItDtlEmail.text = pkgData.emails
                        pkgItDtlUrl.text = pkgData.url_to_store
                        pkgItDtlUrl.uri = pkgData.url_to_store
                    }
                }
                Container {
                    bottomPadding: 20
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill
                    PackageItemDetail {
                        id: pkgItDtlDesc
                        title: qsTr("Description")
                        imageSource: "asset:///images/ic_description.png"
                    }
                    PackageItemDetail {
                        id: pkgItDtlSendFrom
                        title: qsTr("Send from")
                        imageSource: "asset:///images/ic_send_from.png"
                    }
                    PackageItemDetail {
                        id: pkgItDtlServiceName
                        title: qsTr("Service name")
                        imageSource: "asset:///images/ic_service.png"
                    }
                    PackageItemDetail {
                        id: pkgItDtlDirection
                        title: qsTr("Direction")
                    }
                    PackageItemDetail {
                        id: pkgItDtlEmail
                        title: qsTr("E-mails(s)")
                        imageSource: "asset:///images/ic_mail.png"
                    }
                    Container {
                        background: Color.LightGray
                        leftPadding: 5
                        rightPadding: 5
                        bottomPadding: 5
                        verticalAlignment: VerticalAlignment.Fill
                        horizontalAlignment: HorizontalAlignment.Fill
                        Container {
                            background: Color.White
                            verticalAlignment: VerticalAlignment.Fill
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Container {
                                ImageView {
                                    minWidth: 71
                                    maxWidth: 71
                                    minHeight: 71
                                    maxHeight: 71
                                    preferredWidth: 71
                                    preferredHeight: 71
                                    scalingMethod: ScalingMethod.AspectFit
                                    imageSource: "asset:///images/ic_link.png"
                                }
                            }
                            Container {
                                topPadding: 13
                                Container {
                                    rightPadding: 20
                                    Label {
                                        text: qsTr("Link")
                                        textStyle.fontWeight: FontWeight.Bold
                                    }
                                }
                                Container {
                                    topPadding: 10
                                    bottomPadding: 10
                                    Divider {
                                    }
                                }
                                LabelLink {
                                    id: pkgItDtlUrl
                                    multiline: true
                                    rightPadding: 20
                                    bottomPadding: 10
                                }
                            }
                        }
                    }
                }
            }
        }
    ]
    onPackageDataChanged: {
        var pkgData = self.packageData
        titleBar.title = pkgData.short_descr
        hdCode.title = qsTr("Code") + ": " + pkgData.code + Retranslate.onLocaleOrLanguageChanged
        hdCode.subtitle = qsTr("Last update") + ": " + pkgData.last_update_date.toDateString() + Retranslate.onLocaleOrLanguageChanged
    }
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