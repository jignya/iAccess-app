//
//  DICTIONARY.swift
//  iACCESS
//
//  Created by Jignya Panchal on 30/09/24.
//

import UIKit
import SideMenu

class DICTIONARY: UIViewController {
    
    @IBOutlet weak var collLetter: UICollectionView!
    @IBOutlet var conLetterHeight: NSLayoutConstraint!

    @IBOutlet var lblAppname: UILabel!
    
    @IBOutlet var viewUser: UIView!
    @IBOutlet var lblUser: UILabel!
    
    @IBOutlet var btnMenu: UIButton!
    @IBOutlet var btnBack: UIButton!

    @IBOutlet var viewSearch: UIView!
    @IBOutlet var txtSearch: UITextField!

    

    
    // MARK:- PRIVATE

    private let letterHandler = LettersCollectionHandler()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserSettings.shared.arrLetters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        
        
        self.ImShSetLayout()

    }
    
    override func ImShSetLayout()
    {
        viewUser.isHidden = false
        
        // Collection Letter
        
        letterHandler.categories = UserSettings.shared.arrLetters
        self.collLetter.setUp(delegate: letterHandler, dataSource: letterHandler, cellNibWithReuseId: LetterCell.className)
        
        let width1 = ((self.collLetter.frame.size.width ) / 4) - 10
        var count = UserSettings.shared.arrLetters.count/4
        if (UserSettings.shared.arrLetters.count%4) != 0
        {
           count = count + 1
        }
        self.conLetterHeight.constant = (CGFloat(count) * (width1 + 15)) + 15
        self.collLetter.updateConstraintsIfNeeded()
        self.collLetter.layoutIfNeeded()

        
        // Handling actions
        letterHandler.didSelect =  { (indexpath) in
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DICTIONARYLIST") as! DICTIONARYLIST
            vc.strLetter = UserSettings.shared.arrLetters[indexpath.item]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

        self.navigationController?.navigationBar.isHidden = true

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

    

}
