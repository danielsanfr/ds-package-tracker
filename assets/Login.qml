import bb.cascades 1.0

Sheet {
    id: self
    peekEnabled: false

    Page {
        titleBar: TitleBar {
            title: "Login"
        }
        ScrollView {
            Container {
                topPadding: 20
                leftPadding: 20
                rightPadding: 20
                bottomPadding: 20

                attachedObjects: [ // attach to the page or something
                    Invocation {
                        id: linkInvocation
                        property bool auto_trigger: false
                        
                        onArmed: {
                            // don't auto-trigger on initial setup
                            if (auto_trigger)
                                trigger("bb.action.OPEN");
                            auto_trigger = true; // allow re-arming to auto-trigger
                        }
                        
                        query {
                            uri: "http://muambator.com.br/perfil/registre-se/"
                            invokeTargetId: "sys.browser"
                        }
                    }
                ]

                ImageView {
                    imageSource: "asset:///images/icon.png"
                    horizontalAlignment: HorizontalAlignment.Center
                }
                Container {
                    Label {
                        text: "Usuário/E-mail"
                    }
                }
                TextField {
                    hintText: ""
                    inputMode: TextFieldInputMode.EmailAddress
                    horizontalAlignment: HorizontalAlignment.Fill
                }
                Container {
                    Label {
                        text: "Senha"
                    }
                }
                TextField {
                    hintText: ""
                    inputMode: TextFieldInputMode.Password
                    horizontalAlignment: HorizontalAlignment.Fill
                }
                Divider {
                }
                Button {
                    text: "Login"
                    horizontalAlignment: HorizontalAlignment.Fill

                    onClicked: {
                        self.close()
                    }
                }
                Button {
                    text: "Não tenho conta"
                    horizontalAlignment: HorizontalAlignment.Fill

                    onClicked: {
                        linkInvocation.query.updateQuery()
                    }
                }
            }
        }
    }
}