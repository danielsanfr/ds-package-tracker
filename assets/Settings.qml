import bb.cascades 1.0
import bb.cascades.pickers 1.0

Sheet {
    id: self
    Page {
        titleBar: TitleBar {
            title: qsTr("Settings")
            acceptAction: ActionItem {
                title: "Ok"
                onTriggered: {
                    self.close()
                }
            }
        }
        Container {
            ScrollView {
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                Container {
                    topPadding: 20
                    bottomPadding: 20
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill
                    Container {
                        leftPadding: 20
                        rightPadding: 20
                        DropDown {
                            title: qsTr("Application theme")
                            options: [
                                Option {
                                    text: qsTr("Bright")
                                    value: "bright"
                                },
                                Option {
                                    text: qsTr("Dark")
                                    value: "dark"
                                }
                            ]
                            onCreationCompleted: {
                                var selected = _settings.getValueFor("theme", "bright")
                                if (selected == "bright")
                                    selectedIndex = 0;
                                else if (selected == "dark")
                                    selectedIndex = 1
                            }
                            onSelectedValueChanged: {
                                _settings.saveValueFor("theme", selectedValue)
                            }
                        }
                        Container {
                            Label {
                                multiline: true
                                textStyle.textAlign: TextAlign.Justify
                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                text: qsTr("Note: You must restart the application to apply this theme.") + Retranslate.onLocaleOrLanguageChanged
                            }
                        }
                    }
                    Divider {
                    }
                    Container {
                        topMargin: 20
                        leftPadding: 20
                        rightPadding: 20
                        horizontalAlignment: HorizontalAlignment.Fill
                        CheckBox {
                            id: chkBoxNotify
                            text: qsTr("Notifications")
                        }
                    }
                    Divider {
                    }
                    Container {
                        leftPadding: 20
                        rightPadding: 20
                        horizontalAlignment: HorizontalAlignment.Fill
                        DropDown {
                            title: qsTr("Sound")
                            enabled: chkBoxNotify.checked
                            Option {
                                text: qsTr("Amarelo")
                            }
                            Option {
                                text: qsTr("Azul")
                            }
                            Option {
                                text: qsTr("Branco")
                            }
                            Option {
                                text: qsTr("Laranja")
                            }
                            Option {
                                text: qsTr("Rosa")
                            }
                            Option {
                                text: qsTr("Verde")
                                selected: true
                            }
                            Option {
                                text: qsTr("Vermelho")
                            }
                        }
                    }
                    Divider {
                    }
                    Container {
                        leftPadding: 20
                        rightPadding: 20
                        horizontalAlignment: HorizontalAlignment.Fill
                        layout: DockLayout {
                        }
                        Label {
                            text: qsTr("Vibrate")
                            enabled: chkBoxNotify.checked
                            textStyle.fontSize: FontSize.Large
                            verticalAlignment: VerticalAlignment.Center
                        }
                        ToggleButton {
                            enabled: chkBoxNotify.checked
                            horizontalAlignment: HorizontalAlignment.Right
                        }
                    }
                    Divider {
                    }
                    Container {
                        leftPadding: 20
                        rightPadding: 20
                        horizontalAlignment: HorizontalAlignment.Fill
                        DropDown {
                            title: qsTr("LED color")
                            enabled: chkBoxNotify.checked
                            Option {
                                text: qsTr("Amarelo")
                            }
                            Option {
                                text: qsTr("Azul")
                            }
                            Option {
                                text: qsTr("Branco")
                            }
                            Option {
                                text: qsTr("Laranja")
                            }
                            Option {
                                text: qsTr("Rosa")
                            }
                            Option {
                                text: qsTr("Verde")
                                selected: true
                            }
                            Option {
                                text: qsTr("Vermelho")
                            }
                        }
                    }
                    Divider {
                    }
                    Container {
                        leftPadding: 20
                        rightPadding: 20
                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Container {
                                Label {
                                    text: qsTr("Refresh time: ")
                                    textStyle.fontSize: FontSize.Large
                                }
                            }
                            Container {
                                Label {
                                    id: lblUpdateTime
                                    text: "0 h"
                                    textStyle.fontSize: FontSize.Large
                                }
                            }
                        }
                        Slider {
                            value: 5.0
                            toValue: 24.0
                            fromValue: 1.0
                            horizontalAlignment: HorizontalAlignment.Fill
                            onValueChanged: {
                                var realValue = value - Number(value).toFixed(0)
                                lblUpdateTime.text = ((realValue > 0.5) ? Number(value).toFixed(0) + 1 : Number(value).toFixed(0)) + " h"
                                value = (realValue > 0.5) ? Number(value).toFixed(0) + 1 : Number(value).toFixed(0)
                            }
                        }
                        Container {
                            Label {
                                multiline: true
                                textStyle.textAlign: TextAlign.Justify
                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                text: qsTr("This is the time between updates of the status of the packages. But anytime you poderar update the status of the packages by clicking the refresh button.")
                            }
                        }
                    }
                    Divider {
                    }
                }
            }
        }
    }
}