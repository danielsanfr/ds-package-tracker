import bb.cascades 1.0

Container {
    id: self
    property alias title: lblTitle.text
    property alias text: txtFld.text
    property alias hintText: txtFld.hintText
    property alias enable: txtFld.enabled
    signal textFldChanged(string text)
    signal textFldChanging(string text)
    Label {
        id: lblTitle
        visible: (text.length != 0) ? true : false
    }
    TextField {
        id: txtFld
        onTextChanged: {
            self.textFldChanged(text)
        }
        onTextChanging: {
            self.textFldChanging(text)
        }
    }
}
