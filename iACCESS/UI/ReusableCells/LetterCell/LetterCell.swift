//
//  LetterCell.swift
//  iACCESS
//
//  Created by Jignya Panchal on 30/09/24.
//

import UIKit

class LetterCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var viewBg: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewBg.cornerRadius = 10
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)
    }
}
