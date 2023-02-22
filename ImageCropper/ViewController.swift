//
//  ViewController.swift
//  ImageCropper
//
//  Created by Михаил Бобылев on 17.02.2023.
//

import UIKit

class ViewController: UIViewController {

    var imageScrollView: ImageScrollView!
    var imageView: UIImageView!
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Crop", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    let stepperWidth: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 5
        stepper.value = 3
        stepper.addTarget(self, action: #selector(updateWidthRatio(_:)), for: .valueChanged)
        return stepper
    }()
    
    let stepperWidthLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let stepperHeight: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 5
        stepper.value = 2
        stepper.addTarget(self, action: #selector(updateHeightRatio(_:)), for: .valueChanged)
        return stepper
    }()
    
    let stepperHeightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        stepperWidthLabel.text = "\(stepperWidth.value)"
        stepperHeightLabel.text = "\(stepperHeight.value)"
        
        let image = UIImage(named: "cat")!
        imageScrollView = ImageScrollView(frame: CGRect(origin: view.bounds.origin, size: CGSize(width: 300, height: 300))) //view.bounds
        imageScrollView.set(image: image, aspectW: stepperWidth.value, aspectH: stepperHeight.value)
        imageScrollView.aspectWidth = stepperWidth.value
        imageScrollView.aspectHeight = stepperHeight.value
        
        let image2 = UIImage()
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFit
        imageView.image = image2
        
        view.addSubview(imageScrollView)
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(stepperWidth)
        view.addSubview(stepperWidthLabel)
        view.addSubview(stepperHeight)
        view.addSubview(stepperHeightLabel)
        
        setupImageScrollView()
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let scale = 1 / imageScrollView.zoomScale
        
        let x = (imageScrollView.contentOffset.x + imageScrollView.spaceToXCenter) * scale
        let y = (imageScrollView.contentOffset.y + imageScrollView.spaceToYCenter) * scale
        let width = imageScrollView.gridLinesView.frame.size.width * scale
        let height = imageScrollView.gridLinesView.frame.size.height * scale
        let croppedCGImage = imageScrollView.imageZoomView.image?.cgImage?.cropping(to: CGRect(x: x, y: y, width: width, height: height))
        let croppedImage = UIImage(cgImage: croppedCGImage!)
        imageView.image = croppedImage
        
        print("Zoom: \(imageScrollView.zoomScale) - \(scale) - \(imageScrollView.maximumZoomScale)")
        print("imageScrollView.imageZoomView: \(imageScrollView.imageZoomView.frame.origin.x) - \(imageScrollView.imageZoomView.frame.origin.y)")
        print("imageScrollView.gridLinesView: \(imageScrollView.gridLinesView.frame.origin.x) - \(imageScrollView.gridLinesView.frame.origin.y)")
        print("imageScrollView.contentOffset: \(imageScrollView.contentOffset.x) - \(imageScrollView.contentOffset.y)")
        print("Cropped: \(x) - \(y)")
        print("Cropped: \(imageView.image!.size.width) - \(imageView.image!.size.height)")
    }
    
    @objc func updateWidthRatio(_ sender: UIStepper) {
        stepperWidthLabel.text = "\(sender.value)"
        imageScrollView.aspectWidth = stepperWidth.value
    }
    
    @objc func updateHeightRatio(_ sender: UIStepper) {
        stepperHeightLabel.text = "\(sender.value)"
        imageScrollView.aspectHeight = stepperHeight.value
    }
    
    func setupImageScrollView() {
        stepperHeightLabel.translatesAutoresizingMaskIntoConstraints = false
        stepperHeightLabel.bottomAnchor.constraint(equalTo: stepperHeight.topAnchor, constant: -4).isActive = true
        stepperHeightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        
        stepperHeight.translatesAutoresizingMaskIntoConstraints = false
        stepperHeight.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4).isActive = true
        stepperHeight.trailingAnchor.constraint(equalTo: imageScrollView.leadingAnchor, constant: 4).isActive = true
        stepperHeight.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        
        stepperWidthLabel.translatesAutoresizingMaskIntoConstraints = false
        stepperWidthLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        stepperWidthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stepperWidth.translatesAutoresizingMaskIntoConstraints = false
        stepperWidth.topAnchor.constraint(equalTo: stepperWidthLabel.bottomAnchor, constant: 4).isActive = true
        stepperWidth.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: stepperWidth.bottomAnchor, constant: 8).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        button.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 20).isActive = true
        button.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -60).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75).isActive = true
    }
}

