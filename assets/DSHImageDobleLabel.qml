/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: DSHImageDobleLabel.qml
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
    property alias text: lblText.text
    property alias title: lblTitle.text
    property alias imageSource: img.imageSource
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1.7
            }
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                verticalAlignment: VerticalAlignment.Center
                ImageView {
                    id: img
                    maxWidth: 60
                    minWidth: 60
                    maxHeight: 60
                    minHeight: 60
                    scalingMethod: ScalingMethod.AspectFit
                }
            }
            Container {
                verticalAlignment: VerticalAlignment.Center
                Label {
                    id: lblTitle
                    text: "Title"
                    textStyle.fontSize: FontSize.Small
                }
            }
        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            layoutProperties: StackLayoutProperties {
                spaceQuota: 3.5
            }
            Label {
                id: lblText
                multiline: true
                text: "Text"
                textStyle.fontSize: FontSize.Small
            }
        }
    }
    Container {
        topMargin: 5
        Divider {
        }
    }
}