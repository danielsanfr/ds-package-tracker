import bb.cascades 1.0

Sheet {
    id: self
    property bool isFullVersion: false
    onClosed: {
        self.destroy()
    }
    Page {
        id: page
        titleBar: TitleBar {
            title: qsTr("Add package") + Retranslate.onLocaleOrLanguageChanged
            acceptAction: ActionItem {
                id: actItmSave
                enabled: false
                title: qsTr("Save") + Retranslate.onLocaleOrLanguageChanged
                onTriggered: {
                    _db.setTableName("package")
                    var newPackage = {
                        "status": "pending",
                        "created_date": new Date(),
                        "last_update_date": new Date(),
                        "last_situation": qsTr("No information"),
                        "short_descr": txtFldShortDescr.text.trim(),
                        "code": txtFldCode.text.trim().toUpperCase(),
                        "sending": chkBoxSender.checked,
                        "url_to_store": txtFldUrl.text.trim(),
                        "description": txtArDescription.text.trim(),
                        "emails": txtArEmails.text.trim()
                    }
                    _packageCtrl.create(newPackage)
                    self.close()
                }
            }
            dismissAction: ActionItem {
                title: qsTr("Cancel") + Retranslate.onLocaleOrLanguageChanged
                onTriggered: {
                    self.close()
                }
            }
        }
        ScrollView {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            Container {
                id: ctnMain
                bottomPadding: 20
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                function checkEntries() {
                    var isValidCode = (_packageCtrl.validateCode(txtFldCode.text.trim().toUpperCase()) == 0)
                    if (isValidCode) {
                        actItmSave.enabled = (txtFldShortDescr.text.trim().length != 0)
                        var countyAndService = _packageCtrl.countyAndService()
                        txtFldCountry.text = countyAndService[0]
                        txtFldService.text = countyAndService[1]
                    } else {
                        actItmSave.enabled = false
                        txtFldCountry.text = ''
                        txtFldService.text = ''
                    }
                }
                Container {
                    Divider {
                    }
                }
                Header {
                    title: qsTr("Package informations") + Retranslate.onLocaleOrLanguageChanged
                }
                DSVTextField {
                    id: txtFldShortDescr
                    topMargin: 20
                    leftPadding: 20
                    rightPadding: 20
                    title: qsTr("Short description") + ":" + Retranslate.onLocaleOrLanguageChanged
                    hintText: qsTr("Eg: My new book") + Retranslate.onLocaleOrLanguageChanged
                    onTextFldChanging: {
                        ctnMain.checkEntries()
                    }
                }
                DSVTextField {
                    id: txtFldCode
                    topMargin: 20
                    leftPadding: 20
                    rightPadding: 20
                    inputMode: TextFieldInputMode.EmailAddress
                    title: qsTr("Tracking code") + ":" + Retranslate.onLocaleOrLanguageChanged
                    hintText: qsTr("Eg: RA123456789BR") + Retranslate.onLocaleOrLanguageChanged
                    onTextFldChanging: {
                        if (text.length > 13) {
                            var newText = text
                            txtFldCode.text = newText.substr(0,13)
                        }
                        ctnMain.checkEntries()
                    }
                }
                //                DSVTextField {
                //                    id: txtFldTags
                //                    topPadding: 20
                //                    leftPadding: 20
                //                    rightPadding: 20
                //                    title: qsTr("Tags (optional, and separated by commas):") + Retranslate.onLocaleOrLanguageChanged
                //                    hintText: qsTr("Eg: book, case") + Retranslate.onLocaleOrLanguageChanged
                //                }
                Divider {
                }
                DSVTextField {
                    id: txtFldCountry
                    leftPadding: 20
                    rightPadding: 20
                    title: qsTr("Send from") + ":" + Retranslate.onLocaleOrLanguageChanged
                    hintText: ""
                    enabled: false
                }
                DSVTextField {
                    id: txtFldService
                    topPadding: 20
                    leftPadding: 20
                    rightPadding: 20
                    title: qsTr("Service name") + ":" + Retranslate.onLocaleOrLanguageChanged
                    hintText: ""
                    enabled: false
                }
                Container {
                    topMargin: 20
                    Divider {
                    }
                }
                Header {
                    title: qsTr("Direction") + Retranslate.onLocaleOrLanguageChanged
                }
                Container {
                    topMargin: 20
                    leftPadding: 20
                    rightPadding: 20
                    CheckBox {
                        id: chkBoxSender
                        enabled: isFullVersion
                        text: qsTr("Sending package?") + Retranslate.onLocaleOrLanguageChanged
                    }
                }
                Container {
                    topMargin: 20
                    Divider {
                    }
                }
                Header {
                    title: qsTr("Extras (optional)") + Retranslate.onLocaleOrLanguageChanged
                }
                DSVTextField {
                    id: txtFldUrl
                    topMargin: 20
                    leftPadding: 20
                    rightPadding: 20
                    inputMode: TextFieldInputMode.Url
                    enabled: isFullVersion
                    title: qsTr("Url to package store") + ":" + Retranslate.onLocaleOrLanguageChanged
                    hintText: qsTr("Eg: www.store.com") + Retranslate.onLocaleOrLanguageChanged
                }
                Container {
                    topMargin: 20
                    leftPadding: 20
                    rightPadding: 20
                    horizontalAlignment: HorizontalAlignment.Fill
                    layout: DockLayout {
                    }
                    Label {
                        text: qsTr("Description") + Retranslate.onLocaleOrLanguageChanged
                        verticalAlignment: VerticalAlignment.Center
                    }
                    ToggleButton {
                        id: tgBtnDescription
                        enabled: isFullVersion
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
                        hintText: qsTr("Insert description") + Retranslate.onLocaleOrLanguageChanged
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
                        text: qsTr("Additional e-mail") + Retranslate.onLocaleOrLanguageChanged
                        verticalAlignment: VerticalAlignment.Center
                    }
                    ToggleButton {
                        id: tgBtnExtraEmail
                        enabled: isFullVersion
                        horizontalAlignment: HorizontalAlignment.Right
                        onCheckedChanged: {
                            txtArEmails.text = ""
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
                        text: qsTr("You want someone else to receive notifications of updates to this package? So just add her e-mail in this field (for more than one email, separate with commas).") + Retranslate.onLocaleOrLanguageChanged
                    }
                }
                Container {
                    topPadding: 20
                    leftPadding: 20
                    rightPadding: 20
                    TextArea {
                        id: txtArEmails
                        minHeight: 200
                        maxHeight: 300
                        visible: tgBtnExtraEmail.checked
                        horizontalAlignment: HorizontalAlignment.Fill
                        inputMode: TextAreaInputMode.EmailAddress
                        hintText: qsTr("Eg: sample@sample.com, friend@friend.com") + Retranslate.onLocaleOrLanguageChanged
                    }
                }
            }
        }
    }
}