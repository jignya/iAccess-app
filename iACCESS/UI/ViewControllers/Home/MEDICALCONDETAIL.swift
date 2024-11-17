//
//  MEDICALCONDETAIL.swift
//  iACCESS
//
//  Created by Jignya Panchal on 30/09/24.
//

import UIKit
import SideMenu

class MEDICALCONDETAIL: UIViewController,UITextFieldDelegate,ServerRequestDelegate {
        
    var arrOptionList = [[String:Any]]()
    var strLetter : String = ""
    var strLocation : String = ""
    var strcomeFrom : String = ""
    var search:String=""

    
    @IBOutlet weak var tblList: UITableView!
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
    
    private let detailListsHandler = DetailListTableHandler()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblNorecord.tag = 26
        self.txtSearch.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.txtSearch.text = ""
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.ImShSetLayout()
        
        if strcomeFrom == "myaccommodation" {
            self.getAllMedicalConditionForUser()
        } else {
            self.getAllMedicalCondition(strlocation: self.strLocation)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.txtSearch.resignFirstResponder()
    }
    
    
    
    override func ImShSetLayout()
    {
        viewUser.isHidden = false
        
        lblUser.text = strLetter
        
        
        //Table
        
        detailListsHandler.strComefrom = "medical"
        
        self.tblList.setUpTable(delegate: detailListsHandler, dataSource: detailListsHandler, cellNibWithReuseId: ExpandableCell.className)
        
        
        detailListsHandler.didSelect =  { (indexpath) in
            
            let dict = self.arrOptionList[indexpath.row]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ACCOMMODATION") as! ACCOMMODATION
            vc.strComeFrom = "medical"
            vc.strMedicalCondition = dict["term"] as? String ?? ""
            vc.strLocation = self.strLocation
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        detailListsHandler.didBookmark = { (index) in
            
            let cell = self.tblList.cellForRow(at: IndexPath(row: index, section: 0)) as! ExpandableCell
            
            let dict = self.arrOptionList[index]
            let medConditionId = dict["id"] as? Int ?? 0
            
            if cell.btnBookmark.isSelected
            {
                self.AddRemoveMedicalCondition(method: "Delete", id: medConditionId)
            }
            else
            {
                self.AddRemoveMedicalCondition(method: "Add", id: medConditionId)
            }
        }
        
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
        
        let arrFilter = self.arrOptionList.filter{($0["term"] as? String ?? "").localizedCaseInsensitiveContains(search)}
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
    
    func getAllMedicalCondition(strlocation: String) {
        
        let param = ["location":strLocation,"method":"Letter","letter":strLetter]
        ServerRequest.shared.getApiData(urlString: "medical_conditions.php", param: param, delegate: self) { (result,response) in
            
            DispatchQueue.main.async {
                
                print(result)
                if result.count > 0
                {
                    self.tblList.isHidden = false
                    self.lblNorecord.isHidden = true
                    self.txtSearch.isEnabled = true
                    self.arrOptionList = result
                    self.detailListsHandler.arrList = self.arrOptionList
                    
                    for i in 0..<self.detailListsHandler.arrList.count {
                        var dict = self.detailListsHandler.arrList[i]
                        dict["isSelected"] = "0"
                        self.detailListsHandler.arrList[i] = dict
                    }
                    
                    
                    self.tblList.reloadData()
                    self.conTblListHeight.constant = CGFloat(self.arrOptionList.count * 80)
                    self.tblList.updateConstraintsIfNeeded()
                    self.tblList.layoutIfNeeded()
                    
                }
                else
                {
                    self.tblList.isHidden = true
                    self.lblNorecord.isHidden = false
                    self.lblNorecord.text = String(format: "No medical condition found")
                    self.txtSearch.isEnabled = false
                    print("No record found")
                }
            }
        }
        
    }
    
    func getAllMedicalConditionForUser() {
        
        let param = ["method":"showAll","userId":UserSettings.shared.getUserId()]
        
        ServerRequest.shared.getApiData(urlString: "myMedicalCondition.php", param: param, delegate: self) { (result,response) in
            
            DispatchQueue.main.async {
                
                print(result)
                if result.count > 0
                {
                    self.tblList.isHidden = false
                    self.lblNorecord.isHidden = true
                    self.txtSearch.isEnabled = true
                    
                    
                    let arrFilterData = result.filter {($0["term"] as? String)?.first == self.strLetter}
                    
                    if arrFilterData.count == 0 {
                        
                        self.tblList.isHidden = true
                        self.lblNorecord.isHidden = false
                        self.lblNorecord.text = String(format: "No medical condition found")
                        self.txtSearch.isEnabled = false
                        print("No record found")
                        return
                        
                    }
                    
                    self.arrOptionList = arrFilterData
                    
                    self.detailListsHandler.arrList = self.arrOptionList
                    
                    for i in 0..<self.detailListsHandler.arrList.count {
                        var dict = self.detailListsHandler.arrList[i]
                        dict["isSelected"] = "1"
                        self.detailListsHandler.arrList[i] = dict
                    }
                    
                    self.tblList.reloadData()
                    self.conTblListHeight.constant = CGFloat(self.arrOptionList.count * 80)
                    self.tblList.updateConstraintsIfNeeded()
                    self.tblList.layoutIfNeeded()
                    
                }
                else
                {
                    self.tblList.isHidden = true
                    self.lblNorecord.isHidden = false
                    self.lblNorecord.text = String(format: "No medical condition found")
                    self.txtSearch.isEnabled = false
                    print("No record found")
                }
            }
        }
        
    }
    
    func AddRemoveMedicalCondition(method: String,id: Int) -> Void {
        
        let param = ["method":method,"medicalConditionId":String(id),"userId":UserSettings.shared.getUserId()]
        ServerRequest.shared.getApiData(urlString: "myMedicalCondition.php", param: param, delegate: self) { (result,response) in
            
            DispatchQueue.main.async {
                
                print(result)
                if response.count > 0
                {
                    AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "Success", aStrMessage:response["message"] as? String ?? "" , aOKBtnTitle: "Okay") { index, title in
                        
                        if self.strcomeFrom == "myaccommodation" {
                            
                            self.getAllMedicalConditionForUser()
                            
                        }
                        
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
