import bb.cascades 1.0

Page {
    id: self
    titleBar: TitleBar {
        title: "Notebook's case"
    }
    actions: [
        ActionItem {
            title: qsTr("Delivered")
            imageSource: "asset:///images/ic_delivered.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
            }
        },
        DeleteActionItem {
            onTriggered: {
            }
        }
    ]
    attachedObjects: [
        ComponentDefinition {
            id: checkpointsListDefinition
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                ListView {
                    dataModel: ArrayDataModel {
                    }
                    listItemComponents: [
                        ListItemComponent {
                            StandardListItem {
                                title: ListItemData.situation
                                description: ListItemData.location
                                status: ListItemData.date
                                imageSource: ListItemData.flag_icon
                            }
                        }
                    ]
                    onCreationCompleted: {
                        dataModel.append({
                                "situation": "Emcaminhado",
                                "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                                "flag": Color.Yellow,
                                "date": "19/12/13 - 18:00",
                                "flag_icon": "asset:///images/stt_delivered.png"
                            })
                        dataModel.append({
                                "situation": "Emcaminhado",
                                "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                                "flag": Color.Green,
                                "date": "19/12/13 - 18:00",
                                "flag_icon": "asset:///images/stt_waiting.png"
                            })
                        dataModel.append({
                                "situation": "Emcaminhado",
                                "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                                "flag": Color.Red,
                                "date": "19/12/13 - 18:00",
                                "flag_icon": "asset:///images/stt_out_for_delivery.png"
                            })
                        dataModel.append({
                                "situation": "Emcaminhado",
                                "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                                "flag": Color.Magenta,
                                "date": "19/12/13 - 18:00",
                                "flag_icon": "asset:///images/stt_in_transit.png"
                            })
                        dataModel.append({
                                "situation": "Emcaminhado",
                                "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                                "flag": Color.Blue,
                                "date": "19/12/13 - 18:00",
                                "flag_icon": "asset:///images/stt_out_for_delivery.png"
                            })
                        dataModel.append({
                                "situation": "Emcaminhado",
                                "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                                "flag": Color.Cyan,
                                "date": "19/12/13 - 18:00",
                                "flag_icon": "asset:///images/stt_in_transit.png"
                            })
                        dataModel.append({
                                "situation": "Emcaminhado",
                                "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                                "flag": Color.Gray,
                                "date": "19/12/13 - 18:00",
                                "flag_icon": "asset:///images/stt_taxed.png"
                            })
                        dataModel.append({
                                "situation": "Emcaminhado",
                                "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                                "flag": Color.Black,
                                "date": "19/12/13 - 18:00",
                                "flag_icon": "asset:///images/stt_conferred.png"
                            })
                        dataModel.append({
                                "situation": "Emcaminhado",
                                "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                                "flag": Color.DarkGreen,
                                "date": "19/12/13 - 18:00",
                                "flag_icon": "asset:///images/stt_external_moving.png"
                            })
                        dataModel.append({
                                "situation": "Emcaminhado",
                                "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                                "flag": Color.DarkRed,
                                "date": "19/12/13 - 18:00",
                                "flag_icon": "asset:///images/stt_external_moving.png"
                            })
                        dataModel.append({
                                "situation": "Emcaminhado",
                                "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                                "flag": Color.DarkYellow,
                                "date": "19/12/13 - 18:00",
                                "flag_icon": "asset:///images/stt_external_moving.png"
                            })
                        dataModel.append({
                                "situation": "Emcaminhado",
                                "location": "CTCE PORTO VELHO - PORTO VELHO/RO",
                                "flag": Color.LightGray,
                                "date": "19/12/13 - 18:00",
                                "flag_icon": "asset:///images/stt_no_informations.png"
                            })
                    }
                }
            }
        },
        ComponentDefinition {
            id: detailDefinition
            ScrollView {
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                Container {
                    bottomPadding: 20
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill
                    DSHImageDobleLabel {
                        leftPadding: 10
                        rightPadding: 10
                        title: qsTr("Description:")
                        text: "Estou estando isso aqui para ver como isso irá ficar. Acho que ja esta bom esa quantidade de coisa escrita"
                        imageSource: "asset:///images/ic_description.png"
                    }
                    DSHImageDobleLabel {
                        leftPadding: 10
                        rightPadding: 10
                        title: "Country:"
                        text: "Estados Unidos"
                        imageSource: "asset:///images/ic_country.png"
                    }
                    DSHImageDobleLabel {
                        leftPadding: 10
                        rightPadding: 10
                        title: "Service:"
                        text: "Carta registrada"
                        imageSource: "asset:///images/ic_mail.png"
                    }
                    DSHImageDobleLabel {
                        leftPadding: 10
                        rightPadding: 10
                        title: "Dirction:"
                        text: "Enviado"
                        imageSource: "asset:///images/ic_sender.png"
                    }
                    DSHImageDobleLabel {
                        leftPadding: 10
                        rightPadding: 10
                        title: "E-mail(s)"
                        text: "sample@sample.com, friend@friend.com"
                        imageSource: "asset:///images/ic_mail.png"
                    }
                    DSHImageDobleLabel {
                        leftPadding: 10
                        rightPadding: 10
                        title: "Tags"
                        text: "Tags, asda, dadas,dasdas,asd, sad,gfd, dsgdfs, gfdgd, gfdfg"
                        imageSource: "asset:///images/ic_htags.png"
                    }
                }
            }
        }
    ]
    Container {
        topPadding: 20
        verticalAlignment: VerticalAlignment.Fill
        horizontalAlignment: HorizontalAlignment.Fill
        Container {
            leftPadding: 20
            rightPadding: 20
            horizontalAlignment: HorizontalAlignment.Fill
            SegmentedControl {
                horizontalAlignment: HorizontalAlignment.Fill
                options: [
                    Option {
                        text: qsTr("Checkpoins")
                    },
                    Option {
                        text: qsTr("Details")
                    }
                ]
                onCreationCompleted: {
                    selectedIndex = 0
                }
                onSelectedIndexChanged: {
                    checkpointsListDelegate.delegateActive = ! (Boolean(selectedIndex))
                }
            }
        }
        Container {
            topMargin: 20
            Divider {
            }
        }
        Header {
            title: qsTr("Code") + ": " + "RA123456789BR"
            subtitle: qsTr("Added") + ": " + "06-03-14 02:29"
        }
        Container {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            layout: DockLayout {
            }
            ControlDelegate {
                id: detailDelegate
                visible: delegateActive
                delegateActive: ! checkpointsListDelegate.delegateActive
                sourceComponent: detailDefinition
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
            }
            ControlDelegate {
                id: checkpointsListDelegate
                visible: delegateActive
                sourceComponent: checkpointsListDefinition
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
            }
        }
    }
}