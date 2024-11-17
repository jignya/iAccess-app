//
//  ArrowButton.swift
//

import UIKit

class ArrowButton: UIView {

    // MARK:- OUTLETS
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!

    
    // MARK:- REQUIRED
    weak var delegate: ArrowButtonDelegate? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ArrowButton", owner: self, options: nil)
    }

    // MARK:- PUBLIC
    func setup(title: String?, delegate: ArrowButtonDelegate?) {
        
        
        imgIcon.image = UIImage(named: "Language")
        
        self.titleLbl.text = title
        self.delegate = delegate
    }
    
    func updateTitle(title: String?) {
        self.titleLbl.text = title
    }
    
    // MARK:- ACTION HANDLERS
    @IBAction func buttonTapped(_ sender: UIButton) {
        self.delegate?.arrowBtnTapped(tag: self.tag)
    }
    
}

protocol ArrowButtonDelegate: class {
    func arrowBtnTapped(tag: Int)
}
