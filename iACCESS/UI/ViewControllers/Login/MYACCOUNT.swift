//
//  MYACCOUNT.swift
//  iACCESS
//
//  Created by Jignya Panchal on 24/10/24.
//

import UIKit

class MYACCOUNT: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet var btnback: UIButton!
    @IBOutlet weak var btnChangePW: UIButton!

    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDob: UITextField!


    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblFirstname: UILabel!
    @IBOutlet weak var lblLastname: UILabel!
    @IBOutlet weak var lblAppname: UILabel!
    @IBOutlet weak var lblDob: UILabel!

    let datePicker = UIDatePicker()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
      
        btnSave.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnback.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        
        btnChangePW.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        
        txtUsername.keyboardType = .asciiCapable
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        self.txtUsername.delegate = self
        self.txtFirstname.delegate = self
        self.txtLastname.delegate = self
        self.txtEmail.delegate = self
        self.txtDob.delegate = self

        
        self.lblUsername.setLabelValue(" Username ")
        self.lblFirstname.setLabelValue(" Firstname ")
        self.lblLastname.setLabelValue(" Lastname ")
        self.lblEmail.setLabelValue(" Email ")
        self.lblDob.setLabelValue(" Date of birth ")
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }  else {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.tintColor = UIColor(named: "themeblue")
        datePicker.addTarget(self, action: #selector(donedatePicker), for: .valueChanged)
        self.txtDob.inputView = datePicker

    }
    
    @objc func donedatePicker(){

       let formatter = DateFormatter()
       formatter.dateFormat = "yyyy/MM/dd"
       txtDob.text = formatter.string(from: datePicker.date)
       self.view.endEditing(true)
     }

    
    // MARK: - button Actions
    
    @IBAction func btnChangePWClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        let login = self.storyboard?.instantiateViewController(withIdentifier: "CHANGEPW") as! CHANGEPW
        self.navigationController?.pushViewController(login, animated: true)

    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {

        self.view.endEditing(true)

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        if txtUsername.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter username", duration: .lengthShort).show()
            return

        } else if txtUsername.text?.count ?? 0 < 3 {
            SnackBar.make(in: self.view, message: "Username should be more than 3 characters", duration: .lengthShort).show()
            return

        }
        else if txtFirstname.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter firstname", duration: .lengthShort).show()
            return

        }
        else if txtLastname.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter lastname", duration: .lengthShort).show()
            return
        }
        else if txtEmail.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter email", duration: .lengthShort).show()

        } else if txtEmail.text?.isValidEmail == false
        {
            SnackBar.make(in: self.view, message: "Please enter valid email", duration: .lengthShort).show()
            return
            
        } else if txtDob.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please select date of birth", duration: .lengthShort).show()
            return
        }
        else {
            
            self.view.endEditing(true)
            UserSettings.shared.setLoggedIn()
            let storyboard = UIStoryboard.init(name: "Dashboard", bundle: nil)
            let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
            AppDelegate.shared.window?.rootViewController = navigationController
            AppDelegate.shared.window?.makeKeyAndVisible()
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
