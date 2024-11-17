//
//  AllergyListHandler.swift
//  iACCESS
//
//  Created by Jignya Panchal on 24/10/24.
//

import Foundation
import UIKit

// MARK:- UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class AllergyListHandler : NSObject, UITableViewDelegate, UITableViewDataSource
{
    
    var arrAllergies = [[String: Any]]()

    var strComefrom:String!
    var didSelect: ((IndexPath) -> Void)? = nil
    
    //MARK:- Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAllergies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllergyCell.className, for: indexPath) as! AllergyCell
        
        let dict = arrAllergies[indexPath.row]
        
        
        cell.lblTitle.text = (dict["type"] as? String ?? "").capitalized + " allergies"
        let commaSeparatedTitles = (dict["titles"] as? [String] ?? []).joined(separator: ", ")
        cell.lblDesc.text = commaSeparatedTitles
        
        if dict["isSelected"] as? String  == "1"
        {
            cell.stackData.backgroundColor = UIColor(named: "themeblue")
            cell.viewDesc.isHidden = false
            cell.btnArrow.isSelected = true
        }
        else
        {
            cell.stackData.backgroundColor = UIColor(named: "themelightgray")
            cell.viewDesc.isHidden = true
            cell.btnArrow.isSelected = false

        }
        
        cell.btnArrow.tag = indexPath.row
        cell.btnArrow.addTarget(self, action: #selector(btnBookmarkClick(_ :)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
    
    @objc func btnBookmarkClick(_ sender: Any) {
        
        let btn = sender as! UIButton
//        btn.isSelected = !btn.isSelected
        
    }
    
}
