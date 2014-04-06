import bb.cascades 1.0

Container {
    attachedObjects: ImagePaintDefinition {
        id: backgroundImagePaint
        imageSource: "asset:///images/active-frame-q10.png"
    }
    background: backgroundImagePaint.imagePaint
}

//Container {
//    Container {
//        leftPadding: 10
//        rightPadding: 10
//        background: Color.Black
//        preferredHeight: 56
//        horizontalAlignment: HorizontalAlignment.Fill
//        layout: DockLayout {
//        }
//        Container {
//            verticalAlignment: VerticalAlignment.Center
//            horizontalAlignment: HorizontalAlignment.Fill
//            Label {
//                text: "RA123456789BR"
//                textStyle.color: Color.White
//                verticalAlignment: VerticalAlignment.Bottom
//            }
//        }
//    }
//    StatusTrackingActiveFrameListItem {
//        background: Color.Yellow
//    }
//}
