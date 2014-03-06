import bb.cascades 1.0

Container {
    property alias text: lblText.text
    property alias title: lblTitle.text
    property alias imageSource: img.imageSource
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1.7
            }
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                verticalAlignment: VerticalAlignment.Center
                ImageView {
                    id: img
                    maxWidth: 60
                    minWidth: 60
                    maxHeight: 60
                    minHeight: 60
                    scalingMethod: ScalingMethod.AspectFit
                }
            }
            Container {
                verticalAlignment: VerticalAlignment.Center
                Label {
                    id: lblTitle
                    text: "Title"
                    textStyle.fontSize: FontSize.Small
                }
            }
        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            layoutProperties: StackLayoutProperties {
                spaceQuota: 3.5
            }
            Label {
                id: lblText
                multiline: true
                text: "Text"
                textStyle.fontSize: FontSize.Small
            }
        }
    }
    Container {
        topMargin: 5
        Divider {
        }
    }
}