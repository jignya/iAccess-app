//
//  LOCATION.swift
//  iACCESS
//
//  Created by Jignya Panchal on 21/09/24.
//

import UIKit

class LOCATION: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet var btnback: UIButton!

    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtCountry: UITextField!

    @IBOutlet weak var lblWheredo: UILabel!
    @IBOutlet weak var lblAppname: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblCountry: UILabel!


    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
      
        btnNext.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnback.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        txtCity.delegate = self
        txtCountry.delegate = self
        
        self.lblCity.text = " City "
        self.lblCountry.text = " Country "


    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - button Actions
    
    @IBAction func btnBackClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        if txtCity.text?.count == 0 {
        }
        else if txtCountry.text?.count == 0{
        }
        
        UserSettings.shared.userSignUpData.updateValue(self.txtCity.text ?? "", forKey: "city")
        UserSettings.shared.userSignUpData.updateValue(self.txtCountry.text ?? "", forKey: "country")
        
        let select = self.storyboard?.instantiateViewController(withIdentifier: "DOB") as! DOB
        self.navigationController?.pushViewController(select, animated: true)

    }
    
   
    
    // MARK: - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
       
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}
