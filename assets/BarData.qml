import bb.cascades 1.0

Container {
    property int value
    property alias title: labelTitle.text
    property alias color: m_colorContainer.background
    horizontalAlignment: HorizontalAlignment.Center
    layout: StackLayout {
        orientation: LayoutOrientation.LeftToRight
    }
    layoutProperties: StackLayoutProperties {
        spaceQuota: 2 + labelTitle.length + labelValue.length
    }
    Container {
        rightPadding: 2
        bottomPadding: 2
        background: Color.Gray
        horizontalAlignment: HorizontalAlignment.Center
        Container {
            id: m_colorContainer
            minWidth: 50
            Label {
                text: " "
            }
        }
    }
    Container {
        leftPadding: 5
        verticalAlignment: VerticalAlignment.Center
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        Container {
            Label {
                id: labelTitle
                textStyle.fontSize: FontSize.Small
            }
        }
        Container {
            Label {
                text: ": "
                textStyle.fontSize: FontSize.Small
            }
        }
        Container {
            Label {
                id: labelValue
                text: value
                textStyle.fontSize: FontSize.Small
            }
        }
    }
}
