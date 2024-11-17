//
//  ImShImageManager.swift
//  Omahat
//
//  Created by Imran Mohammed on 4/5/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func setImage(url: URL?, placeholder: UIImage? = nil) {
        self.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.3))], progressBlock: nil, completionHandler: nil)
    }
    
}

