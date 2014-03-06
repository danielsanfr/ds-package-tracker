import bb.cascades 1.0

Container {
    property alias title: lblTitle.text
    property alias text: txtFld.text
    property alias hintText: txtFld.hintText
    property alias enable: txtFld.enabled
    layout: StackLayout {
        orientation: LayoutOrientation.LeftToRight
    }
    Label {
        id: lblTitle
        visible: (text.length != 0) ? true : false
        verticalAlignment: VerticalAlignment.Center
    }
    Container {
        verticalAlignment: VerticalAlignment.Center
        TextField {
            id: txtFld
        }
    }
}
