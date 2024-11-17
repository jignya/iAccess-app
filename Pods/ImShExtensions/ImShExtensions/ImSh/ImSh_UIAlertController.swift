//
//  ImSh_UIAlertController.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 10/29/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    public func addImage(image: UIImage?) {
        guard let image = image else { return }
        let maxSize = CGSize(width: 245, height: 300)
        let imgSize = image.size
        
        var ratio: CGFloat!
        if (imgSize.width > imgSize.height) {
            ratio = maxSize.width / imgSize.width
        } else {
            ratio = maxSize.height / imgSize.height
        }
        
        let scalledSize = CGSize(width: imgSize.width * ratio, height: imgSize.height * ratio)
        var resizedImage = image.imageWithSize(size: scalledSize)
        
        if (imgSize.height > imgSize.width) {
            let left = (maxSize.width - resizedImage.size.width) / 2
            resizedImage = resizedImage.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -left, bottom: 0, right: 0))
        }
        
        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = false
        imgAction.setValue(resizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")
        self.addAction(imgAction)
    }
    
}
