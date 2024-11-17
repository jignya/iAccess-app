//
//  CustomPopup.swift
//  CustomPopup
//

import UIKit

class CustomPopup: UIViewController {

    
    //Outlets
    
    
    @IBOutlet weak var lblmessage: UILabel!
    
    @IBOutlet weak var viewContain: UIView!
    
    @IBOutlet weak var btnok: UIButton!
    
    @IBOutlet weak var btnYes: UIButton!
    
    @IBOutlet weak var btnNo: UIButton!
    
     @IBOutlet weak var viewMainPopup: UIView!
    
     @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var viewPopup: UIView!
    
    var btn1Name = String()
    var btn2Name = String()
    var strMessage = String()
    var pActionBlock: UIAlertAction.Style?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPopup.layer.cornerRadius = 7.0
        viewPopup.layer.masksToBounds = true
        viewPopup.clipsToBounds = true
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
   
    
    @IBAction func btnOkClick(_ sender: Any) {
       
    }
    
    
    @IBAction func btnYesClick(_ sender: Any) {
       
    }
    
    @IBAction func btnNoClick(_ sender: Any) {
        
    }
    
}
