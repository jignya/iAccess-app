//
//  BottomSelectionView.swift
//

import UIKit

class BottomSelectionView: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var viewStack: UIStackView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var contblListHeight: NSLayoutConstraint!

    // MARK:- REQUIRED
    weak var delegate: SelectOptionDelegate? = nil
    var arrList = [[String:Any]]()
    var strcomeFrom : String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        lblTitle.isHidden = true
        
        if strcomeFrom == "country"
        {
            lblTitle.isHidden = false
            lblTitle.text = "Select Country"
        }
        
        self.tblList.register(delegate: self, dataSource: self, cellNibWithReuseId: BottomSeletionCell.className)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: BottomSeletionCell.className, for: indexPath) as! BottomSeletionCell
            
        cell.lblName.text = arrList[indexPath.row]["name"] as? String
        cell.imgView.isHidden = true
        
        if strcomeFrom == "country"
        {
            cell.imgView.isHidden = false
            cell.imgView.image = UIImage(named: arrList[indexPath.row]["image"] as! String)
        }
        
        contblListHeight.constant = CGFloat((arrList.count) * 45)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.delegate?.dataSelected(dict: arrList[indexPath.row], SelectedText: arrList[indexPath.row]["name"] as! String)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
       return 45
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0
    }


}
protocol SelectOptionDelegate: class
{
    func dataSelected(dict:[String:Any],SelectedText:String)
}

