/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: Login.qml
 *     Author: daniel
 * Created on:
 *    Version:
 *
 * This file is part of the DS Package Tracker.
 *
 * DS Package Tracker is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 3 of the
 * License, or (at your option) any later version.
 *
 * DS Package Tracker is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with DS Package Tracker. If not, see <http://www.gnu.org/licenses/>.
 *
 ***************************************************************************/

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