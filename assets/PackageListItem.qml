import bb.cascades 1.0
import "AssetsGetter.js" as AssetsGetter

Container {
    maxHeight: 111
    minHeight: 111
    preferredHeight: 111
    layout: DockLayout {
    }
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        Container {
            maxHeight: 111
            minHeight: 111
            preferredHeight: 111
            maxWidth: 15
            minWidth: 15
            preferredWidth: 15
            background: AssetsGetter.getColor(ListItemData.last_situation)
            verticalAlignment: VerticalAlignment.Fill
            layout: DockLayout {
            }
            Divider {
                verticalAlignment: VerticalAlignment.Bottom
                opacity: 0.3
            }
        }
        StandardListItem {
            title: ListItemData.short_descr
            description: qsTr("Last situation") + ": " + ListItemData.last_situation + Retranslate.onLocaleOrLanguageChanged
            status: ListItemData.code
        }
    }
    Divider {
        verticalAlignment: VerticalAlignment.Bottom
    }
    Divider {
        verticalAlignment: VerticalAlignment.Bottom
    }
}