//
//  SelectAllergy.swift
//  iACCESS
//
//  Created by Jignya Panchal on 21/09/24.
//

import UIKit

class SelectAllergy: UIViewController,ServerRequestDelegate {
    
    var strcomeFrom:String!
    var strType:String!

    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var conTblListHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet var btnback: UIButton!
    @IBOutlet var btnOther: UIButton!
    @IBOutlet var btnIdonothave: UIButton!

    @IBOutlet weak var lblOther: UILabel!
    @IBOutlet weak var lbldesc: UILabel!

    @IBOutlet weak var lblAppname: UILabel!
    @IBOutlet weak var txtOther: UITextField!


    
    private let allergylisthandler = SelectAllergyTableHandler()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.ImShSetLayout()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

        btnNext.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnback.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        

    }
    
    override func ImShSetLayout()
    {
        if strcomeFrom == "food" {
            
            strType = "food"
            lbldesc.text = "Any food allergies?"

        } else if strcomeFrom == "env"{
            
            strType = "environmental"
            lbldesc.text = "Any environmental allergies?"

        }
        else {
            
            strType = "medical"
            lbldesc.text = "Any medical allergies?"

        }
                
        
        allergylisthandler.strComefrom = strcomeFrom
        
        self.tblList.setUpTable(delegate: allergylisthandler, dataSource: allergylisthandler, cellNibWithReuseId: SelectionCell.className)
                
        allergylisthandler.didSelect =  { (indexpath) in
            
            for i in 0..<self.allergylisthandler.arrList.count
            {
                var dict = self.allergylisthandler.arrList[i]
                
                if i == indexpath.row
                {
                    if dict["isSelected"] as! String == "0" {
                        dict["isSelected"] = "1"
                    } else {
                        dict["isSelected"] = "0"
                    }
                    self.allergylisthandler.arrList[i] = dict
                }
            }
            
            self.tblList.reloadData()
        }
        
        self.getAllergyData(strType: strType)
        
    }

    

    // MARK: - button Actions
    
    @IBAction func btnOtherClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnIdonotHaveClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        if txtOther.text?.count != 0
        {
            if strcomeFrom == "food" {
                UserSettings.shared.userSignUpData.updateValue(self.txtOther.text ?? "", forKey: "otherFood")

            } else if strcomeFrom == "env"{
                UserSettings.shared.userSignUpData.updateValue(self.txtOther.text ?? "", forKey: "otherEnvironment")
            } else {
                UserSettings.shared.userSignUpData.updateValue(self.txtOther.text ?? "", forKey: "otherMedical")

            }
        }
        
        
        //            let stringArray = [0,1,1,0].map{String($0)}.joined(separator: ",")

        if strcomeFrom == "food" {
            
            let selectedData = self.allergylisthandler.arrList.filter {$0["isSelected"] as! String == "1" }
            let stringArray = selectedData.map { $0["title"] }
            UserSettings.shared.userSignUpData.updateValue(stringArray, forKey: "foodAllergies")


            
            let select = self.storyboard?.instantiateViewController(withIdentifier: "SelectAllergy") as! SelectAllergy
            select.strcomeFrom = "env"
            self.navigationController?.pushViewController(select, animated: true)

        } else if strcomeFrom == "env"{
            
            let selectedData = self.allergylisthandler.arrList.filter {$0["isSelected"] as! String == "1" }
            let stringArray = selectedData.map { $0["title"] }
            UserSettings.shared.userSignUpData.updateValue(stringArray, forKey: "environmentAllergies")
            
            let select = self.storyboard?.instantiateViewController(withIdentifier: "SelectAllergy") as! SelectAllergy
            select.strcomeFrom = "medical"
            self.navigationController?.pushViewController(select, animated: true)
        }
        else
        {

            let selectedData = self.allergylisthandler.arrList.filter {$0["isSelected"] as! String == "1" }
            let stringArray = selectedData.map { $0["title"] }
            UserSettings.shared.userSignUpData.updateValue(stringArray, forKey: "medical")
            
            self.signUpUser()
    
        }
    }
    
   
    
    // MARK: - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
       
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
    
    func getAllergyData(strType: String) {
        
        let param = ["type":strType]
        ServerRequest.shared.getApiData(urlString: "allergies.php", param: param, delegate: self) { (result,response) in
            
            DispatchQueue.main.async {
                
                print(result)
                if result.count > 0
                {
                    self.tblList.isHidden = false
                    self.allergylisthandler.arrList = result
                    
                    for i in 0..<self.allergylisthandler.arrList.count
                    {
                        var dict = self.allergylisthandler.arrList[i]
                        dict["isSelected"] = "0"
                        self.allergylisthandler.arrList[i] = dict
                    }
                    
                    self.tblList.reloadData()
                    self.conTblListHeight.constant = CGFloat(50*(self.allergylisthandler.arrList.count))
                    self.tblList.updateConstraintsIfNeeded()
                    self.tblList.layoutIfNeeded()
                }
                else
                {
                    self.tblList.isHidden = true
                    print("No record found")
                }
            }
        }
        
    }
        
    func signUpUser() {
        
        let param = UserSettings.shared.userSignUpData
        print(param)
        ServerRequest.shared.postApiData(urlString: "signup.php", params: param, delegate: self) { result in
            
            DispatchQueue.main.async {
                
                print(result)
                UserSettings.shared.userSignUpData.removeAll()
                UserSettings.shared.setLoggedIn()
                let storyboard = UIStoryboard.init(name: "Dashboard", bundle: nil)
                let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
                AppDelegate.shared.window?.rootViewController = navigationController
                AppDelegate.shared.window?.makeKeyAndVisible()
            }
        }
        
    }

}

extension UITableView {
    
    public func setUpTable(delegate: UITableViewDelegate?, dataSource: UITableViewDataSource?, cellNibWithReuseId: String? = nil) {
        if let nibReuseId = cellNibWithReuseId {
            
            self.register(UINib.init(nibName: nibReuseId, bundle: nil), forCellReuseIdentifier: nibReuseId)
        }
        self.delegate = delegate
        self.dataSource = dataSource
    }

}
