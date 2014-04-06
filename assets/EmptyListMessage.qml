import bb.cascades 1.0

Container {
    id: self
    property alias title: lblTitle.text
    property alias description: lblDescription.text
    property alias buttonText: btn.text
    property alias imageSource: img.imageSource
    signal buttonClicked()
    maxWidth: 600
    verticalAlignment: VerticalAlignment.Center
    horizontalAlignment: HorizontalAlignment.Center
    onCreationCompleted: {
        btn.clicked.connect(self.buttonClicked)
    }
    Container {
        visible: self.visible
        horizontalAlignment: HorizontalAlignment.Center
        ImageView {
            id: img
            visible: (imageSource.toString().length != 0) && self.visible
            preferredWidth: 100
            preferredHeight: 100
        }
    }
    Label {
        id: lblTitle
        visible: (text != "") && self.visible
        horizontalAlignment: HorizontalAlignment.Center
        textStyle {
            base: SystemDefaults.TextStyles.TitleText
            fontWeight: FontWeight.Bold
        }
    }
    Label {
        id: lblDescription
        multiline: true
        visible: (text != "") && self.visible
        textStyle {
            textAlign: TextAlign.Center
        }
        horizontalAlignment: HorizontalAlignment.Center
    }
    Button {
        id: btn
        visible: (text != "") && self.visible
        minWidth: text.length + 400
        horizontalAlignment: HorizontalAlignment.Center
    }
}