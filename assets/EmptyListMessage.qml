/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: EmptyListMessage.qml
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
    property alias description: lblDescription.text
    property alias buttonText: btn.text
    property alias imageSource: img.imageSource
    signal buttonClicked()
    maxWidth: 600
    verticalAlignment: VerticalAlignment.Center
    horizontalAlignment: HorizontalAlignment.Center
    onCreationCompleted: {
        btn.clicked.connect(self.buttonClicked)
    }
    Container {
        visible: self.visible
        horizontalAlignment: HorizontalAlignment.Center
        ImageView {
            id: img
            visible: (imageSource.toString().length != 0) && self.visible
            preferredWidth: 100
            preferredHeight: 100
        }
    }
    Label {
        id: lblTitle
        multiline: true
        visible: (text != "") && self.visible
        horizontalAlignment: HorizontalAlignment.Center
        textStyle {
            base: SystemDefaults.TextStyles.TitleText
            fontWeight: FontWeight.Bold
        }
    }
    Label {
        id: lblDescription
        multiline: true
        visible: (text != "") && self.visible
        textStyle {
            textAlign: TextAlign.Center
        }
        horizontalAlignment: HorizontalAlignment.Center
    }
    Button {
        id: btn
        visible: (text != "") && self.visible
        minWidth: text.length + 400
        horizontalAlignment: HorizontalAlignment.Center
    }
}