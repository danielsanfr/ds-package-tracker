import bb.cascades 1.0

Page {
    id: self
    titleBar: TitleBar {
        title: "RA123456789BR"
    }
    actions: [
        ActionItem {
            title: qsTr("Delivered")
            imageSource: "asset:///images/ic_done.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
            }
        },
        DeleteActionItem {
            onTriggered: {
            }
        }
    ]
    ListView {
        dataModel: ArrayDataModel {
        }
        leadingVisualSnapThreshold: 1
        leadingVisual: Container {
            leftPadding: 5
            rightPadding: 5
            bottomPadding: 5
            background: Color.DarkGray
            horizontalAlignment: HorizontalAlignment.Fill
            layout: DockLayout {
            }
            Container {
                verticalAlignment: VerticalAlignment.Top
                horizontalAlignment: HorizontalAlignment.Fill
                Divider {
                }
            }
            Container {
                background: Color.LightGray
                horizontalAlignment: HorizontalAlignment.Fill
                Container {
                    Divider {
                    }
                }
                Header {
                    title: qsTr("Package details")
                    subtitle: "Added: 06-03-14 02:29"
                }
                DSHImageDobleLabel {
                    title: qsTr("Description:")
                    text: "Estou estando isso aqui para ver como isso irá ficar. Acho que ja esta bom esa quantidade de coisa escrita"
                    imageSource: "asset:///images/ic_description_dark.png"
                }
                DSHImageDobleLabel {
                    title: "Country:"
                    text: "Estados Unidos"
                    imageSource: "asset:///images/ic_country_dark.png"
                }
                DSHImageDobleLabel {
                    title: "Service:"
                    text: "Carta registrada"
                    imageSource: "asset:///images/ic_mail_dark.png"
                }
                DSHImageDobleLabel {
                    title: "Dirction:"
                    text: "Enviado"
                    imageSource: "asset:///images/ic_sender_dark.png"
                }
                DSHImageDobleLabel {
                    title: "E-mail(s)"
                    text: "sample@sample.com, friend@friend.com"
                    imageSource: "asset:///images/ic_mail_dark.png"
                }
                DSHImageDobleLabel {
                    title: "Tags"
                    text: "Tags, asda, dadas,dasdas,asd, sad,gfd, dsgdfs, gfdgd, gfdfg"
                    imageSource: "asset:///images/ic_htags.png"
                }
            }
        }
        listItemComponents: [
            CheckpointListItem {
            }
        ]
        onCreationCompleted: {
            scroll(- (700), ScrollAnimation.Smooth)
            dataModel.append({
                    "situation": "Emcaminhado",
                    "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                    "flag": Color.Yellow,
                    "date": "19/12/13 - 18:00"
                })
            dataModel.append({
                    "situation": "Emcaminhado",
                    "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                    "flag": Color.Green,
                    "date": "19/12/13 - 18:00"
                })
            dataModel.append({
                    "situation": "Emcaminhado",
                    "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                    "flag": Color.Red,
                    "date": "19/12/13 - 18:00"
                })
            dataModel.append({
                    "situation": "Emcaminhado",
                    "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                    "flag": Color.Magenta,
                    "date": "19/12/13 - 18:00"
                })
            dataModel.append({
                    "situation": "Emcaminhado",
                    "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                    "flag": Color.Blue,
                    "date": "19/12/13 - 18:00"
                })
            dataModel.append({
                    "situation": "Emcaminhado",
                    "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                    "flag": Color.Cyan,
                    "date": "19/12/13 - 18:00"
                })
            dataModel.append({
                    "situation": "Emcaminhado",
                    "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                    "flag": Color.Gray,
                    "date": "19/12/13 - 18:00"
                })
            dataModel.append({
                    "situation": "Emcaminhado",
                    "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                    "flag": Color.Black,
                    "date": "19/12/13 - 18:00"
                })
            dataModel.append({
                    "situation": "Emcaminhado",
                    "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                    "flag": Color.DarkBlue,
                    "date": "19/12/13 - 18:00"
                })
            dataModel.append({
                    "situation": "Emcaminhado",
                    "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                    "flag": Color.DarkGreen,
                    "date": "19/12/13 - 18:00"
                })
            dataModel.append({
                    "situation": "Emcaminhado",
                    "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                    "flag": Color.DarkRed,
                    "date": "19/12/13 - 18:00"
                })
            dataModel.append({
                    "situation": "Emcaminhado",
                    "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                    "flag": Color.DarkYellow,
                    "date": "19/12/13 - 18:00"
                })
            dataModel.append({
                    "situation": "Emcaminhado",
                    "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                    "flag": Color.LightGray,
                    "date": "19/12/13 - 18:00"
                })
        }
    }
}