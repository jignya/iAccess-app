//
//  SIDEBAR.swift
//  iACCESS
//
//  Created by Jignya Panchal on 24/10/24.
//

import UIKit

class SIDEBAR: UIViewController {
    
    var arrList = [[String:Any]]()

    @IBOutlet weak var tblList: UITableView!
    @IBOutlet var lblAppname: UILabel!
    @IBOutlet var btnSignOut: UIButton!
    @IBOutlet var viewSignOut: UIView!
    @IBOutlet var conTblListHeight: NSLayoutConstraint!


    private let listHandler = SideListTableHandler()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        btnSignOut.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        self.ImShSetLayout()

    }
    
    override func ImShSetLayout()
    {
        
        if UserSettings.shared.isLoggedIn()
        {
            self.viewSignOut.isHidden = false
            arrList = [["name":"Account Setting","image":"account"],["name":"My Accommodations","image":"bookmark"],["name":"Location","image":"location1" ],["name":"Manage Permissions","image":"permission"],["name":"Language","image":"language"],["name":"Notifications ","image":"notification"],["name":"About & Policies","image":"info"]]
        }
        else
        {
            self.viewSignOut.isHidden = true
            arrList = [["name":"Sign In","image":"account"],["name":"Manage Permissions","image":"permission"],["name":"Language","image":"language"],["name":"Notifications ","image":"notification"],["name":"About & Policies","image":"info"]]
        }

        //Table
        
        listHandler.arrList = arrList
                
                
        self.tblList.setUpTable(delegate: listHandler, dataSource: listHandler, cellNibWithReuseId: ListCell.className)
        
        listHandler.didSelect =  { (indexpath) in
            
            if UserSettings.shared.isLoggedIn()
            {
                if indexpath.row == 0 {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "MYACCOUNT") as! MYACCOUNT
    //                vc.strcomeFrom = "side"
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
                else if indexpath.row == 1 {
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MYACCOMMODATION") as! MYACCOMMODATION
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            } else if indexpath.row == 0 {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LOGIN") as! LOGIN
                vc.strcomeFrom = "side"
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else if indexpath.row == 1 {
                
            } else if indexpath.row == 2 {
                
            }
            else if indexpath.row == 3 {
               
            }
            else if indexpath.row == 4 {
                
            }
            
        }
        
        self.conTblListHeight.constant = CGFloat(arrList.count * 50)
        self.tblList.updateConstraintsIfNeeded()
        self.tblList.layoutIfNeeded()

    }
    

    
    // MARK: - Button action
     
    @IBAction func btnSignOutClick(_ sender: UIButton) {
        
        UserSettings.shared.setLoggedOut()
        self.ImShSetLayout()
        self.tblList.reloadData()
    }
     

}
