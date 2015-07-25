/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: LabelLink.qml
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
    property string text
    property string uri
    property alias multiline: label.multiline
    Label {
        id: label
        property bool touchIsDown: false
        text: "<html><span style='text-decoration:underline'>" + self.text + "</span></html>"
        textStyle {
            base: SystemDefaults.TextStyles.BigText
            fontSize: FontSize.Large
            color: Color.Blue
        }
        attachedObjects: [ // attach to the page or something
            Invocation {
                id: linkInvocation
                property bool auto_trigger: false
                onArmed: {
                    // don't auto-trigger on initial setup
                    if (auto_trigger)
                        trigger("bb.action.OPEN")
                    auto_trigger = true; // allow re-arming to auto-trigger
                }
                query {
                    uri: (self.uri.indexOf("http://") == 0 || self.uri.indexOf("https://") == 0) ? self.uri : "http://" + self.uri
                    invokeTargetId: "sys.browser"
                }
            }
        ]
        onTouch: {
            if (event.touchType == TouchType.Up && touchIsDown) {
                linkInvocation.query.updateQuery()
                touchIsDown = false
            } else if (event.touchType == TouchType.Down) {
                touchIsDown = true
            }
        }
    }
}
