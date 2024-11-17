//
//  DETAIL.swift
//  iACCESS
//
//  Created by Jignya Panchal on 30/09/24.
//

import UIKit
import SideMenu

class DETAIL: UIViewController,UITextFieldDelegate,ServerRequestDelegate {
    
    var arrOptionList = [[String:Any]]()
    var strCategory = ""
    var strLocation = ""
    var strMedicalCondition = ""
    var search:String=""

    
    @IBOutlet weak var collList: UICollectionView!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet var conCollHeight: NSLayoutConstraint!
    @IBOutlet var conTblListHeight: NSLayoutConstraint!
    @IBOutlet var lblAppname: UILabel!
    
    @IBOutlet var viewUser: UIView!
    @IBOutlet var lblUser: UILabel!
    
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var txtSearch: UITextField!
    
    @IBOutlet var lblNorecord: UILabel!
    
    
    
    // MARK:- PRIVATE
    
    private let mainCatsHandler = MainCategoriesCollectionHandler()
    private let detailListsHandler = DetailListTableHandler()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblNorecord.tag = 26
        self.txtSearch.delegate = self
        self.ImShSetLayout()
        
    }
    
    override func ImShSetLayout()
    {
        self.lblUser.text = self.strCategory
        viewUser.isHidden = false
        
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
                    self.strLocation = dict["name"] as? String ?? ""
                    dict["isSelected"] = "1"
                }
                else
                {
                    dict["isSelected"] = "0"
                }
                
                UserSettings.shared.arrCatList[i] = dict
            }
            
            self.getAccessibilityData(location: self.strLocation, category: self.strCategory) // API call to get accessibilty categories
            
            
            self.mainCatsHandler.categories = UserSettings.shared.arrCatList
            self.collList.reloadData()
        }
        
        //Table
        
        
        self.tblList.setUpTable(delegate: detailListsHandler, dataSource: detailListsHandler, cellNibWithReuseId: ExpandableCell.className)
        
        self.tblList.estimatedRowHeight = 80
        self.tblList.rowHeight = UITableView.automaticDimension
        
        DispatchQueue.main.async {
            self.getAccessibilityData(location: self.strLocation, category: self.strCategory)
            
        }
        
        
        detailListsHandler.didSelect =  { (indexpath) in
            
            var dict = self.detailListsHandler.arrList[indexpath.row]
            
            if dict["isSelected"] as? String == "1" {
                dict["isSelected"] = "0"
            }
            else {
                dict["isSelected"] = "1"
            }
            self.detailListsHandler.arrList[indexpath.row] = dict
            self.tblList.reloadData()
            self.tblList.updateConstraintsIfNeeded()
            self.tblList.layoutIfNeeded()
            self.conTblListHeight.constant = self.tblList.contentSize.height
            
        }
        
        detailListsHandler.didBookmark = { (index) in
            
            let cell = self.tblList.cellForRow(at: IndexPath(row: index, section: 0)) as! ExpandableCell
            
            let dict = self.arrOptionList[index]
            let accomodationId = dict["id"] as? Int ?? 0
            
            if cell.btnBookmark.isSelected
            {
                self.AddRemoveAccessibilityData(method: "Delete", id: accomodationId)
            }
            else
            {
                self.AddRemoveAccessibilityData(method: "Add", id: accomodationId)
            }
        }
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.txtSearch.resignFirstResponder()
    }
    
    
    // MARK: - Button action
    
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
    
    //MARK: Textfield as a Searchbar
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string.isEmpty
        {
            search = String(search.dropLast())
        }
        else
        {
            search=textField.text!+string
        }

        print(search)
        
        let arrFilter = self.arrOptionList.filter{($0["accommodation"] as? String ?? "").localizedCaseInsensitiveContains(search)}
        if arrFilter.count > 0
        {
            self.detailListsHandler.arrList = arrFilter
            self.tblList.reloadData()
            self.tblList.isHidden = (self.detailListsHandler.arrList.count == 0)
            self.lblNorecord.isHidden = (self.detailListsHandler.arrList.count > 0)

        }
        else
        {
            self.detailListsHandler.arrList = []
            self.tblList.reloadData()
            self.tblList.isHidden = (self.detailListsHandler.arrList.count == 0)
            self.lblNorecord.isHidden = (self.detailListsHandler.arrList.count > 0)
        }
        
        if search.isEmpty
        {
            self.detailListsHandler.arrList = self.arrOptionList
            self.tblList.reloadData()
            self.tblList.isHidden = (self.detailListsHandler.arrList.count == 0)
            self.lblNorecord.isHidden = (self.detailListsHandler.arrList.count > 0)
            self.txtSearch.text = ""
            textField.resignFirstResponder()

        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField.text?.count == 0
        {
            self.detailListsHandler.arrList = self.arrOptionList
            self.tblList.reloadData()
            self.tblList.isHidden = (self.detailListsHandler.arrList.count == 0)
            self.lblNorecord.isHidden = (self.detailListsHandler.arrList.count > 0)
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        self.detailListsHandler.arrList = self.arrOptionList
        self.tblList.reloadData()
        self.tblList.isHidden = (self.detailListsHandler.arrList.count == 0)
        self.lblNorecord.isHidden = (self.detailListsHandler.arrList.count > 0)
        textField.resignFirstResponder()
        return true

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
    func getAccessibilityData(location: String, category:String) {
        
        var param:[String:String] = [:]
        
        if self.strMedicalCondition == ""
        {
            param = ["location":location,"category":category]
        }
        else
        {
            param = ["location":location,"category":category,"medicalCondition":self.strMedicalCondition]
        }
        
        ServerRequest.shared.getApiData(urlString: "accommodation.php", param: param, delegate: self) { (result,response) in
            
            DispatchQueue.main.async {
                
                print(result)
                if result.count > 0
                {
                    self.tblList.isHidden = false
                    self.lblNorecord.isHidden = true
                    self.txtSearch.isEnabled = true
                    
                    self.arrOptionList = result
                    self.detailListsHandler.arrList = self.arrOptionList
                    self.tblList.reloadData()
                    self.conTblListHeight.constant = self.tblList.contentSize.height
                    self.tblList.updateConstraintsIfNeeded()
                    self.tblList.layoutIfNeeded()
                    self.conTblListHeight.constant = self.tblList.contentSize.height
                    
                }
                else
                {
                    print("No record found")
                    self.lblNorecord.text = String(format: "No accomodations available for %@ at %@", self.strCategory, self.strLocation)
                    self.tblList.isHidden = true
                    self.lblNorecord.isHidden = false
                    self.txtSearch.isEnabled = false
                    
                    
                }
            }
        }
        
    }
    
    
    func AddRemoveAccessibilityData(method: String,id: Int) -> Void {
        
        let param = ["method":method,"accommodationId":String(id),"userId":UserSettings.shared.getUserId()]
        ServerRequest.shared.getApiData(urlString: "myAccessibility.php", param: param, delegate: self) { (result,response) in
            
            DispatchQueue.main.async {
                
                print(result)
                if response.count > 0
                {
                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "Success", aStrMessage:response["message"] as? String ?? "" , aOKBtnTitle: "Okay") { index, title in
                        
                    }
                    
                }
                else
                {
                    print("No record found")
                }
            }
        }
        
    }
    
    
}
