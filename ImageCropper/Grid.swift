//
//  Grid.swift
//  ImageCropper
//
//  Created by Михаил Бобылев on 18.02.2023.
//

import UIKit

class Grid: UIView {
    
    public var horizontalLinesCount: UInt = 2 {
        didSet {
            setNeedsDisplay()
        }
    }

    public var verticalLinesCount: UInt = 2 {
        didSet {
            setNeedsDisplay()
        }
    }

    public var lineColor: UIColor = UIColor(ciColor: .red) { //UIColor(white: 1, alpha: 0.7)  UIColor(ciColor: .red)
        didSet {
            setNeedsDisplay()
        }
    }

    public var lineWidth: CGFloat = 10.0 / UIScreen.main.scale {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //print("draw: \(frame.size.width) - \(frame.size.height)")

        context.setLineWidth(lineWidth)
        context.setStrokeColor(lineColor.cgColor)

        let horizontalLineSpacing = frame.size.width / CGFloat(horizontalLinesCount + 1)
        let verticalLineSpacing = frame.size.height / CGFloat(verticalLinesCount + 1)
        
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: 0, y: frame.size.height))
        
        for i in 1 ..< horizontalLinesCount + 1 {
            context.move(to: CGPoint(x: CGFloat(i) * horizontalLineSpacing, y: 0))
            context.addLine(to: CGPoint(x: CGFloat(i) * horizontalLineSpacing, y: frame.size.height))
        }

        context.move(to: CGPoint(x: frame.size.width, y: 0))
        context.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height))
        
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: frame.size.width, y: 0))
        
        for i in 1 ..< verticalLinesCount + 1 {
            context.move(to: CGPoint(x: 0, y: CGFloat(i) * verticalLineSpacing))
            context.addLine(to: CGPoint(x: frame.size.width, y: CGFloat(i) * verticalLineSpacing))
        }

        context.move(to: CGPoint(x: 0, y: frame.size.height))
        context.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height))
        
        context.strokePath()
    }

}
