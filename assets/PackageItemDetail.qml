import bb.cascades 1.0

Container {
    id: self
    property alias title: lblTitle.text
    property alias text: lblText.text
    property alias imageSource: img.imageSource
    leftPadding: 5
    rightPadding: 5
    bottomPadding: 5
    background: Color.LightGray
    verticalAlignment: VerticalAlignment.Fill
    horizontalAlignment: HorizontalAlignment.Fill
    onCreationCompleted: {
        if (text == null)
            text = qsTr("No information was inserted") + Retranslate.onLocaleOrLanguageChanged;
        else if (text.trim().length == 0)
            text = qsTr("No information was inserted") + Retranslate.onLocaleOrLanguageChanged
    }
    Container {
        background: Color.White
        verticalAlignment: VerticalAlignment.Fill
        horizontalAlignment: HorizontalAlignment.Fill
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
                rightPadding: 20
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
                rightPadding: 20
                bottomPadding: 10
                Label {
                    id: lblText
                    multiline: true
                    textStyle.fontSize: FontSize.Small
                    textStyle.textAlign: TextAlign.Justify
                }
            }
        }
    }
}