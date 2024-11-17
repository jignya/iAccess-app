//
//  ALLERGIES.swift
//  iACCESS
//
//  Created by Jignya Panchal on 24/10/24.
//

import UIKit

class ALLERGIES: UIViewController,ServerRequestDelegate {

    @IBOutlet weak var tblList: UITableView!
    @IBOutlet var conTblListHeight: NSLayoutConstraint!
    @IBOutlet var lblAppname: UILabel!
    
    @IBOutlet var viewUser: UIView!
    @IBOutlet var lblUser: UILabel!
    
    @IBOutlet var lblNote: UILabel!
    @IBOutlet var lblDesc: UILabel!

    
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet var lblNorecord: UILabel!

    
    // MARK:- PRIVATE

    private let detailListsHandler = AllergyListHandler()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblNorecord.tag = 26
        self.ImShSetLayout()
        self.getAllUserAllergies()

    }
    
    override func ImShSetLayout()
    {
        viewUser.isHidden = false

        //Table
                    
        self.tblList.setUpTable(delegate: detailListsHandler, dataSource: detailListsHandler, cellNibWithReuseId: AllergyCell.className)
            
        
        detailListsHandler.didSelect =  { (indexpath) in
            
            var dict = self.detailListsHandler.arrAllergies[indexpath.row]

            if dict["isSelected"] as? String == "1" {
                dict["isSelected"] = "0"
            }
            else {
                dict["isSelected"] = "1"
            }
            self.detailListsHandler.arrAllergies[indexpath.row] = dict

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

    
    // MARK: - Button action
    
    @IBAction func btnMenuClick(_ sender: UIButton) {
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SIDEBAR") as! SIDEBAR
//        let menu = SideMenuNavigationController(rootViewController: vc)
//        menu.menuWidth = (self.view.frame.size.width - 100)
//        menu.presentationStyle = .menuSlideIn
//        present(menu, animated: true, completion: nil)
        
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

    func getAllUserAllergies() {
        
        let param = ["method":"allallergies","iaccess_id":UserSettings.shared.getUserId()]
        ServerRequest.shared.getApiData(urlString: "myallergies.php", param: param, delegate: self) { (result,response) in
            
            DispatchQueue.main.async {
                if result.count > 0
                {
                    var groupedItems: [[String: Any]] = []

                    let tempGrouping = Dictionary(grouping: result) { $0["type"] as! String }
                    for (type, items) in tempGrouping {
                        let titles = items.compactMap { $0["title"] as? String }
                        groupedItems.append(["type": type.capitalized, "titles": titles])
                    }

                    // Print the grouped format
                    print(groupedItems)
                                        
                    self.tblList.isHidden = false
                    self.lblNorecord.isHidden = true
                    
                    self.detailListsHandler.arrAllergies = groupedItems

                    for i in 0..<self.detailListsHandler.arrAllergies.count {
                        var dict = self.detailListsHandler.arrAllergies[i]
                        dict["isSelected"] = "0"
                        self.detailListsHandler.arrAllergies[i] = dict
                    }

                    self.tblList.reloadData()
                    self.conTblListHeight.constant = CGFloat(self.detailListsHandler.arrAllergies.count * 80)
                    self.tblList.updateConstraintsIfNeeded()
                    self.tblList.layoutIfNeeded()

                }
                else
                {
                    self.tblList.isHidden = true
                    self.lblNorecord.isHidden = false
                    self.lblNorecord.text = String(format: "No data available")
                    print("No record found")
                }
            }
        }
        
    }

    

}
