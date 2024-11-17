//
//  ImSh_UIView.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 10/20/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import UIKit

extension UIView {
    
    /// To animate tap effect
    public func animateTap() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [], animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { (_) in
            UIView.animate(withDuration: 0.15, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
    }
    
    /// To set semantic direction
    ///
    /// - Parameter direction: UISemanticContentAttribute
    public func setSemantic(direction: UISemanticContentAttribute) {
        self.semanticContentAttribute = direction
    }
    
    /// To animate flashing effect
    ///
    /// - Parameter duration: Double
    public func startFlashing(withDuration duration: Double = 2) {
        UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState], animations: {
            self.alpha = 0.4
        }, completion: { (finished) in
            UIView.animate(withDuration: 2, delay: 2, options: [.autoreverse, .repeat], animations: {
                self.alpha = 1
            }, completion: nil)
        })
    }
    
    /// To rotate view
    ///
    /// - Parameters:
    ///   - toValue: CGFloat
    ///   - duration: CFTimeInterval
    public func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    /// To animate rotation
    ///
    /// - Parameters:
    ///   - toValue: CGFloat
    ///   - duration: CFTimeInterval
    ///   - completion: Handler
    public func animateRotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2, completion: ((Bool) -> Swift.Void)? = nil) {
        var rotateTrans = CGAffineTransform(rotationAngle: toValue)
        if toValue == 0 {
            rotateTrans = CGAffineTransform.identity
        }
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            self.transform = rotateTrans
        }, completion: completion)
    }
    
    /// To animate fall effect
    ///
    /// - Parameter completion: Handler
    public func fall(completion: ((Bool) -> Swift.Void)? = nil) {
        let rotateTrans = CGAffineTransform(rotationAngle: -30)
        let fallTrans = CGAffineTransform(translationX: 10, y: 300)
        UIView.animate(withDuration: 0.9, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: [.curveEaseOut], animations: {
            self.transform = rotateTrans.concatenating(fallTrans)
            self.alpha = 0
        }, completion: completion)
    }
    
    /// To animate fadeout effect
    ///
    /// - Parameters:
    ///   - to: CGFloat
    ///   - completion: Handler
    public func fadeOut(to: CGFloat = 0.0, completion: ((Bool) -> Swift.Void)? = nil) {
        UIView.animate(withDuration: 0.9, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: [.curveEaseOut], animations: {
            self.alpha = to
        }, completion: completion)
    }
    
    /// To animate fadein effect
    ///
    /// - Parameter completion: Handler
    public func fadeIn(completion: ((Bool) -> Swift.Void)? = nil) {
        UIView.animate(withDuration: 0.9, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: [.curveEaseOut], animations: {
            self.alpha = 1
        }, completion: completion)
    }
    
    /// To animate shrink/grow effect
    ///
    /// - Parameters:
    ///   - toPercent: CGFloat
    ///   - completion: Handler
    public func shrinkOrGrow(toPercent: CGFloat, completion: ((Bool) -> Swift.Void)? = nil) {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [.curveEaseInOut], animations: {
            self.transform = CGAffineTransform.init(scaleX: toPercent, y: toPercent)
        }, completion: nil)
    }
    
    /// Animating the flip of UIView
    ///
    /// - Parameters:
    ///   - toView: ViewThat should appear after animation
    ///   - duration: Duration of complete animation
    ///   - transitionOptions: ex: .transitionFlipFromBottom, .showHideTransitionViews
    ///   - completion: optional Boolean
    public func flip(toView: UIView, duration: TimeInterval, transitionOptions: UIView.AnimationOptions, completion: ((Bool) -> Swift.Void)? = nil) {
        UIView.transition(with: self, duration: duration, options: transitionOptions, animations: {
            self.isHidden = true
        }, completion: nil)
        UIView.transition(with: toView, duration: duration, options: transitionOptions, animations: {
            toView.isHidden = false
        }, completion: nil)
    }
    
    /// To animate shake effect
    public func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
   
    /// To make self with shape
    ///
    /// - Parameter refImage: UIImage?
    public func maskOfShape(refImage: UIImage?) {
        let mask = CALayer()
        mask.contents = refImage?.cgImage
        mask.frame = layer.bounds
        layer.mask = mask
    }
    
    /// To get a snapshot of self
    ///
    /// - Returns: UIImage
    public func getSnapshotImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        let snapshotImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return snapshotImage
    }
    
    /// To round desired corners
    ///
    /// - Parameters:
    ///   - corners: UIRectCorner
    ///   - radius: CGFloat
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    /// To fix a view inside a view
    func fixInView(container: UIView) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }

}

@IBDesignable
public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set (new) {
            self.layer.cornerRadius = new
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set (new) {
            self.layer.borderWidth = new
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.white.cgColor)
        }
        set (new) {
            self.layer.borderColor = new.cgColor
        }
    }
    
    @IBInspectable var isCircle: Bool {
        get {
            return self.layer.cornerRadius == (bounds.height / 2)
        }
        set (new) {
            self.layer.cornerRadius = new ? (bounds.height / 2) : 0
        }
    }
    
}
