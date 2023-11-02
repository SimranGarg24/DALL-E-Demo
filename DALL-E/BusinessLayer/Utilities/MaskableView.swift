//
//  MaskableView.swift
//  DALL-E
//
//  Created by Saheem Hussain on 30/10/23.
//

import SwiftUI
import UIKit.UIGestureRecognizerSubclass

enum DrawingAction: Int, CaseIterable {
    case erase = 0
    case draw = 1
}

struct MaskView: UIViewRepresentable {
    
    @Binding var circleRadius: CGFloat
    @Binding var drawingAction: DrawingAction
    @Binding var mask: UIImage? // mask image
    
    var image: UIImage? // original image
    
    typealias UIViewType = MaskableView
    
    func makeUIView(context: Context) -> MaskableView {
        
        let view = MaskableView()
        
        view.circleCursorColor = UIColor(red: 1, green: 1, blue: 0, alpha: 0.8)
        view.outerCircleCursorColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.originalImage = image
        view.updateBounds()
        
        // Set the closure to update the mask in MaskView
        view.updateMaskCallback = { finalMask in
            self.mask = finalMask
        }
        
        return view
    }
    
    func updateUIView(_ uiView: MaskableView, context: Context) {
        // if circleRadius and drawing action is changed by user, update MaskableView
        uiView.circleRadius = circleRadius
        uiView.drawingAction = drawingAction
    }
}

class MaskableView: UIView {

    // MARK: - Properties
    public var originalImage: UIImage?
    public var drawingAction: DrawingAction = .erase
    
    public var maskDrawingAlpha: CGFloat = 0.5
    
    public var image: UIImage? {
        guard let renderer = renderer else { return nil}
        let result = renderer.image { context in

            return layer.render(in: context.cgContext)
        }
        return result
    }
    
    public var updateMaskCallback: ((UIImage?) -> Void)?
    
    @IBInspectable public var circleRadius: CGFloat = 20
    
    /// This color is used to draw the "cursor" around the circle shape being drawn onto the mask layer.
    /// By default the color is nil (no cursor)
    /// Set a color if you want to stroke the circle being drawn.
    @IBInspectable public var circleCursorColor: UIColor? {
        didSet { shapeLayer.strokeColor = circleCursorColor?.cgColor }
    }

    /// This color is used to draw an outer circle around the  circle shape being drawn onto the mask layer.
    /// By default the color is nil (no cursor)
    /// Use a outerCircleCursorColor that contrasts with the  circleCursorColor
    /// (e.g. use a dark outerCircleCursorColor for a light circleCursorColor)
    @IBInspectable public var outerCircleCursorColor: UIColor? {
        didSet { outerShapeLayer.strokeColor = outerCircleCursorColor?.cgColor }
    }

    // MARK: - Private Properties

    private var maskImage: UIImage?
    private var maskLayer = CALayer()
    private var shapeLayer = CAShapeLayer()
    private var outerShapeLayer = CAShapeLayer()
    private var renderer: UIGraphicsImageRenderer?
    private var panGestureRecognizer = TouchDownPanGestureRecognizer()

    private var firstTime = true
    
    // MARK: - Object lifecycle methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        doInitSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        doInitSetup()
    }

    // MARK: - Methods
    func doInitSetup() {
        
        shapeLayer.strokeColor = circleCursorColor?.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.fillColor = UIColor.clear.cgColor
        outerShapeLayer.strokeColor = outerCircleCursorColor?.cgColor
        outerShapeLayer.lineWidth = 1
        outerShapeLayer.fillColor = UIColor.clear.cgColor

        layer.mask = maskLayer

        // Set up a pan gesture recognizer to erase/un-erase a series of circles as the user drags over the image.
        panGestureRecognizer.addTarget(self, action: #selector(gestureRecognizerUpdate(_:)))
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    public func updateBounds() {
        
        // add original image in MaskableView as subview
        setupImageView()
        
        maskLayer.frame = layer.bounds
        shapeLayer.frame = layer.frame
        outerShapeLayer.frame = layer.frame
        if firstTime {
            
            renderer = UIGraphicsImageRenderer(size: bounds.size)
            installSampleMask()
            layer.superlayer?.addSublayer(shapeLayer)
            layer.superlayer?.addSublayer(outerShapeLayer)
            firstTime = false
        } else {
            guard let renderer = renderer else { return }
            let image = renderer.image { _ in
                if let maskImage = maskImage {
                    maskImage.draw(in: bounds)
                }
            }
            maskImage = image
            maskLayer.contents = maskImage?.cgImage

        }
    }
    
    private func setupImageView() {
        if firstTime {
            if let image = originalImage {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
                self.addSubview(imageView)
                
                var newFrame = self.frame
                newFrame.size.width = imageView.frame.origin.x + imageView.frame.size.width
                newFrame.size.height = imageView.frame.origin.y + imageView.frame.size.height
                self.frame = newFrame
            }
        }
    }

    private func installSampleMask() {
        guard let renderer = renderer else { return }
        let image = renderer.image { (ctx) in
            UIColor.black.setFill()
            ctx.fill(bounds, blendMode: .normal)
        }
        maskImage = image
        maskLayer.contents = maskImage?.cgImage

    }

    private func drawCircleAtPoint(point: CGPoint) {
        
        guard let renderer = renderer else { return }
        let image = renderer.image { (context) in
            if let maskImage = maskImage {
                maskImage.draw(in: bounds)
                 let rect = CGRect(origin: point, size: CGSize.zero).insetBy(dx: -circleRadius/2, dy: -circleRadius/2)
                let color = UIColor.black.cgColor
                context.cgContext.setFillColor(color)
                let blendMode: CGBlendMode
                let alpha: CGFloat
                if drawingAction == .erase {
                    // This is what I worked out to reduce the alpha of the mask by maskDrawingAlpha in the drawing area
                    blendMode = .clear
                    alpha = 1 - maskDrawingAlpha
                } else {
                    // In normal drawing mode the new drawing alpha is added to the alpha of the existing area.
                    blendMode = .normal
                    alpha = maskDrawingAlpha
                }

                if circleCursorColor != nil {
                    let circlePath = UIBezierPath(ovalIn: rect)
                    circlePath.fill(with: blendMode, alpha: alpha)
                    shapeLayer.path = circlePath.cgPath
                }

                if outerCircleCursorColor != nil {
                    let outerRect = rect.insetBy(dx: -2, dy: -2)
                    let outerCirclePath = UIBezierPath(ovalIn: outerRect)
                    outerCirclePath.fill(with: blendMode, alpha: alpha)
                    outerShapeLayer.path = outerCirclePath.cgPath
                }
            }
        }
        maskImage = image
        maskLayer.contents = maskImage?.cgImage
    }

    // MARK: - IBAction methods
    
    // Erase/un-erase the point from the tap/pan gesture recognzier
    @IBAction func gestureRecognizerUpdate(_ sender: UIGestureRecognizer) {
        let point = sender.location(in: self)
        if sender.state != .ended {
            // gesture starts
            drawCircleAtPoint(point: point)
        } else {
            // gesture ends
            self.shapeLayer.path = nil
            self.outerShapeLayer.path = nil
            // Update Mask image when gesture ends
            updateMaskCallback?(image)
        }
    }
    
}
