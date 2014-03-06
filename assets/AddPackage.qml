import bb.cascades 1.0

Sheet {
    id: self
    onClosed: {
        self.destroy()
    }
    Page {
        id: page
        titleBar: TitleBar {
            title: qsTr("Add package")
            acceptAction: ActionItem {
                id: actItmSave
                title: qsTr("Save")
                enabled: false
                onTriggered: {
                    self.close()
                }
            }
            dismissAction: ActionItem {
                title: qsTr("Cancel")
                onTriggered: {
                    self.close()
                }
            }
        }
        ScrollView {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            Container {
                bottomPadding: 20
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                Container {
                    Divider {
                    }
                }
                Header {
                    title: qsTr("Package informations")
                }
                DSVTextField {
                    id: txtFldCode
                    topMargin: 20
                    leftPadding: 20
                    rightPadding: 20
                    title: qsTr("Tracking code:")
                    hintText: qsTr("Eg: RA123456789BR")
                    onTextFldChanging: {
                        actItmSave.enabled = (text.length != 0)
                    }
                }
                DSVTextField {
                    id: txtFldTags
                    topPadding: 20
                    leftPadding: 20
                    rightPadding: 20
                    title: qsTr("Tags (optional, and separated by commas):")
                    hintText: qsTr("Eg: book, case")
                }
                Divider {
                }
                DSVTextField {
                    id: txtFldCountry
                    leftPadding: 20
                    rightPadding: 20
                    title: qsTr("Country of origin:")
                    hintText: ""
                    enabled: false
                }
                DSVTextField {
                    id: txtFldService
                    topPadding: 20
                    leftPadding: 20
                    rightPadding: 20
                    title: qsTr("Service name:")
                    hintText: ""
                    enabled: false
                }
                Container {
                    topMargin: 20
                    Divider {
                    }
                }
                Header {
                    title: qsTr("Direction")
                }
                Container {
                    topMargin: 20
                    leftPadding: 20
                    rightPadding: 20
                    CheckBox {
                        id: chkBoxSender
                        text: qsTr("Sending package?")
                    }
                }
                Container {
                    topMargin: 20
                    Divider {
                    }
                }
                Header {
                    title: qsTr("Extras (optional)")
                }
                Container {
                    topMargin: 20
                    leftPadding: 20
                    rightPadding: 20
                    horizontalAlignment: HorizontalAlignment.Fill
                    layout: DockLayout {
                    }
                    Label {
                        text: qsTr("Description")
                        verticalAlignment: VerticalAlignment.Center
                    }
                    ToggleButton {
                        id: tgBtnDescription
                        horizontalAlignment: HorizontalAlignment.Right
                        onCheckedChanged: {
                            txtArDescription.text = ""
                        }
                    }
                }
                Container {
                    topPadding: 20
                    leftPadding: 20
                    rightPadding: 20
                    TextArea {
                        id: txtArDescription
                        minHeight: 200
                        maxHeight: 300
                        visible: tgBtnDescription.checked
                        horizontalAlignment: HorizontalAlignment.Fill
                        inputMode: TextAreaInputMode.EmailAddress
                        hintText: qsTr("Insert description")
                    }
                }
                Divider {
                }
                Container {
                    topMargin: 20
                    leftPadding: 20
                    rightPadding: 20
                    horizontalAlignment: HorizontalAlignment.Fill
                    layout: DockLayout {
                    }
                    Label {
                        text: qsTr("Additional e-mail")
                        verticalAlignment: VerticalAlignment.Center
                    }
                    ToggleButton {
                        id: tgBtnExtraEmail
                        horizontalAlignment: HorizontalAlignment.Right
                        onCheckedChanged: {
                            txtArExtraEmail.text = ""
                        }
                    }
                }
                Container {
                    topMargin: 10
                    leftPadding: 20
                    rightPadding: 20
                    Label {
                        multiline: true
                        textStyle.textAlign: TextAlign.Justify
                        textStyle.base: SystemDefaults.TextStyles.SubtitleText
                        text: qsTr("You want someone else to receive notifications of updates to this package? So just add her e-mail in this field (for more than one email, separate with commas).")
                    }
                }
                Container {
                    topPadding: 20
                    leftPadding: 20
                    rightPadding: 20
                    TextArea {
                        id: txtArExtraEmail
                        minHeight: 200
                        maxHeight: 300
                        visible: tgBtnExtraEmail.checked
                        horizontalAlignment: HorizontalAlignment.Fill
                        inputMode: TextAreaInputMode.EmailAddress
                        hintText: qsTr("Eg: sample@sample.com, friend@friend.com")
                    }
                }
            }
        }
    }
}