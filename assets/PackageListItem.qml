import bb.cascades 1.0

ListItemComponent {
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        layout: DockLayout {
        }
        contextActions: [
            ActionSet {
                title: qsTr("Package actions") + Retranslate.onLocaleOrLanguageChanged
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
                    }
                }
            }
        ]
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                minWidth: 15
                preferredWidth: 15
                background: ListItemData.flag
                verticalAlignment: VerticalAlignment.Fill
            }
            StandardListItem {
                title: ListItemData.short_description
                description: qsTr("Last update") + ": " + ListItemData.last_update + Retranslate.onLocaleOrLanguageChanged
                status: ListItemData.code
            }
        }
        Container {
            opacity: 0.3
            minWidth: 15
            preferredWidth: 15
            verticalAlignment: VerticalAlignment.Bottom
            Divider {
            }
        }
    }
}