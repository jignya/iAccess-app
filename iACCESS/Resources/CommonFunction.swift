//
//  CommonFunction.swift
//

import UIKit

class CommonFunction: NSObject {
    
    static let shared = CommonFunction()
    var tabbarController = CustomTabbarVC()
   
    //MARK:- set In text file
    
    func documentsDirectory() -> String
    {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        return documentsFolderPath
    }
    
    
    func SaveArrayDatainTextFile(fileName:String , arrData:[[String:Any]])
    {
        var jsonData: NSData!
        do
        {
            jsonData = try JSONSerialization.data(withJSONObject: arrData, options: JSONSerialization.WritingOptions()) as NSData
        }
        catch let error as NSError
        {
            print("Array to JSON conversion failed: \(error.localizedDescription)")
        }
        let file = fileName
        let writePath = (self.documentsDirectory() as NSString).appendingPathComponent(file)
        jsonData!.write(toFile: writePath, atomically:true)
    }
    func getArrayDataFromTextFile(fileName:String) -> [[String:Any]]
    {
        let file = fileName
        
        var dataarray : [[String:Any]] = []
        
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file)
            do {
                let text2 = try String(contentsOf: path!, encoding: .utf8)
                
                let data = text2.data(using: String.Encoding.utf8)
                
               let jsonArray = try JSONSerialization.jsonObject(with:data!, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                
                dataarray = jsonArray as! [[String:Any]]
            }
            catch let error as NSError
            {
                print(error.localizedDescription)
            }
        }
        return dataarray
    }
    
    func SaveDatainTextFile(fileName:String , arrData:[String:Any])
    {
        var jsonData: NSData!
        do
        {
            jsonData = try JSONSerialization.data(withJSONObject: arrData, options: JSONSerialization.WritingOptions()) as NSData
        }
        catch let error as NSError
        {
            print("Array to JSON conversion failed: \(error.localizedDescription)")
        }
        let file = fileName
        let writePath = (self.documentsDirectory() as NSString).appendingPathComponent(file)
        jsonData!.write(toFile: writePath, atomically:true)
    }
//    func getJsonDataFromTextFile(fileName:String) -> JSON
//    {
//        let file = fileName
//        
//        var dataarray : JSON = []
//        
//        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first {
//            let path = NSURL(fileURLWithPath: dir).appendingPathComponent(file)
//            do {
//                let text2 = try String(contentsOf: path!, encoding: .utf8)
//                
//                let data = text2.data(using: String.Encoding.utf8)
//                
//                let json = try JSON(data: data!, options: JSONSerialization.ReadingOptions.allowFragments)
//                
//                dataarray = json
//
//            }
//            catch let error as NSError
//            {
//                print(error.localizedDescription)
//            }
//        }
//        
//        return dataarray
//    }
    
    
    //MARK:- Add tabbar
    
    func addTabBar(_ controller: UIViewController? , tab : Int)
    {
        let window: UIWindow? = (UIApplication.shared.delegate?.window)!
        
        var bottomPadding : CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            bottomPadding = (window?.safeAreaInsets.bottom)!
        }
        
        tabbarController = CustomTabbarVC(nibName: "CustomTabbarVC", bundle: nil)
        tabbarController.view.tag = 111
        tabbarController.tab = tab
        
        controller?.view?.addSubview(tabbarController.view)

        if let aWidth = window?.frame.size.width
        {
            tabbarController.view.frame = CGRect(x: 0, y: (window?.frame.size.height)! - 50 - bottomPadding, width: aWidth, height: 50)
        }
       
        tabbarController.view.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleTopMargin.rawValue)))
        
    }
    
    //MARK:- FontSet
    func setFontFamily(for view: UIView, andSubViews isSubViews: Bool)
    {
        if (view is UILabel)
        {
            let lbl = view as? UILabel
            if lbl?.tag == 25
            {
                if let aSize = UIFont.roboto(size: (lbl?.font.pointSize)!, weight: .Bold) {
                    lbl?.font = aSize
                }
            }
            else if lbl?.tag == 26
            {
                if let aSize = UIFont.roboto(size: (lbl?.font.pointSize)!, weight: .Medium) {
                    lbl?.font = aSize
                }
            }
            else
            {
                if let aSize = UIFont.roboto(size: (lbl?.font.pointSize)!, weight: .Regular)
                {
                    lbl?.font = aSize
                }
            }
        }
        if (view is UITextView)
        {
            let txt = view as? UITextView
            
            if let aSize = txt?.font?.pointSize
            {
                txt?.font = UIFont.roboto(size: aSize, weight: .Regular)
            }
            
        }

//            if (view is UIButton)
//            {
//                let btn = view as! UIButton
//
//                if let aSize = btn.titleLabel?.font?.pointSize
//                {
//                    if btn.tag == 25
//                    {
//                        btn.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
//
//                    }
//                    else if btn.tag == 26
//                    {
//                        btn.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Medium)
//
//                    }
//                    else
//                    {
//                        btn.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Regular)
//                    }
//
//                }
//            }
        
        if (view is UITextField)
        {
            let txt1 = view as? UITextField
            
            txt1?.tintColor = UIColor.darkGray
            
            if let aSize = txt1?.font?.pointSize
            {
                if txt1?.tag == 25
                {
                    txt1?.font = UIFont.roboto(size: aSize, weight: .Bold)

                }
                else if txt1?.tag == 26
                {
                    txt1?.font = UIFont.roboto(size: aSize, weight: .Medium)
                }
                else
                {
                    txt1?.font = UIFont.roboto(size: aSize, weight: .Regular)

                }
            }
        }
        
        if (view is UIImageView)
        {
            let imgview = view as? UIImageView
            
            if imgview?.tag == 15
            {
//                    imgview?.image = imgview?.image!.withRenderingMode(.alwaysTemplate)
//                    imgview?.tintColor = UIColor.darkGray

            }
            
        }
        
        if isSubViews
        {
            for sview: UIView in view.subviews
            {
                setFontFamily(for: sview, andSubViews: true)
            }
        }
    }


}
