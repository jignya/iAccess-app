//
//  TitleCell.swift
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var img: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CommonFunction.shared.setFontFamily(for: self.contentView, andSubViews: true)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
