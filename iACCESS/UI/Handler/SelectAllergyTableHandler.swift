//
//  CategoriesWithImageCollectionHandler.swift


import UIKit

// MARK:- UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class SelectAllergyTableHandler : NSObject, UITableViewDelegate, UITableViewDataSource
{
    
    var arrList = [[String:Any]]()
    var strComefrom:String!
    var didSelect: ((IndexPath) -> Void)? = nil
    
    //MARK:- Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionCell.className, for: indexPath) as! SelectionCell
        
        let dict = self.arrList[indexPath.row]
        cell.lblName.text = dict["title"] as? String ?? ""
        
        if dict["isSelected"] as! String == "1" {
            cell.imgArw.image = UIImage(named: "tick")
            cell.imgArw.tintColor = UIColor(red: 15/255, green: 192/255, blue: 252/255, alpha: 1)
        } else {
            cell.imgArw.image = UIImage(named: "untick")
        }
        cell.selectionStyle = .none

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(indexPath)
        
//        let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as! SelectionCell
//        cell.imgArw.image = UIImage(systemName: "checkmark.square.fill")
//        cell.imgArw.tintColor = UIColor(red: 15/255, green: 192/255, blue: 252/255, alpha: 1)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}



