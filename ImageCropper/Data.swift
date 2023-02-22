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

//class ImageScrollView: UIScrollView, UIScrollViewDelegate {
//    var imageZoomView: UIImageView!
//    var aspectWidth: CGFloat = 3 {
//        didSet {
//            updateCropperAspectRatioGrid()
//        }
//    }
//    var aspectHeight: CGFloat = 2 {
//        didSet {
//            updateCropperAspectRatioGrid()
//        }
//    }
//    
//    lazy var gridLinesView: Grid = {
//        let view = Grid(frame: bounds)
//        view.backgroundColor = UIColor.clear
//        view.alpha = 0
//        return view
//    }()
//    
//    var spaceToXCenter = 0.0
//    var spaceToYCenter = 0.0
//    var piece = 0.0
//    private var spaceX = 0.0
//    private var spaceY = 0.0
//    private var originImageW = 0.0
//    private var originImageH = 0.0
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        delegate = self
//        showsVerticalScrollIndicator = false
//        showsHorizontalScrollIndicator = false
//        backgroundColor = .gray
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func set(image: UIImage, aspectW: CGFloat, aspectH: CGFloat) {
//        imageZoomView?.removeFromSuperview()
//        imageZoomView = nil
//        imageZoomView = UIImageView(image: image)
//        
//        aspectWidth = aspectW
//        aspectHeight = aspectH
//        
//        addSubview(imageZoomView)
//        addSubview(gridLinesView)
//        
//        configurateFor(imageSize: image.size)
//    }
//    
//    func configurateFor(imageSize: CGSize) {
//        contentSize = imageSize
//        originImageW = imageSize.width
//        originImageH = imageSize.height
//        setCurretMaxMinZoomScale()
//        zoomScale = minimumZoomScale
//    }
//    
//    func updateCropperAspectRatioGrid() {
//        let w = bounds.size.width / aspectWidth
//        let h = bounds.size.height / aspectHeight
//        piece = min(w, h)
//        let width = aspectWidth * piece
//        let height = aspectHeight * piece
//        
//        spaceX = bounds.width - width
//        spaceY = bounds.height - height
//        
//        setCurretMaxMinZoomScale()
//        zoomScale = minimumZoomScale
//        updateGrid()
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        centerImage()
//    }
//    
//    func updateGrid() {
//        let contentWidth = contentSize.width
//        let contentHeight = contentSize.height
//        
//        var width = min(contentWidth, bounds.width)
//        var height = min(contentHeight, bounds.height)
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
//        gridLinesView.frame = CGRect(x: x, y: y, width: width, height: height)
//        gridLinesView.setNeedsDisplay()
//    }
//    
//    func setCurretMaxMinZoomScale() {
//        
//        let w = originImageW / aspectWidth
//        let h = originImageH / aspectHeight
//        let sidePiece = min(w, h)
//        
//        let sideW: CGFloat = sidePiece * aspectWidth
//        let sideH: CGFloat = sidePiece * aspectHeight
//        
//        print("sideW: \(sideW) - sideH: \(sideH)")
//        var scale = 0.0
//        
//        if aspectWidth > aspectHeight && originImageW < originImageH { // гига-вертикальное 2:1
//            print("1")
//            if sideW > sideH {
//                scale = bounds.width / sideW
//            } else if sideH > sideW {
//                scale = bounds.height / sideH
//            } else {
//                print("square 1")
//                scale = bounds.height / sideH
//            }
//        } else if aspectWidth < aspectHeight && originImageW > originImageH { // гига-горизонтальное 1:2
//            print("2")
//            if sideW > sideH {
//                scale = bounds.width / sideW
//            } else if sideH > sideW {
//                scale = bounds.height / sideH
//            } else {
//                print("square 2")
//                scale = bounds.height / sideH
//            }
//        } else if aspectWidth > aspectHeight && originImageW > originImageH { // горизонтальное 2:1
//            print("3")
//            if sideW > sideH {
//                scale = (bounds.width) / sideW
//            } else if sideH > sideW {
//                scale = (bounds.height) / sideH
//            } else {
//                print("square 3")
//                scale = (bounds.height) / sideH
//            }
//        } else if aspectWidth < aspectHeight && originImageW < originImageH { // вертикальное 1:2
//            print("4")
//            if sideW < sideH {
//                scale = (bounds.width) / sideW
//            } else if sideH < sideW {
//                scale = (bounds.height) / sideH
//            } else {
//                print("square 4")
//                scale = (bounds.height) / sideH
//            }
//        } else {
//            print("5")
//            if sideW < sideH {
//                scale = (bounds.width + spaceX) / sideW
//            } else if sideH < sideW {
//                scale = (bounds.height + spaceY) / sideH
//            } else {
//                print("square 5")
//                scale = (bounds.height + spaceY) / sideH
//            }
//        }
//        
//        minimumZoomScale = scale
//        maximumZoomScale = 3
//    }
//    
//    func centerImage() {
//        let boundsSize = bounds.size
//        var frameToCenter = imageZoomView.frame
//        
//        if frameToCenter.size.width < boundsSize.width {
//            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
//        } else {
//            frameToCenter.origin.x = 0
//        }
//        
//        if frameToCenter.size.height < boundsSize.height {
//            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
//        } else {
//            frameToCenter.origin.y = 0
//        }
//        imageZoomView.frame = frameToCenter
//    
//        updateGrid()
//    }
//    
//    // MARK: - UIScrollViewDelegate
//    
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        imageZoomView
//    }
//    
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        centerImage()
//    }
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        UIView.animate(withDuration: 0.1) {
//            self.gridLinesView.alpha = 1
//        }
//    }
//    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !decelerate {
//            stoppedScrolling()
//        }
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        stoppedScrolling()
//    }
//
//    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
//        stoppedScrolling()
//    }
//    
//    func stoppedScrolling() {
//        UIView.animate(withDuration: 0.2) {
//            self.gridLinesView.alpha = 0
//        }
//    }
//    
//    
//}
