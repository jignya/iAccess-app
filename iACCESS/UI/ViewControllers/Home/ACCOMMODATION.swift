//
//  ACCOMMODATION.swift
//  iACCESS
//
//  Created by Jignya Panchal on 29/09/24.
//

import UIKit
import SideMenu


class ACCOMMODATION: UIViewController,ServerRequestDelegate {
    
    @IBOutlet weak var collList: UICollectionView!
    @IBOutlet weak var collOptions: UICollectionView!
    @IBOutlet var conCollHeight: NSLayoutConstraint!
    @IBOutlet var conCollOptionHeight: NSLayoutConstraint!
    @IBOutlet var lblAppname: UILabel!
    
    @IBOutlet var viewUser: UIView!
    @IBOutlet var lblUser: UILabel!
    
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var btnBack: UIButton!
    
    var strLocation: String = ""
    var strComeFrom: String = ""
    var strMedicalCondition: String = ""

    
    // MARK:- PRIVATE
    
    private let mainCatsHandler = MainCategoriesCollectionHandler()
    private let optionHandler = OptionCollectionHandler()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if strComeFrom == "medical" {
            
            UserSettings.shared.arrSubCatMedicalList = [["category":"Vision","image":"vision" ,"id":0,"isSelected":"0","isEnabled":"1"],["category":"Hearing","image":"hearing" ,"id":1,"isSelected":"0","isEnabled":"1"],["category":"Mobility","image":"mobility" ,"id":2,"isSelected":"0","isEnabled":"1"],["category":"Cognitive","image":"cognitive" ,"id":3,"isSelected":"0","isEnabled":"1"],["category":"Sensory ","image":"sensory" ,"id":4,"isSelected":"0","isEnabled":"1"],["category":"Allergy ","image":"catallergy" ,"id":5,"isSelected":"0","isEnabled":"1"],["category":"Safety ","image":"safety" ,"id":6,"isSelected":"0","isEnabled":"1"],["category":"Digestion ","image":"digestion" ,"id":7,"isSelected":"0","isEnabled":"1"],["category":"Pain ","image":"pain" ,"id":8,"isSelected":"0","isEnabled":"1"],["category":"Medical Devices ","image":"medicaldevices" ,"id":9,"isSelected":"0","isEnabled":"1"],["category":"Mental Health ","image":"mentalhealth" ,"id":10,"isSelected":"0","isEnabled":"1"],["category":"Medication ","image":"medication" ,"id":11,"isSelected":"0","isEnabled":"1"]]
        

            self.lblUser.text = String(format: "%@\nMy Accessibility Categories", self.strMedicalCondition)

        }
        else if strComeFrom == "dashboard" {
            
            UserSettings.shared.arrSubCatList = [["category":"Vision","image":"vision" ,"id":0,"isSelected":"0","isEnabled":"1"],["category":"Hearing","image":"hearing" ,"id":1,"isSelected":"0","isEnabled":"1"],["category":"Mobility","image":"mobility" ,"id":2,"isSelected":"0","isEnabled":"1"],["category":"Cognitive","image":"cognitive" ,"id":3,"isSelected":"0","isEnabled":"1"],["category":"Sensory ","image":"sensory" ,"id":4,"isSelected":"0","isEnabled":"1"],["category":"Allergy ","image":"catallergy" ,"id":5,"isSelected":"0","isEnabled":"1"],["category":"Safety ","image":"safety" ,"id":6,"isSelected":"0","isEnabled":"1"],["category":"Digestion ","image":"digestion" ,"id":7,"isSelected":"0","isEnabled":"1"],["category":"Pain ","image":"pain" ,"id":8,"isSelected":"0","isEnabled":"1"],["category":"Medical Devices ","image":"medicaldevices" ,"id":9,"isSelected":"0","isEnabled":"1"],["category":"Mental Health ","image":"mentalhealth" ,"id":10,"isSelected":"0","isEnabled":"1"],["category":"Medication ","image":"medication" ,"id":11,"isSelected":"0","isEnabled":"1"]]

            self.lblUser.text = "Choose your category"
            
            UserSettings.shared.arrSubCatListTemp = UserSettings.shared.arrSubCatList


        }
        else { // myaccommodation for Login user
            
            UserSettings.shared.arrSubCatList = [["category":"Vision","image":"vision" ,"id":0,"isSelected":"0","isEnabled":"0"],["category":"Hearing","image":"hearing" ,"id":1,"isSelected":"0","isEnabled":"0"],["category":"Mobility","image":"mobility" ,"id":2,"isSelected":"0","isEnabled":"0"],["category":"Cognitive","image":"cognitive" ,"id":3,"isSelected":"0","isEnabled":"0"],["category":"Sensory ","image":"sensory" ,"id":4,"isSelected":"0","isEnabled":"0"],["category":"Allergy ","image":"catallergy" ,"id":5,"isSelected":"0","isEnabled":"0"],["category":"Safety ","image":"safety" ,"id":6,"isSelected":"0","isEnabled":"0"],["category":"Digestion ","image":"digestion" ,"id":7,"isSelected":"0","isEnabled":"0"],["category":"Pain ","image":"pain" ,"id":8,"isSelected":"0","isEnabled":"0"],["category":"Medical Devices ","image":"medicaldevices" ,"id":9,"isSelected":"0","isEnabled":"0"],["category":"Mental Health ","image":"mentalhealth" ,"id":10,"isSelected":"0","isEnabled":"0"],["category":"Medication ","image":"medication" ,"id":11,"isSelected":"0","isEnabled":"0"]]
            
            UserSettings.shared.arrSubCatListTemp = UserSettings.shared.arrSubCatList

        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.ImShSetLayout()
        
        if strLocation != "" && self.strComeFrom == "myaccommodation"
        {
            self.getAccessibilityCategoriesForUser(strlocation: self.strLocation)
        }
//        else if strLocation != "" && self.strComeFrom != "medical"
//        {
//            self.getAccessibilityCategories(strlocation: self.strLocation)
//        }
        
    }
    
    
    override func ImShSetLayout()
    {
        viewUser.isHidden = false
        
        // collection Category
        mainCatsHandler.categories = UserSettings.shared.arrCatList
        self.collList.setUp(delegate: mainCatsHandler, dataSource: mainCatsHandler, cellNibWithReuseId: MainCategoriesCell.className)
        
        self.collList.reloadData()
        let width = ((self.collList.frame.width ) / 3) - 10
        self.conCollHeight.constant = (CGFloat((UserSettings.shared.arrCatList.count/3)) * (width + 15)) + 15
        self.collList.updateConstraintsIfNeeded()
        self.collList.layoutIfNeeded()
        
        
        
        // Handling actions
        mainCatsHandler.didSelect =  { (indexpath) in
            
            
            for i in 0..<UserSettings.shared.arrCatList.count
            {
                var dict = UserSettings.shared.arrCatList[i]
                
                if i == indexpath.item
                {
                    self.strLocation = dict["name"] as? String ?? ""
                    dict["isSelected"] = "1"
                }
                else
                {
                    dict["isSelected"] = "0"
                }
                
                UserSettings.shared.arrCatList[i] = dict
            }
            
            if self.strComeFrom == "myaccommodation"  // login user flow
            {
                self.getAccessibilityCategoriesForUser(strlocation: self.strLocation) // API call to get accessibilty categories
            }
            
            self.mainCatsHandler.categories = UserSettings.shared.arrCatList
            self.collList.reloadData()
        }
        
        //Collection Options
        
        self.collOptions.setUp(delegate: optionHandler, dataSource: optionHandler, cellNibWithReuseId: AccessibilityCell.className)

        
        if strComeFrom == "dashboard" {
            optionHandler.categories = UserSettings.shared.arrSubCatList
            self.collOptions.reloadData()

            let width1 = ((self.collOptions.frame.width ) / 3) - 10
            var count = UserSettings.shared.arrSubCatList.count/3
            if (UserSettings.shared.arrSubCatList.count%3) != 0
            {
                count = count + 1
            }
            self.conCollOptionHeight.constant = (CGFloat(count) * (width1 + 30)) + 15
            self.collOptions.updateConstraintsIfNeeded()
            self.collOptions.layoutIfNeeded()
        }
        else if strComeFrom == "myaccommodation" {
//            optionHandler.categories = UserSettings.shared.arrSubCatList
//            self.collOptions.reloadData()

            let width1 = ((self.collOptions.frame.width ) / 3) - 10
            var count = UserSettings.shared.arrSubCatList.count/3
            if (UserSettings.shared.arrSubCatList.count%3) != 0
            {
                count = count + 1
            }
            self.conCollOptionHeight.constant = (CGFloat(count) * (width1 + 30)) + 15
            self.collOptions.updateConstraintsIfNeeded()
            self.collOptions.layoutIfNeeded()
        }
        else
        {
            optionHandler.categories = UserSettings.shared.arrSubCatMedicalList
            self.collOptions.reloadData()
            
            let width1 = ((self.collOptions.frame.width ) / 3) - 10
            var count = UserSettings.shared.arrSubCatMedicalList.count/3
            if (UserSettings.shared.arrSubCatMedicalList.count%3) != 0
            {
                count = count + 1
            }
            self.conCollOptionHeight.constant = (CGFloat(count) * (width1 + 30)) + 15
            self.collOptions.updateConstraintsIfNeeded()
            self.collOptions.layoutIfNeeded()
        }
        
        
        // Handling actions
        optionHandler.didSelect =  { (indexpath) in
            
            if self.strComeFrom == "medical" { //  medical condition flow
                let dict = UserSettings.shared.arrSubCatMedicalList[indexpath.item]
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DETAIL") as! DETAIL
                vc.strCategory = dict["category"] as? String ?? ""
                vc.strLocation = self.strLocation
                vc.strMedicalCondition = self.strMedicalCondition
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if self.strComeFrom == "dashboard" { // normal dashboard flow
                let dict = UserSettings.shared.arrSubCatList[indexpath.item]
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DETAIL") as! DETAIL
                vc.strCategory = dict["category"] as? String ?? ""
                vc.strLocation = self.strLocation
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else  // login user flow
            {
                let dict = UserSettings.shared.arrSubCatList[indexpath.item]
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DETAIL") as! DETAIL
                vc.strCategory = dict["category"] as? String ?? ""
                vc.strLocation = self.strLocation
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    // MARK:  Button action
    
    @IBAction func btnMenuClick(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SIDEBAR") as! SIDEBAR
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.menuWidth = (self.view.frame.size.width - 100)
        menu.presentationStyle = .menuSlideIn
        present(menu, animated: true, completion: nil)
        
    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: ServerRequestDelegate
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...")
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
    
    //MARK: - Api call
    
//    func getAccessibilityCategories(strlocation: String) {
//
//        let param = ["location":strLocation,"method":"Category"]
//        ServerRequest.shared.getApiData(urlString: "myAccessibility.php", param: param) { result in
//
//            DispatchQueue.main.async {
//
//                print(result)
//                if result.count > 0
//                {
//                    let arrData = result
//
//                    for i in 0..<UserSettings.shared.arrSubCatList.count
//                    {
//                        var dict = UserSettings.shared.arrSubCatList[i]
//                        dict["isEnabled"] = "0"
//
//                        let arr1 = arrData.filter {$0["category"] as? String == dict["category"] as? String}
//                        if arr1.count > 0
//                        {
//                            dict["isEnabled"] = "1"
//                        }
//
//                        UserSettings.shared.arrSubCatList[i] = dict
//                    }
//
//                    self.optionHandler.categories = UserSettings.shared.arrSubCatList
//                    self.collOptions.reloadData()
//                }
//                else
//                {
//                    UserSettings.shared.arrSubCatList = UserSettings.shared.arrSubCatListTemp
//                    self.optionHandler.categories = UserSettings.shared.arrSubCatList
//                    self.collOptions.reloadData()
//
//                    print("No record found")
//                }
//            }
//        }
//
//    }
    
    
    
    func getAccessibilityCategoriesForUser(strlocation: String) {
        
        let param = ["location":strLocation,"method":"Category","userId":UserSettings.shared.getUserId()]
        ServerRequest.shared.getApiData(urlString: "myAccessibility.php", param: param, delegate: self) { (result,response) in
            
            DispatchQueue.main.async {
                
                print(result)
                if result.count > 0
                {
                    let arrData = result
                    
                    for i in 0..<UserSettings.shared.arrSubCatList.count
                    {
                        var dict = UserSettings.shared.arrSubCatList[i]
                        dict["isEnabled"] = "0"
                        
                        let arr1 = arrData.filter {$0["category"] as? String == dict["category"] as? String}
                        if arr1.count > 0
                        {
                            dict["isEnabled"] = "1"
                        }
                        
                        UserSettings.shared.arrSubCatList[i] = dict
                    }
                    
                    self.optionHandler.categories = UserSettings.shared.arrSubCatList
                    self.collOptions.reloadData()
                }
                else
                {
                    UserSettings.shared.arrSubCatList = UserSettings.shared.arrSubCatListTemp
                    self.optionHandler.categories = UserSettings.shared.arrSubCatList
                    self.collOptions.reloadData()
                    
                    print("No record found")
                }
            }
        }
        
    }
    
    
}
