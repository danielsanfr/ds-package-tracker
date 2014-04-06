import bb.cascades 1.0

Container {
    id: self

    property alias title: lblTitle.text
    property alias description: lblDescription.text
    property alias status: lblStatus.text
    property bool touchIsDown: false

    leftPadding: 10
    rightPadding: 10
    preferredHeight: 155
    verticalAlignment: VerticalAlignment.Center
    horizontalAlignment: HorizontalAlignment.Fill
    layout: DockLayout {
    }

    onTouch: {
        if (event.touchType == TouchType.Up && touchIsDown) {
            console.log("Item clicado!")
            touchIsDown = false
        } else if (event.touchType == TouchType.Down) {
            touchIsDown = true
        }
    }

    //    StandardListItem {
    //        id: listItem
    //    }

    Container {
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Fill
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            layout: DockLayout {
            }
            Label {
                id: lblTitle
                text: "Encaminhado"
                textStyle.fontSize: FontSize.XSmall
            }
            Label {
                id: lblStatus
                text: "12/12/12"
                textStyle.fontSize: FontSize.XXSmall
                verticalAlignment: VerticalAlignment.Bottom
                horizontalAlignment: HorizontalAlignment.Right
            }
        }
        Container {
            Label {
                id: lblDescription
                multiline: true
                text: "CTCE PORTO VELHO"
                textStyle.fontSize: FontSize.XSmall
            }
        }
        Container {
            Label {
                multiline: true
                text: "PORTO VELHO/RO"
                textStyle.fontSize: FontSize.XSmall
            }
        }
    }
}