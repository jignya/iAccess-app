//
//  MainCategoriesCell.swift
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

class AccessibilityCell: UICollectionViewCell {

    // MARK:- OUTLETS
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var conImgHeight: NSLayoutConstraint!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewBg.cornerRadius = 5
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)

        
    }

}
