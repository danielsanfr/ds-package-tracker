/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: PackageItemDetail.qml
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

Container {
    id: self
    property alias title: lblTitle.text
    property alias text: lblText.text
    property alias imageSource: img.imageSource
    leftPadding: 5
    rightPadding: 5
    bottomPadding: 5
    background: Color.LightGray
    verticalAlignment: VerticalAlignment.Fill
    horizontalAlignment: HorizontalAlignment.Fill
    onCreationCompleted: {
        if (text == null)
            text = qsTr("No information was inserted") + Retranslate.onLocaleOrLanguageChanged;
        else if (text.trim().length == 0)
            text = qsTr("No information was inserted") + Retranslate.onLocaleOrLanguageChanged
    }
    Container {
        background: Color.White
        verticalAlignment: VerticalAlignment.Fill
        horizontalAlignment: HorizontalAlignment.Fill
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        ImageView {
            id: img
            minWidth: 71
            maxWidth: 71
            minHeight: 71
            maxHeight: 71
            preferredWidth: 71
            preferredHeight: 71
            scalingMethod: ScalingMethod.AspectFit
        }
        Container {
            topPadding: 13
            Container {
                rightPadding: 20
                Label {
                    id: lblTitle
                    textStyle.fontWeight: FontWeight.Bold
                }
            }
            Container {
                topPadding: 10
                bottomPadding: 10
                Divider {
                }
            }
            Container {
                rightPadding: 20
                bottomPadding: 10
                Label {
                    id: lblText
                    multiline: true
                    textStyle.fontSize: FontSize.Small
                    textStyle.textAlign: TextAlign.Justify
                }
            }
        }
    }
}