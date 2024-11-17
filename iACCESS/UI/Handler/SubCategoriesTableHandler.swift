//
//  CategoriesWithImageCollectionHandler.swift


import UIKit

// MARK:- UITABLEVIEW DELEGATE, DATASOURCE, LAYOUT
class SubCategoriesTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    //    var categories = [CategoryModel]()
        var didSelect: ((IndexPath) -> Void)? = nil
        
        //MARK:- Tableview Methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 4
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.className, for: indexPath) as! TitleCell
            cell.lblName.text = "AC making Noise"
            
            cell.selectionStyle = .none
            tableView.separatorStyle = .none

            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            didSelect?(indexPath)

        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
        
    }
