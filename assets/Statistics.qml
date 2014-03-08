import bb.cascades 1.0

Page {
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
            onTriggered: {
                addPackageDefinition.createObject().open()
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
