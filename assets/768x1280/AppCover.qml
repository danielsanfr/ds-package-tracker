import bb.cascades 1.0

Container {
    Container {
        leftPadding: 10
        rightPadding: 10
        background: Color.Black
        preferredHeight: 62
        horizontalAlignment: HorizontalAlignment.Fill
        layout: DockLayout {
        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Fill
            Label {
                text: "RA123456789BR"
                textStyle.color: Color.White
                verticalAlignment: VerticalAlignment.Bottom
            }
        }
    }
    StatusTrackingActiveFrameListItem {
        background: Color.Yellow
    }
    Container {
        Divider {
        }
    }
    StatusTrackingActiveFrameListItem {
        background: Color.Green
    }
    Container {
        Divider {
        }
    }
    StatusTrackingActiveFrameListItem {
        background: Color.Red
    }
}
