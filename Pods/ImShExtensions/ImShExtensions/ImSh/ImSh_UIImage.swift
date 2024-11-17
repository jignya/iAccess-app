//
//  ImSh_UIImage.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 10/29/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    public var width: CGFloat {
        let widthInPoints = self.size.width
        return widthInPoints * self.scale
    }
    
    public var height: CGFloat {
        let heightInPoints = self.size.height
        return heightInPoints * self.scale
    }

    public func imageWithSize(size: CGSize) -> UIImage {
        var scaledImageRect = CGRect.zero
        
        let aspectWidth: CGFloat = size.width / self.size.width
        let aspectHeight: CGFloat = size.height / self.size.height
        let aspectRatio: CGFloat = min(aspectWidth, aspectHeight)
        
        scaledImageRect.size.width = self.size.width * aspectRatio
        scaledImageRect.size.height = self.size.height * aspectRatio
        scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0
        scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: scaledImageRect)
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }

    /// To check if there are any transparency layers in the given image
    ///
    /// - Returns: Boolean
    public func isTransparent() -> Bool {
        guard let alpha: CGImageAlphaInfo = self.cgImage?.alphaInfo else { return false }
        return alpha == .first || alpha == .last || alpha == .premultipliedFirst || alpha == .premultipliedLast
    }

}
