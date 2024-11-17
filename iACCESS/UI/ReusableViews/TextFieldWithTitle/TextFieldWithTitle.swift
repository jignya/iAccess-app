//
//  TextFieldWithTitle.swift
//

import UIKit

class TextFieldWithTitle: UIView {

    // MARK:- OUTLETS
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // MARK:- PUBLIC
    var text: String? {
        get {
            return self.textField.text
        }
        set(new) {
            self.textField.text = new
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TextFieldWithTitle", owner: self, options: nil)
//        contentView.fixInView(container: self)
    }

    // MARK:- PUBLIC FUNCTIONS
    func setup(title: String?,
               placeholder: String?,
               defaultText: String?,
               keyboardType: UIKeyboardType = .default,
               delegate: UITextFieldDelegate? = nil,
               isSecureEntry: Bool = false) {
        
        self.titleLbl.text = title
        self.textField.placeholder = placeholder
        self.text = defaultText
        self.textField.isSecureTextEntry = isSecureEntry
        self.textField.keyboardType = keyboardType
        self.textField.delegate = delegate
    }
    
}
