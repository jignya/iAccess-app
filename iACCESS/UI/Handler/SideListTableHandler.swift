//
//  DashboardListTableHandler.swift


import UIKit

// MARK:- UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class SideListTableHandler : NSObject, UITableViewDelegate, UITableViewDataSource
{
    
    var arrList = [[String:Any]]()
    var strComefrom:String!
    var didSelect: ((IndexPath) -> Void)? = nil
    
    //MARK:- Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.className, for: indexPath) as! ListCell
        
        let dict = arrList[indexPath.row]
        
        cell.lblName.text = dict["name"] as? String
        cell.img.image = UIImage(named: dict["image"] as? String ?? "")

        cell.selectionStyle = .none

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(indexPath)
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}



