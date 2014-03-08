import bb.cascades 1.0

ListItemComponent {
    Container {
        id: self
        layout: DockLayout {
        }
        contextActions: [
            ActionSet {
                title: qsTr("Checkpoint actions")
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
            }
        ]
        Container {
            opacity: 0.7
            background: ListItemData.flag
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
        }
        StandardListItem {
            title: ListItemData.situation
            description: ListItemData.location
            status: ListItemData.date
            imageSource: ListItemData.flag_icon
        }
    }
}