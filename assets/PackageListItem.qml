import bb.cascades 1.0

Container {
    horizontalAlignment: HorizontalAlignment.Fill
    layout: DockLayout {
    }
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
            title: ListItemData.short_descr
            description: qsTr("Last situation") + ": " + ListItemData.last_situation + Retranslate.onLocaleOrLanguageChanged
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