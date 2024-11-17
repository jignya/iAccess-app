//
//  CHANGEPW.swift
//  iACCESS
//
//  Created by Jignya Panchal on 24/10/24.
//

import UIKit

class CHANGEPW: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet var btnback: UIButton!

    @IBOutlet weak var txtOldPW: UITextField!
    @IBOutlet weak var txtConfirmPW: UITextField!
    @IBOutlet weak var txtNewPW: UITextField!


    @IBOutlet weak var lblAppname: UILabel!
    @IBOutlet weak var lblOldPW: UILabel!
    @IBOutlet weak var lblNewPW: UILabel!
    @IBOutlet weak var lblConfirmPW: UILabel!


    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
      
        btnSave.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnback.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        self.txtOldPW.delegate = self
        self.txtNewPW.delegate = self
        self.txtConfirmPW.delegate = self

        self.lblOldPW.setLabelValue(" Old Password ")
        self.lblNewPW.setLabelValue(" New Password ")
        self.lblConfirmPW.setLabelValue(" Confirm Password ")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - button Actions
    
    @IBAction func btnBackClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        if txtOldPW.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter old password", duration: .lengthShort).show()

        } else if txtNewPW.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter new password", duration: .lengthShort).show()

        } else if txtNewPW.text?.count ?? 0 < 6 {
            SnackBar.make(in: self.view, message: "Password should be more than 6 characters", duration: .lengthShort).show()
            return

        }
        else if txtConfirmPW.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter confirm password", duration: .lengthShort).show()
            
        } else if txtConfirmPW.text != txtNewPW.text
        {
            SnackBar.make(in: self.view, message: "Password does not match", duration: .lengthShort).show()
        }
        else {
         
            self.view.endEditing(true)
            self.navigationController?.popViewController(animated: true)
        }

    }
    
   
    
    // MARK: - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
       
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}
