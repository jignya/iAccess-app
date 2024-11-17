//
//  DOB.swift
//  iACCESS
//
//  Created by Jignya Panchal on 07/10/24.
//

import UIKit

class DOB: UIViewController {

    @IBOutlet weak var viewCalendar1: UIView!

    @IBOutlet weak var conviewCalendarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnShowDate: UIButton!

    @IBOutlet var btnback: UIButton!
    
    @IBOutlet weak var lblAppname: UILabel!

    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblSelecteddate: UILabel!
    
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

        btnNext.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnback.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        
        self.viewCalendar1.isHidden = true

    }

    
    //MARK: Button Methods
    
    @IBAction func btnShowDateClick(_ sender: UIButton) {

       let btn = sender
        btn.isSelected = !btn.isSelected
        if btn.isSelected
        {
            self.viewCalendar1.isHidden = false

            if #available(iOS 14.0, *) {
                datePicker.preferredDatePickerStyle = .inline
            }  else {
                datePicker.preferredDatePickerStyle = .wheels
            }
            datePicker.datePickerMode = .date
            datePicker.maximumDate = Date()
            datePicker.tintColor = UIColor(named: "themeblue")
            datePicker.addTarget(self, action: #selector(donedatePicker), for: .valueChanged)
            self.viewCalendar1.addSubview(datePicker)
            
        } else
        {
            self.viewCalendar1.isHidden = true
        }
    }
    
    @objc func donedatePicker(){

       let formatter = DateFormatter()
       formatter.dateFormat = "yyyy/MM/dd"
       lblSelecteddate.text = formatter.string(from: datePicker.date)
       self.view.endEditing(true)
     }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
    
    @IBAction func btnBackClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextClick(_ sender: UIButton)
    {
        if lblSelecteddate.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please select date of birth", duration: .lengthShort).show()
            return
        }
        else
        {
            
            UserSettings.shared.userSignUpData.updateValue(self.lblSelecteddate.text ?? "", forKey: "birthday")
            let select = self.storyboard?.instantiateViewController(withIdentifier: "SelectAllergy") as! SelectAllergy
            select.strcomeFrom = "food"
            self.navigationController?.pushViewController(select, animated: true)
        }
    }

}
