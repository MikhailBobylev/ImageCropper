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
    var aspectHeight: CGFloat = 4 {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        bounces = false
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
        
        print("\(contentWidth) > \(bounds.width + spaceX)")
        if contentWidth > bounds.width + spaceX && contentHeight > bounds.height {
            width = aspectWidth * piece
            spaceToXCenter = (bounds.width - width) / 2
            x = contentOffset.x + spaceToXCenter
            
            if contentOffset.x + bounds.width >= contentWidth - spaceToXCenter {
                x += (contentOffset.x + bounds.width) - (contentWidth - spaceToXCenter)
                spaceToXCenter += (contentOffset.x + bounds.width) - (contentWidth - spaceToXCenter)
            } else if contentOffset.x <= spaceToXCenter {
                x -= spaceToXCenter - contentOffset.x
                spaceToXCenter -= spaceToXCenter - contentOffset.x
            }
        } else {
            x = max((bounds.width - contentSize.width) * 0.5, 0) + contentOffset.x
            spaceToXCenter = 0
        }
        
        if contentHeight > bounds.height + spaceY && contentWidth > bounds.width {
            height = aspectHeight * piece
            spaceToYCenter = (bounds.height - height) / 2
            y = contentOffset.y + spaceToYCenter
            
            if contentOffset.y + bounds.height >= contentHeight - spaceToYCenter {
                y += (contentOffset.y + bounds.height) - (contentHeight - spaceToYCenter)
                spaceToYCenter += (contentOffset.y + bounds.height) - (contentHeight - spaceToYCenter)
            } else if contentOffset.y <= spaceToYCenter {
                y -= spaceToYCenter - contentOffset.y
                spaceToYCenter -= spaceToYCenter - contentOffset.y
            }
        } else {
            y = max((bounds.height - contentSize.height) * 0.5, 0) + contentOffset.y
            spaceToYCenter = 0
        }
        
        gridLinesView.frame = CGRect(x: x, y: y, width: width, height: height)
        gridLinesView.setNeedsDisplay()
    }
    
    func setCurretMaxMinZoomScale() {
        let boundsSize = bounds.size
        let imageSize = imageZoomView.bounds.size

        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        
        let minScale = min(xScale, yScale)
        
        var maxScale: CGFloat = 1.0
        
        if minScale < 0.1 {
            maxScale = 0.3
        }
        if minScale >= 0.1 && minScale < 0.5 {
            maxScale = 0.7
        }
        if minScale >= 0.5 {
            maxScale = max(1.0, minScale)
        }
        
        minimumZoomScale = minScale - 0.01
        maximumZoomScale = maxScale
        print("Scale: \(minScale) - \(maxScale)")
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
        print("frameToCenter: \(frameToCenter)")
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
