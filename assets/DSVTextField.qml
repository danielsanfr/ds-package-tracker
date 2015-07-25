/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: DSVTextField.qml
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
    property alias text: txtFld.text
    property alias hintText: txtFld.hintText
    property alias inputMode: txtFld.inputMode
    signal textFldChanged(string text)
    signal textFldChanging(string text)
    Label {
        id: lblTitle
        visible: (text.length != 0) ? true : false
    }
    TextField {
        id: txtFld
        enabled: self.enabled
        onTextChanged: {
            self.textFldChanged(text)
        }
        onTextChanging: {
            self.textFldChanging(text)
        }
    }
}
