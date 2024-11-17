//
//  DICTIONARYLIST.swift
//  iACCESS
//
//  Created by Jignya Panchal on 01/10/24.
//

import UIKit
import SideMenu

class DICTIONARYLIST: UIViewController,UITextFieldDelegate,ServerRequestDelegate {
    
    var arrOptionList = [[String:Any]]()
    var strLetter : String = ""
    var search : String = ""
    
    
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
        self.ImShSetLayout()
        self.getDictionaryData()
    }
    
    override func ImShSetLayout()
    {
        viewUser.isHidden = false
        
        lblUser.text = strLetter
        
        
        //Table
        
        detailListsHandler.strComefrom = "dictionary"
        detailListsHandler.arrList = arrOptionList
        
        
        self.tblList.setUpTable(delegate: detailListsHandler, dataSource: detailListsHandler, cellNibWithReuseId: ExpandableCell.className)
        
        self.tblList.reloadData()
        self.conTblListHeight.constant = CGFloat(self.arrOptionList.count * 80)
        self.tblList.updateConstraintsIfNeeded()
        self.tblList.layoutIfNeeded()
        
        
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
            self.conTblListHeight.constant = self.tblList.contentSize.height
            self.tblList.updateConstraintsIfNeeded()
            self.tblList.layoutIfNeeded()
            self.conTblListHeight.constant = self.tblList.contentSize.height
            
        }
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        self.navigationController?.navigationBar.isHidden = true
        
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
    
    //MARK: - API call
    
    func getDictionaryData()  {
        
        let param = ["letter":strLetter,"method":"Letter"]
        ServerRequest.shared.getApiData(urlString: "dictionary.php", param: param, delegate: self) { (result,response)  in
            
            DispatchQueue.main.async {
                
                if result.count > 0 {
                    
                    self.tblList.isHidden = false
                    self.lblNorecord.isHidden = true
                    self.txtSearch.isEnabled = true
                    
                    self.arrOptionList = result
                    self.detailListsHandler.arrList = self.arrOptionList
                    
                    for i in 0..<self.arrOptionList.count
                    {
                        var dict = self.arrOptionList[i]
                        dict["isSelected"] = "0"
                        self.arrOptionList[i] = dict
                    }
                    
                    self.tblList.reloadData()
                    self.conTblListHeight.constant = CGFloat(self.arrOptionList.count * 80)
                    self.tblList.updateConstraintsIfNeeded()
                    self.tblList.layoutIfNeeded()
                    
                } else {
                    
                    self.tblList.isHidden = true
                    self.lblNorecord.isHidden = false
                    self.lblNorecord.text = String(format: "No data found")
                    self.txtSearch.isEnabled = false
                    
                }
                
            }
        }
    }
    
}
