import bb.cascades 1.0

ListItemComponent {
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        layout: DockLayout {
        }
        contextActions: [
            ActionSet {
                title: qsTr("Package actions")
                InvokeActionItem {
                    title: qsTr("Share")
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
                title: ListItemData.code
                description: ListItemData.tags
                status: ListItemData.date
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