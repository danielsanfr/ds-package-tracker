/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: PackegeListItem.qml
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
import "AssetsGetter.js" as AssetsGetter

Container {
    maxHeight: 111
    minHeight: 111
    preferredHeight: 111
    layout: DockLayout {
    }
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        Container {
            maxHeight: 111
            minHeight: 111
            preferredHeight: 111
            maxWidth: 15
            minWidth: 15
            preferredWidth: 15
            background: AssetsGetter.getColor(ListItemData.last_situation)
            verticalAlignment: VerticalAlignment.Fill
            layout: DockLayout {
            }
            Divider {
                verticalAlignment: VerticalAlignment.Bottom
                opacity: 0.3
            }
        }
        StandardListItem {
            title: ListItemData.short_descr
            description: qsTr("Last situation") + ": " + ListItemData.last_situation + Retranslate.onLocaleOrLanguageChanged
            status: ListItemData.code
        }
    }
    Divider {
        verticalAlignment: VerticalAlignment.Bottom
    }
    Divider {
        verticalAlignment: VerticalAlignment.Bottom
    }
}