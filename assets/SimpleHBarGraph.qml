/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: SimpleHBarGraph.qml
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

//Color.create("#C6BFE2") - Azul
//Color.create("#BBDF7E") - Verde
//Color.create("#FFE17B") - Amarelo

Container {
    id: self
    property int datas: 1
    property alias title1: m_barData1.title
    property alias title2: m_barData2.title
    property alias title3: m_barData3.title
    property alias color1: m_barData1.color
    property alias color2: m_barData2.color
    property alias color3: m_barData3.color
    property alias quant1: m_barData1.value
    property alias quant2: m_barData2.value
    property alias quant3: m_barData3.value
    property int totalQuant: quant1 + quant2 + quant3
    property alias noDataMessage: labelNoData.text
    function percentage(quant) {
        if (totalQuant == 0)
            return "";
        else
            return ((quant / totalQuant) * 100).toFixed(1)
    }
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        BarData {
            id: m_barData1
            visible: datas > 0 ? true : false
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
        }
        BarData {
            id: m_barData2
            visible: datas > 1 ? true : false
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
        }
        BarData {
            id: m_barData3
            visible: datas > 2 ? true : false
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
        }
    }
    Container {
        topMargin: 20
        horizontalAlignment: HorizontalAlignment.Fill
        layout: DockLayout {
        }
        Container {
            visible: (quant1 == 0 && quant2 == 0 && quant3 == 0)
            background: Color.LightGray
            horizontalAlignment: HorizontalAlignment.Fill
            Label {
                id: labelNoData
                text: "No data"
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontSize: FontSize.Small
            }
        }
        Container {
            rightPadding: 2
            bottomPadding: 2
            background: Color.Gray
            visible: !(quant1 == 0 && quant2 == 0 && quant3 == 0)
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                background: color1
                visible: m_barData1.visible
                layoutProperties: StackLayoutProperties {
                    spaceQuota: (quant1 == 0) ? 0.000001 : quant1
                }
                Label {
                    text: self.percentage(quant1) + "%"
                    textStyle.color: Color.Black
                    horizontalAlignment: HorizontalAlignment.Center
                }
            }
            Container {
                background: color2
                visible: m_barData2.visible
                layoutProperties: StackLayoutProperties {
                    spaceQuota: (quant2 == 0) ? 0.000001 : quant2
                }
                Label {
                    text: self.percentage(quant2) + "%"
                    textStyle.color: Color.Black
                    horizontalAlignment: HorizontalAlignment.Center
                }
            }
            Container {
                background: color3
                visible: m_barData3.visible
                layoutProperties: StackLayoutProperties {
                    spaceQuota: (quant3 == 0) ? 0.000001 : quant3
                }
                Label {
                    text: self.percentage(quant3) + "%"
                    textStyle.color: Color.Black
                    horizontalAlignment: HorizontalAlignment.Center
                }
            }
        }
    }
}