import bb.cascades 1.0

Container {
    property alias title: lblTitle.text
    property alias text: lblText.text
    property alias imageSource: img.imageSource
    verticalAlignment: VerticalAlignment.Fill
    layout: StackLayout {
        orientation: LayoutOrientation.LeftToRight
    }
    ImageView {
        id: img
        minWidth: 71
        maxWidth: 71
        minHeight: 71
        maxHeight: 71
        preferredWidth: 71
        preferredHeight: 71
        scalingMethod: ScalingMethod.AspectFit
    }
    Container {
        topPadding: 13
        Container {
            Label {
                id: lblTitle
                textStyle.fontWeight: FontWeight.Bold
            }
        }
        Container {
            topPadding: 10
            bottomPadding: 10
            Divider {
            }
        }
        Container {
            Label {
                id: lblText
                multiline: true
                textStyle.fontSize: FontSize.Small
                textStyle.textAlign: TextAlign.Justify
            }
        }
    }

}
