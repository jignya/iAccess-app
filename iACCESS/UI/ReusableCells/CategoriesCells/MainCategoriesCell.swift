//
//  MainCategoriesCell.swift
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

class MainCategoriesCell: UICollectionViewCell {

    // MARK:- OUTLETS
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var conImgHeight: NSLayoutConstraint!


//    var myCat: HomeCategory? {
//        didSet {
//            guard let c = myCat else { return }
//            titleLbl.text = c.name
//            thumb.setImage(url: c.imageUrl.getURL, placeholder: UIImage.image(type: .image_placeholder))
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewBg.cornerRadius = 5
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)

        
    }

}
