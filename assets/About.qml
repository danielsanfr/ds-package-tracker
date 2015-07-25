import bb.cascades 1.0
import app.info 1.0

Sheet {
    id: self
    onClosed: {
        self.destroy()
    }
    attachedObjects: [
        ApplicationInfo {
            id: appInfo
        },
        Invocation {
            id: invocationReview
            query {
                invokeTargetId: "sys.appworld"
                uri: "appworld://content/52504888" // id DS Package Tracking: 52504888
            }
        },
        Invocation {
            id: invocationAppWorld
            query {
                invokeTargetId: "sys.appworld"
                uri: "appworld://vendor/77401" // id vendor Daniel San Ferreira da Rocha: 77401
            }
        },
        Invocation {
            id: invcContact
            query {
                uri: "https://docs.google.com/forms/d/1vL2LLqNhEnbPVltdDWwP45ESd9KydkWcnsbMsGyTpqU/viewform"
                invokeTargetId: "sys.browser"
            }
        },
        Invocation {
            id: invctEmail
            query {
                property variant appData: {
                    "data": {
                        "to": [ "daniel.sam123@hotmail.com" ],
                        "subject": "[DS Package Tracker] Support or suggestion",
                        "body": "Version: " + appInfo.version()
                    }
                }
                invokeTargetId: "sys.pim.uib.email.hybridcomposer"
                mimeType: "message/rfc822"
                data: _app.encode(appData)
            }
        }
    ]
    Page {
        onCreationCompleted: {
            animation.play();
        }
        titleBar: TitleBar {
            title: qsTr("About") + Retranslate.onLocaleOrLanguageChanged
            acceptAction: ActionItem {
                title: "Ok"
                onTriggered: {
                    self.close()
                }
            }
        } // TitleBar
        ScrollView {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            Container {
                topPadding: 20
                bottomPadding: 10
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                ImageView {
                    preferredWidth: 114
                    preferredHeight: 114
                    imageSource: "asset:///images/icon.png"
                    scalingMethod: ScalingMethod.AspectFit
                    horizontalAlignment: HorizontalAlignment.Center
                    onTouch: {
                        if (event.isDown()) {
                            animation.play()
                        }
                    }
                    attachedObjects: [
                        SequentialAnimation {
                            id: animation
                            animations: [
                                FadeTransition {
                                    duration: 1000
                                    easingCurve: StockCurve.CubicOut
                                    fromOpacity: 0.0
                                    toOpacity: 1.0
                                },
                                RotateTransition {
                                    toAngleZ: -20
                                    duration: 125
                                },
                                RotateTransition {
                                    toAngleZ: 20
                                    duration: 250
                                },
                                RotateTransition {
                                    toAngleZ: -20
                                    duration: 250
                                },
                                RotateTransition {
                                    toAngleZ: 20
                                    duration: 250
                                },
                                RotateTransition {
                                    toAngleZ: 0
                                    duration: 125
                                }
                            ]
                        }
                    ]
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    Label {
                        text: qsTr("DS Package Tracker") + Retranslate.onLocaleOrLanguageChanged
                        textStyle.fontWeight: FontWeight.Bold
                    }
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    Label {
                        text: qsTr("Version") + ": " + appInfo.version() + Retranslate.onLocaleOrLanguageChanged
                        textStyle.fontWeight: FontWeight.Bold
                        textStyle.fontSize: FontSize.Small

                    }
                }
                LabelLink {
                    text: "http://www.danielsan.com.br/"
                    uri: "http://www.danielsan.com.br/"
                    horizontalAlignment: HorizontalAlignment.Center
                }
                Divider {
                }
                Container {
                    leftPadding: 75.0
                    Label {
                        text: qsTr("Developer and designer") + Retranslate.onLocaleOrLanguageChanged
                        textStyle.fontSize: FontSize.Large
                        textStyle.fontWeight: FontWeight.Bold
                    }
                    Container {
                        Label {
                            text: "Daniel San"
                        }
                    }
                }
                Divider {
                }
                Container {
                    leftPadding: 75.0
                    Label {
                        text: qsTr("Credits") + Retranslate.onLocaleOrLanguageChanged
                        textStyle.fontSize: FontSize.Large
                        textStyle.fontWeight: FontWeight.Bold
                    }
                    Container {
                        Label {
                            text: "Myers Design Limited (Icons)"
                        }
                    }
                }
                Divider {
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    Button {
                        text: qsTr("More apps") + Retranslate.onLocaleOrLanguageChanged
                        imageSource: "asset:///images/ic_open.png"
                        horizontalAlignment: HorizontalAlignment.Fill
                        onClicked: {
                            invocationAppWorld.trigger("bb.action.OPEN")
                        }
                    }
                    Button {
                        text: qsTr("Post a review") + Retranslate.onLocaleOrLanguageChanged
                        imageSource: "asset:///images/ic_review.png"
                        horizontalAlignment: HorizontalAlignment.Fill
                        onClicked: {
                            invocationReview.trigger("bb.action.OPEN")
                        }
                    }
                    Button {
                        text: qsTr("Contact") + Retranslate.onLocaleOrLanguageChanged
                        imageSource: "asset:///images/ic_mail.png"
                        horizontalAlignment: HorizontalAlignment.Fill
                        onClicked: {
                            invcContact.trigger("bb.action.OPEN")
                            //                            _app.sendEmail()
                            //                            invctEmail.trigger("bb.action.COMPOSE")
                        }
                    }
                }
                Label {
                    text: "Copyright (c) 2014-2015 Daniel San"
                    textStyle.fontSize: FontSize.Small
                    verticalAlignment: VerticalAlignment.Bottom
                    horizontalAlignment: HorizontalAlignment.Center
                }
            }
        }
    }
}