//
//  MEDICALCON.swift
//  iACCESS
//
//  Created by Jignya Panchal on 30/09/24.
//

import UIKit
import SideMenu

class MEDICALCON: UIViewController {
    
    var arrOptionList = [[String:Any]]()
    var strLocation: String = ""
    var strComeFrom: String = ""

    @IBOutlet weak var collList: UICollectionView!
    @IBOutlet weak var collLetter: UICollectionView!
    @IBOutlet var conCollHeight: NSLayoutConstraint!
    @IBOutlet var conLetterHeight: NSLayoutConstraint!

    @IBOutlet var lblAppname: UILabel!
    
    @IBOutlet var viewUser: UIView!
    @IBOutlet var lblUser: UILabel!
    
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var btnBack: UIButton!

    @IBOutlet var viewSearch: UIView!
    @IBOutlet var txtSearch: UITextField!

    

    
    // MARK:- PRIVATE

    private let mainCatsHandler = MainCategoriesCollectionHandler()
    private let letterHandler = LettersCollectionHandler()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserSettings.shared.arrLetters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

        self.navigationController?.navigationBar.isHidden = true

        self.ImShSetLayout()
        
//        self.getAllMedicalCondition(strlocation: self.strLocation)

    }
    
    override func ImShSetLayout()
    {
        viewUser.isHidden = false
        
        // collection
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
                    dict["isSelected"] = "1"
                    self.strLocation = dict["name"] as? String ?? ""
                }
                else
                {
                    dict["isSelected"] = "0"
                }
                
                UserSettings.shared.arrCatList[i] = dict
            }
            
//            self.getAllMedicalCondition(strlocation: self.strLocation) // to get all condition based on selected locatiom

            self.mainCatsHandler.categories = UserSettings.shared.arrCatList
            self.collList.reloadData()
        }
        
        // Collection Letter
        
        letterHandler.categories = UserSettings.shared.arrLetters
        self.collLetter.setUp(delegate: letterHandler, dataSource: letterHandler, cellNibWithReuseId: LetterCell.className)
        
        let width1 = ((self.collLetter.frame.size.width ) / 4) - 10
        var count = UserSettings.shared.arrLetters.count/4
        if (UserSettings.shared.arrLetters.count%4) != 0
        {
           count = count + 1
        }
        self.conLetterHeight.constant = (CGFloat(count) * (width1 + 15)) + 15
        self.collLetter.updateConstraintsIfNeeded()
        self.collLetter.layoutIfNeeded()

        
        // Handling actions
        letterHandler.didSelect =  { (indexpath) in
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MEDICALCONDETAIL") as! MEDICALCONDETAIL
            vc.strLetter = UserSettings.shared.arrLetters[indexpath.item]
            vc.strLocation = self.strLocation
            vc.strcomeFrom = self.strComeFrom
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
    //MARK: - Button action
    
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
//    func getAllMedicalCondition(strlocation: String) {
//
//        let param = ["location":strLocation,"method":"All"]
//        ServerRequest.shared.getApiData(urlString: "medical_conditions.php", param: param) { result in
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

    

}
