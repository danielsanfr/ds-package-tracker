import bb.system 1.0
import bb.cascades 1.0

Page {
    property bool isFullVersion: false
    titleBar: TitleBar {
        title: qsTr("Statistics") + Retranslate.onLocaleOrLanguageChanged
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
            attachedObjects: [
                SystemToast {
                    id: sysTst
                    body: qsTr("More than 5 packs only in the full version") + Retranslate.onLocaleOrLanguageChanged
                }
            ]
            onTriggered: {
                if (isFullVersion || _db.count() <= 5)
                    addPackageDefinition.createObject(navigationPane).open()
                else
                    sysTst.show()
            }
//        },
//        ActionItem {
//            title: qsTr("Refresh") + Retranslate.onLocaleOrLanguageChanged
//            imageSource: "asset:///images/ic_reload.png"
//            attachedObjects: [
//                SystemToast {
//                    body: qsTr("Check your internet connection.") + Retranslate.onLocaleOrLanguageChanged
//                }
//            ]
//            onTriggered: {
//                if (! _packageCtrl.update()) {
//                    sysTstConnected.show()
//                    ctnLastUpdate.visible = false
//                } else
//                    actIndRefresh.running = true
//            }
        }
    ]
    Container {
        Container {
            Divider {
            }
        }
        Header {
            title: qsTr("Packages distribution") + Retranslate.onLocaleOrLanguageChanged
        }
        SimpleHBarGraph {
            topMargin: 20
            leftPadding: 20
            rightPadding: 20
            datas: 3
            title1: qsTr("Pending") + Retranslate.onLocaleOrLanguageChanged
            title2: qsTr("Delivered") + Retranslate.onLocaleOrLanguageChanged
            title3: qsTr("Archived") + Retranslate.onLocaleOrLanguageChanged
            color1: Color.create("#C6BFE2")
            color2: Color.create("#BBDF7E")
            color3: Color.create("#FFE17B")
            quant1: 2
            quant2: 3
            quant3: 5
        }
        Container {
            topMargin: 20
            Divider {
            }
        }
        Header {
            title: qsTr("Packages direction") + Retranslate.onLocaleOrLanguageChanged
        }
        SimpleHBarGraph {
            topMargin: 30
            leftPadding: 20
            rightPadding: 20
            datas: 2
            title1: qsTr("Receiver") + Retranslate.onLocaleOrLanguageChanged
            title2: qsTr("Sending") + Retranslate.onLocaleOrLanguageChanged
            color1: Color.create("#C6BFE2")
            color2: Color.create("#BBDF7E")
            quant1: 2
            quant2: 3
        }
    }
}
