//
//  MYACCOMMODATION.swift
//  iACCESS
//
//  Created by Jignya Panchal on 24/10/24.
//

import UIKit

class MYACCOMMODATION: UIViewController {
    
    var arrOptionList = [[String:Any]]()

    @IBOutlet weak var collList: UICollectionView!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet var conCollHeight: NSLayoutConstraint!
    @IBOutlet var conTblListHeight: NSLayoutConstraint!
    @IBOutlet var lblAppname: UILabel!
    
    @IBOutlet var viewUser: UIView!
    @IBOutlet var lblUser: UILabel!
    
    @IBOutlet var btnMenu: UIButton!


    
    // MARK:- PRIVATE

    private let mainCatsHandler = MainCategoriesCollectionHandler()
    private let mainListsHandler = DashboardListTableHandler()


    override func viewDidLoad() {
        super.viewDidLoad()
                
        arrOptionList = [["name":"Accessibility Category","image":"accessibility" ,"id":0],["name":"Medical Conditions","image":"caduceus" ,"id":1],["name":"Allergies","image":"myallergies.png" ,"id":2]]
        
        self.ImShSetLayout()

    }
    
    override func ImShSetLayout()
    {
//        viewUser.isHidden = true
        
        // collection
        mainCatsHandler.categories = UserSettings.shared.arrCatList
        self.collList.setUp(delegate: mainCatsHandler, dataSource: mainCatsHandler, cellNibWithReuseId: MainCategoriesCell.className)
        
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
                }
                else
                {
                    dict["isSelected"] = "0"
                }
                
                UserSettings.shared.arrCatList[i] = dict
            }
            
            self.mainCatsHandler.categories = UserSettings.shared.arrCatList
            self.collList.reloadData()
        }
        
        //Table
        
        mainListsHandler.arrList = arrOptionList
                
                
        self.tblList.setUpTable(delegate: mainListsHandler, dataSource: mainListsHandler, cellNibWithReuseId: TitleCell.className)
        
        mainListsHandler.didSelect =  { (indexpath) in
            
            if indexpath.row == 0 || indexpath.row == 1
            {
                let arr1 = UserSettings.shared.arrCatList.filter { $0["isSelected"] as? String == "1" }
                
                if arr1.count == 0
                {
                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "OOPS", aStrMessage: "Please select any location to proceed", aOKBtnTitle: "Okay") { index, title in
                    }
                }
                else
                {
                    if indexpath.row == 0
                    {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ACCOMMODATION") as! ACCOMMODATION
                        vc.strLocation = (arr1[0]["name"] as? String)?.lowercased() ?? ""
                        vc.strComeFrom = "myaccommodation"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else if indexpath.row == 1
                    {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MEDICALCON") as! MEDICALCON
                        vc.strLocation = (arr1[0]["name"] as? String)?.lowercased() ?? ""
                        vc.strComeFrom = "myaccommodation"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            else if indexpath.row == 2
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ALLERGIES") as! ALLERGIES
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        self.conTblListHeight.constant = CGFloat(arrOptionList.count * 70)
        self.tblList.updateConstraintsIfNeeded()
        self.tblList.layoutIfNeeded()

    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

        self.navigationController?.navigationBar.isHidden = true

    }

    
    //MARK: - Button action
    
    @IBAction func btnBackClick(_ sender: UIButton) {

        let storyboard = UIStoryboard.init(name: "Dashboard", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
        AppDelegate.shared.window?.rootViewController = navigationController
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    

}
