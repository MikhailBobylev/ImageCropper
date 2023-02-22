//
//  Data.swift
//  ImageCropper
//
//  Created by Михаил Бобылев on 20.02.2023.
//

import UIKit

class Data: UIView {

//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        centerImage()
//        let w = bounds.size.width / aspectWidth
//        let h = bounds.size.height / aspectHeight
//        let piece = min(w, h)
//        print("Mid: \(bounds.midX) - \(bounds.midY)")
//
//        print("-----------------------------------------------")
//        let contentWidth = contentSize.width
//        let contentHeight = contentSize.height
//
//        print("contentOffset.x - \(contentOffset.x)")
//        print("contentOffset.y - \(contentOffset.y)")
//
//        var width = aspectWidth * piece //min(contentWidth, bounds.width)
//        var height = aspectHeight * piece //min(contentHeight, bounds.height)
//
//        var x: CGFloat = 0
//        var y: CGFloat = 0
//
//        if contentWidth > bounds.width {
//            x = contentOffset.x
//            if contentWidth - contentOffset.x < bounds.width {
//                width = contentWidth - contentOffset.x
//            } else if contentOffset.x < 0 {
//                width += contentOffset.x
//                x += -contentOffset.x
//            }
//        } else {
//            x = max((bounds.width - contentSize.width) * 0.5, 0)
//        }
//
//        if contentHeight > bounds.height {
//            y = contentOffset.y
//            if contentHeight - contentOffset.y < bounds.height {
//                height = contentHeight - contentOffset.y
//            } else if contentOffset.y < 0 {
//                height += contentOffset.y
//                y += -contentOffset.y
//            }
//        } else {
//            y = max((bounds.height - contentSize.height) * 0.5, 0)
//        }
//
//        print("\(bounds.width) - \(contentSize.width) * 0.5 = \(x)")
//        print("\(bounds.height) - \(contentSize.height) * 0.5 = \(y)")
//        print("x = \(x)")
//        print("y = \(y)")
//
//
//        //gridLinesView.frame = CGRect(x: x, y: y, width: width, height: height)
//        gridLinesView.frame = CGRect(x: x, y: y, width: width, height: height)
//
//        gridLinesView.setNeedsDisplay()
//        print("-----------------------------------------------")
//    }

//    class Grid: UIView {
//        
//        public var horizontalLinesCount: UInt = 2 {
//            didSet {
//                setNeedsDisplay()
//            }
//        }
//
//        public var verticalLinesCount: UInt = 2 {
//            didSet {
//                setNeedsDisplay()
//            }
//        }
//
//        public var lineColor: UIColor = UIColor(ciColor: .red) { //UIColor(white: 1, alpha: 0.7)
//            didSet {
//                setNeedsDisplay()
//            }
//        }
//
//        public var lineWidth: CGFloat = 50.0 / UIScreen.main.scale {
//            didSet {
//                setNeedsDisplay()
//            }
//        }
//
//        override func draw(_ rect: CGRect) {
//            super.draw(rect)
//
//            guard let context = UIGraphicsGetCurrentContext() else {
//                return
//            }
//            print("draw: \(frame.size.width) - \(frame.size.height)")
//
//            context.setLineWidth(lineWidth)
//            context.setStrokeColor(lineColor.cgColor)
//
//            let horizontalLineSpacing = frame.size.width / CGFloat(horizontalLinesCount + 1)
//            let verticalLineSpacing = frame.size.height / CGFloat(verticalLinesCount + 1)
//            
//            for i in 1 ..< horizontalLinesCount + 1 {
//                context.move(to: CGPoint(x: CGFloat(i) * horizontalLineSpacing, y: 0))
//                context.addLine(to: CGPoint(x: CGFloat(i) * horizontalLineSpacing, y: frame.size.height))
//            }
//
//            for i in 1 ..< verticalLinesCount + 1 {
//                context.move(to: CGPoint(x: 0, y: CGFloat(i) * verticalLineSpacing))
//                context.addLine(to: CGPoint(x: frame.size.width, y: CGFloat(i) * verticalLineSpacing))
//            }
//
//            context.strokePath()
//        }
//
//    }
    
    // MARK: - Scroll 2
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        //print("zoomScale: \(zoomScale)")
//        let w = bounds.size.width / aspectWidth
//        let h = bounds.size.height / aspectHeight
//        let piece = min(w, h)
//
//        //print("-----------------------------------------------")
//        let contentWidth = contentSize.width
//        let contentHeight = contentSize.height
//
////        print("contentOffset.x - \(contentOffset.x)")
////        print("contentOffset.y - \(contentOffset.y)")
//
//        var width = min(contentWidth, bounds.width)
//        var height = min(contentHeight, bounds.height)
//
//        var x: CGFloat = 0
//        var y: CGFloat = 0
//
//        if contentWidth >= bounds.width && contentHeight >= bounds.height {
//            width = aspectWidth * piece
//            let spaceToCenter = (bounds.width - width) / 2
////            let step = contentWidth / bounds.width
////            x = contentOffset.x * (1 / zoomScale)
////
////            print("x: \(x) - contentOffset.x: \(contentOffset.x) - zoomScale: \(1 / zoomScale)")
////            print("contentWidth: \(contentWidth)")
//
//            x = contentOffset.x + spaceToCenter
////            let horizontalBorder = contentWidth - contentOffset.x
////            let toCenter = bounds.width - width
////            print("x: \(x) - contentOffset.x: \(contentOffset.x) - spaceToCenter: \(spaceToCenter)")
////            let first = x + (gridLinesView.frame.width / 2) //- spaceToCenter
////            let last = contentWidth - first
////
////            print("toCenter: \(toCenter) - gridLinesView.frame.width / 2: \(gridLinesView.frame.width / 2)")
////            print("\(first) < \(last)")
////
////            if first < last {
////                print("left")
////                x -= spaceToCenter - contentOffset.x //- (x - (gridLinesView.frame.width / 2))
////            } else if first > last {
////                print("right")
////                x += (contentOffset.x + bounds.width) - (contentWidth - spaceToCenter)
////            }
////            print("\(first) - \(x) - \(last)")
//
//
//            print("\(contentOffset.x + bounds.width) >= \(contentWidth - spaceToCenter)")
//            if contentOffset.x + bounds.width >= contentWidth - spaceToCenter { // horizontalBorder == bounds.width
//                x += (contentOffset.x + bounds.width) - (contentWidth - spaceToCenter)
//                //print("x: \(x)")
//            } else if contentOffset.x <= spaceToCenter {
//                x -= spaceToCenter - contentOffset.x
//            }
//            print("spaceToCenter: \(spaceToCenter) - x: \(x) - contentOffset.x: \(contentOffset.x)")
//            print("contentWidth: \(contentWidth) - bounds.width / 2: \(bounds.width / 2)")
//
//
//        } else {
//            x = max((bounds.width - contentSize.width) * 0.5, 0) + contentOffset.x
//        }
//
//        if contentHeight >= bounds.height && contentWidth >= bounds.width {
//            height = aspectHeight * piece
//            y = contentOffset.y + ((bounds.height - height) / 2)
//            let border = contentHeight - contentOffset.y
//
//            if border < bounds.height {
//                height -= bounds.height - border
//            } else if contentOffset.y < 0 {
//                height += contentOffset.y
//                y += -contentOffset.y
//            }
//        } else {
//            y = max((bounds.height - contentSize.height) * 0.5, 0) + contentOffset.y
//        }
//
////        print("\(bounds.width) - \(contentSize.width) * 0.5 = \(x)")
////        print("\(bounds.height) - \(contentSize.height) * 0.5 = \(y)")
////        print("x = \(x)")
////        print("y = \(y)")
//
//        gridLinesView.frame = CGRect(x: x, y: y, width: width, height: height)
//        gridLinesView.setNeedsDisplay()
//        //print("gridLinesView: \(gridLinesView.frame.origin.x) - \(gridLinesView.frame.origin.y)")
//        //print("gridLinesView: \(gridLinesView.frame.width) - \(gridLinesView.frame.height)")
//        //print("-----------------------------------------------")
//        centerImage()
//    }
}
