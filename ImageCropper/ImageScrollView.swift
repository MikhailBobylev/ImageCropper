//
//  ImageScrollView.swift
//  ImageCropper
//
//  Created by Михаил Бобылев on 17.02.2023.
//

import UIKit

class ImageScrollView: UIScrollView, UIScrollViewDelegate {
    var imageZoomView: UIImageView!
    var aspectWidth: CGFloat = 3 {
        didSet {
            updateCropperAspectRatioGrid()
        }
    }
    var aspectHeight: CGFloat = 2 {
        didSet {
            updateCropperAspectRatioGrid()
        }
    }
    
    lazy var gridLinesView: Grid = {
        let view = Grid(frame: bounds)
        view.backgroundColor = UIColor.clear
        view.alpha = 0
        return view
    }()
    
    var spaceToXCenter = 0.0
    var spaceToYCenter = 0.0
    var piece = 0.0
    private var spaceX = 0.0
    private var spaceY = 0.0
    private var originImageW = 0.0
    private var originImageH = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        //bounces = false
        backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage, aspectW: CGFloat, aspectH: CGFloat) {
        imageZoomView?.removeFromSuperview()
        imageZoomView = nil
        imageZoomView = UIImageView(image: image)
        
        aspectWidth = aspectW
        aspectHeight = aspectH
        
        addSubview(imageZoomView)
        addSubview(gridLinesView)
        
        configurateFor(imageSize: image.size)
    }
    
    func configurateFor(imageSize: CGSize) {
        contentSize = imageSize
        originImageW = imageSize.width
        originImageH = imageSize.height
        setCurretMaxMinZoomScale()
        zoomScale = minimumZoomScale
    }
    
    func updateCropperAspectRatioGrid() {
        let w = bounds.size.width / aspectWidth
        let h = bounds.size.height / aspectHeight
        piece = min(w, h)
        let width = aspectWidth * piece
        let height = aspectHeight * piece
        
        spaceX = bounds.width - width
        spaceY = bounds.height - height
        
        setCurretMaxMinZoomScale()
        zoomScale = minimumZoomScale
        updateGrid()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerImage()
    }
    
    func updateGrid() {
        let contentWidth = contentSize.width
        let contentHeight = contentSize.height
        
        var width = min(contentWidth, bounds.width)
        var height = min(contentHeight, bounds.height)
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        if contentWidth.rounded(.toNearestOrAwayFromZero) >= bounds.width && contentHeight.rounded(.toNearestOrAwayFromZero) >= bounds.height {
            width = aspectWidth * piece
            spaceToXCenter = (bounds.width - width) / 2
            x = contentOffset.x + spaceToXCenter

            if contentWidth.rounded(.toNearestOrAwayFromZero) > bounds.width + spaceX {
                if contentOffset.x + bounds.width >= contentWidth - spaceToXCenter {
                    x += (contentOffset.x + bounds.width) - (contentWidth - spaceToXCenter)
                    spaceToXCenter += (contentOffset.x + bounds.width) - (contentWidth - spaceToXCenter)
                } else if contentOffset.x <= spaceToXCenter {
                    x -= spaceToXCenter - contentOffset.x
                    spaceToXCenter -= spaceToXCenter - contentOffset.x
                }
            } else if contentWidth.rounded(.toNearestOrAwayFromZero) > bounds.width {
                if contentOffset.x == 0 {
                    x = contentOffset.x
                } else if contentOffset.x + bounds.width + 0.5 >= contentWidth.rounded(.toNearestOrAwayFromZero) {
                    x += spaceToXCenter
                }
            }
        } else {
            x = max((bounds.width - contentSize.width) * 0.5, 0) //+ contentOffset.x
            spaceToXCenter = 0
        }
        
        if contentHeight.rounded(.toNearestOrAwayFromZero) >= bounds.height && contentWidth.rounded(.toNearestOrAwayFromZero) >= bounds.width {
            height = aspectHeight * piece
            spaceToYCenter = (bounds.height - height) / 2
            y = contentOffset.y + spaceToYCenter

            if contentHeight.rounded(.toNearestOrAwayFromZero) > bounds.height + spaceY {
                if contentOffset.y + bounds.height >= contentHeight - spaceToYCenter {
                    y += (contentOffset.y + bounds.height) - (contentHeight - spaceToYCenter)
                    spaceToYCenter += (contentOffset.y + bounds.height) - (contentHeight - spaceToYCenter)
                } else if contentOffset.y <= spaceToYCenter {
                    y -= spaceToYCenter - contentOffset.y
                    spaceToYCenter -= spaceToYCenter - contentOffset.y
                }
            } else if contentHeight.rounded(.toNearestOrAwayFromZero) > bounds.height {
                if contentOffset.y == 0 {
                    y = contentOffset.y
                } else if contentOffset.y + bounds.height + 0.5 >= contentHeight.rounded(.toNearestOrAwayFromZero) {
                    y += spaceToYCenter
                }
            }
        } else {
            y = max((bounds.height - contentSize.height) * 0.5, 0) //+ contentOffset.y
            spaceToYCenter = 0
        }
        
        gridLinesView.frame = CGRect(x: x, y: y, width: width, height: height)
        gridLinesView.setNeedsDisplay()
    }
    
    func setCurretMaxMinZoomScale() {
        
        let w = originImageW / aspectWidth
        let h = originImageH / aspectHeight
        let sidePiece = min(w, h)
        
        let sideW: CGFloat = sidePiece * aspectWidth
        let sideH: CGFloat = sidePiece * aspectHeight
        
        print("sideW: \(sideW) - sideH: \(sideH)")
        var scale = 0.0
        
        if aspectWidth > aspectHeight && originImageW < originImageH { // гига-вертикальное 2:1
            print("1")
            if sideW > sideH {
                scale = bounds.width / sideW
            } else if sideH > sideW {
                scale = bounds.height / sideH
            } else {
                print("square 1")
                scale = bounds.height / sideH
            }
        } else if aspectWidth < aspectHeight && originImageW > originImageH { // гига-горизонтальное 1:2
            print("2")
            if sideW > sideH {
                scale = bounds.width / sideW
            } else if sideH > sideW {
                scale = bounds.height / sideH
            } else {
                print("square 2")
                scale = bounds.height / sideH
            }
        } else if aspectWidth > aspectHeight && originImageW > originImageH { // горизонтальное 2:1
            print("3")
            if sideW > sideH {
                scale = (bounds.width) / sideW
            } else if sideH > sideW {
                scale = (bounds.height) / sideH
            } else {
                print("square 3")
                scale = (bounds.height) / sideH
            }
        } else if aspectWidth < aspectHeight && originImageW < originImageH { // вертикальное 1:2
            print("4")
            if sideW < sideH {
                scale = (bounds.width) / sideW
            } else if sideH < sideW {
                scale = (bounds.height) / sideH
            } else {
                print("square 4")
                scale = (bounds.height) / sideH
            }
        } else {
            print("5")
            if sideW < sideH {
                scale = (bounds.width + spaceX) / sideW
            } else if sideH < sideW {
                scale = (bounds.height + spaceY) / sideH
            } else {
                print("square 5")
                scale = (bounds.height + spaceY) / sideH
            }
        }
        print("scale: \(scale)")
        
        minimumZoomScale = scale
        maximumZoomScale = 3
    }
    
    func centerImage() {
        let boundsSize = bounds.size
        var frameToCenter = imageZoomView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        imageZoomView.frame = frameToCenter
    
        updateGrid()
    }
    
    // MARK: - UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageZoomView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.1) {
            self.gridLinesView.alpha = 1
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            stoppedScrolling()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        stoppedScrolling()
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        stoppedScrolling()
    }
    
    func stoppedScrolling() {
        UIView.animate(withDuration: 0.2) {
            self.gridLinesView.alpha = 0
        }
    }
    
    
}
