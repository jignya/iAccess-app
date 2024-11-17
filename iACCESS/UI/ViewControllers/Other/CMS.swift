//
//  CMS.swift
//

import UIKit

class CMS: UIViewController , UITextViewDelegate {
    
    static func create(title: String?) -> CMS {
        let cmsvc = CMS.instantiate(fromImShStoryboard: .Other)
        cmsvc.strTitle = title
        return cmsvc
    }
    
    @IBOutlet weak var txtContent: UITextView!
    
    var strTitle : String!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view , andSubViews: true)
        
        DispatchQueue.main.async{
            self.navigationController?.navigationBar.topItem?.title = self.strTitle
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
        
//        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.roboto(size: 18),.foregroundColor: UserSettings.shared.ScreentitleColor()]


    }
    

}
