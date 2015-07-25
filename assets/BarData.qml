/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: BarData.qml
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
    property int value
    property alias title: labelTitle.text
    property alias color: m_colorContainer.background
    horizontalAlignment: HorizontalAlignment.Center
    layout: StackLayout {
        orientation: LayoutOrientation.LeftToRight
    }
    layoutProperties: StackLayoutProperties {
        spaceQuota: 2 + labelTitle.length + labelValue.length
    }
    Container {
        rightPadding: 2
        bottomPadding: 2
        background: Color.Gray
        horizontalAlignment: HorizontalAlignment.Center
        Container {
            id: m_colorContainer
            minWidth: 50
            Label {
                text: " "
            }
        }
    }
    Container {
        leftPadding: 5
        verticalAlignment: VerticalAlignment.Center
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        Container {
            Label {
                id: labelTitle
                textStyle.fontSize: FontSize.Small
            }
        }
        Container {
            Label {
                text: ": "
                textStyle.fontSize: FontSize.Small
            }
        }
        Container {
            Label {
                id: labelValue
                text: value
                textStyle.fontSize: FontSize.Small
            }
        }
    }
}
