//
//  AJAlertController.Swift
//  AJAlertController
//

import UIKit
import Foundation

class AJAlertController: UIViewController {
    
    // MARK:- Private Properties
    // MARK:-

    private var strAlertTitle = String()
    private var strAlertText = String()
    private var btnCancelTitle:String?
    private var btnOtherTitle:String?
   private var btnOKTitle:String?
    
    
    private let btnOtherColor  = UIColor.white
    private let btnCancelColor = UIColor.white
    
    // MARK:- Public Properties
    // MARK:-

    @IBOutlet var viewAlert: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblAlertText: UILabel?
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnOther: UIButton!
    @IBOutlet var btnOK: UIButton!
    @IBOutlet var viewAlertBtns: UIView!
    @IBOutlet var btnClose: UIButton!
    
    @IBOutlet var conViewAlertWidth: NSLayoutConstraint!
    @IBOutlet var conViewCenter: NSLayoutConstraint!

    
    var isOkonly : Bool = false
    var isBottom : Bool = false
    
    var nib: String?

    
    /// AlertController Completion handler
    typealias alertCompletionBlock = ((Int, String) -> Void)?
    private var block : alertCompletionBlock?
    
    // MARK:- AJAlertController Initialization    
    /**
     Creates a instance for using AJAlertController
     - returns: AJAlertController
     */
    static func initialization() -> AJAlertController
    {
        let alertController = AJAlertController(nibName: "AJAlertController", bundle: nil)
        return alertController

    }
    
    static func initialization1() -> AJAlertController
    {
        let alertController = AJAlertController(nibName: "AJAlertController1", bundle: nil)
        return alertController

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnOther.setTitle("", for: .normal)
        btnOK.setTitle("", for: .normal)
        btnCancel.setTitle("", for: .normal)

        setupAJAlertController()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

    }
    
    // MARK:- AJAlertController Private Functions
    
    /// Inital View Setup
    private func setupAJAlertController()
    {
        lblTitle.text   = strAlertTitle
        lblAlertText?.text   = strAlertText
        
        
        if isBottom
        {
            viewAlert.roundCorners(corners: [.topRight, .topLeft], radius: 20)

            let Height = UIScreen.main.bounds.height / 2
            let ViewHeight = self.viewAlert.frame.size.height / 2
            
            print(Height, ViewHeight , self.view.frame.size.width)
            
            conViewCenter.constant =  Height - ViewHeight

        }
        else
        {
            viewAlert.cornerRadius = 5
            viewAlert.clipsToBounds = true
            
        }
        
        btnCancel.setTitle(btnCancelTitle, for: .normal)
        btnOK.setTitle(btnOKTitle, for: .normal)
        btnOther.setTitle(btnOtherTitle, for: .normal)

        btnCancel.setTitleColor(btnCancelColor, for: .normal)
        btnOther.setTitleColor(btnCancelColor, for: .normal)
        btnOK.setTitleColor(btnCancelColor, for: .normal)
        
        if isOkonly
        {
            btnCancel.isHidden = true
            btnOther.isHidden = true
            btnOK.isHidden = false

        }
        else
        {
            btnOK.isHidden = true
            btnCancel.isHidden = false
            btnOther.isHidden = false

        }
        
        btnCancel.roundCorners(corners: [.topLeft, .bottomLeft], radius: 23)
        btnOther.roundCorners(corners: [.topRight, .bottomRight], radius: 23)
    }
    
    override func viewWillLayoutSubviews() {
        
        self.setupAJAlertController()
        
        if let aSize = btnOK.titleLabel?.font?.pointSize
        {
            btnOK.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnOther.titleLabel?.font?.pointSize
        {
            btnOther.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }
        if let aSize = btnCancel.titleLabel?.font?.pointSize
        {
            btnCancel.titleLabel?.font =  UIFont.roboto(size: aSize, weight: .Bold)
        }

    }
    
    /// Setup different widths for iPad and iPhone
    private func preferredAlertWidth()
    {
//        switch UIDevice.current.userInterfaceIdiom {
//            case .phone:
//                alertWidthConstraint.constant = 280.0
//            case .pad:
//                alertWidthConstraint.constant = 340.0
//            case .unspecified: break
//            case .tv: break
//            case .carPlay: break
//        case .mac:
//            break
//        @unknown default:
//            break
//        }
    }
    
    /// Create and Configure Alert Controller
    private func configure(title:String,message:String, btnCancelTitle:String?, btnOtherTitle:String? )
    {
        self.strAlertTitle = title
        self.strAlertText          = message
        self.btnCancelTitle     = btnCancelTitle
        self.btnOtherTitle    = btnOtherTitle
    }
    
    private func configure1(title:String,message:String, btnOKTitle:String? )
    {
        self.strAlertTitle = title
        self.strAlertText  = message
        self.btnOKTitle    = btnOKTitle
    }
    
    
    /// Show Alert Controller
    private func show()
    {
       
        if let appDelegate = UIApplication.shared.delegate, let window = appDelegate.window, let rootViewController = window?.rootViewController {

            var topViewController = rootViewController
            while topViewController.presentedViewController != nil {
                topViewController = topViewController.presentedViewController!
            }

            self.modalPresentationStyle = .overCurrentContext
            topViewController.present(self, animated: isBottom) {}

        }
            
            
            
//            topViewController.addChild(self)
//            topViewController.view.addSubview(view)
//            viewWillAppear(true)
//            didMove(toParent: topViewController)
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            view.alpha = 0.0
//            view.frame = topViewController.view.bounds
//            viewAlert.alpha     = 0.0
//            viewAlert.layer.cornerRadius = 8.0
//            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
//                self.view.alpha = 1.0
//            }, completion: nil)
//
//            viewAlert.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//            viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0)-10)
//            UIView.animate(withDuration: 0.2 , delay: 0.1, options: .curveEaseOut, animations: { () -> Void in
//                self.viewAlert.alpha = 1.0
//                self.viewAlert.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                self.viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0))
//            }, completion: nil)
//        }
        
    }
    
    /// Hide Alert Controller
    private func hide()
    {
        self.dismiss(animated: isBottom, completion: nil)
        
//        self.view.endEditing(true)
//        self.viewAlert.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
//            self.viewAlert.alpha = 0.0
//            self.viewAlert.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
//            self.viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0)-5)
//        }, completion: nil)
//
//        UIView.animate(withDuration: 0.25, delay: 0.05, options: .curveEaseIn, animations: { () -> Void in
//            self.view.alpha = 0.0
//
//        }) { (completed) -> Void in
//
//            self.view.removeFromSuperview()
//            self.removeFromParent()
//        }
    }
    
    // MARK:- UIButton Clicks
    
    @IBAction func btnCloseTapped(_ sender: AnyObject){
        hide()
    }
    
    @IBAction func btnCancelTapped(_ sender: AnyObject){
        hide()
        block!!(0,btnCancelTitle!)

    }
    
    @IBAction func btnOtherTapped(_ sender: AnyObject){
        hide()
        block!!(1,btnOtherTitle!)

    }
    
    @IBAction func btnOkTapped(_ sender: UIButton)
    {
        hide()
        block!!(0,btnOKTitle!)

    }
    
    /// Hide Alert Controller on background tap
    @objc func backgroundViewTapped(sender:AnyObject)
    {
      //  hide()
    }

    // MARK:- AJAlert Functions
    // MARK:-

    /**
     Display an Alert
     
     - parameter aStrMessage:    Message to display in Alert
     - parameter aCancelBtnTitle: Cancel button title
     - parameter aOtherBtnTitle: Other button title
     - parameter otherButtonArr: Array of other button title
     - parameter completion:     Completion block. Other Button Index - 1 and Cancel Button Index - 0
     */
    
    public func showAlert(isBottomShow:Bool,aStrTitle:String, aStrMessage:String,
                    aCancelBtnTitle:String?,
                    aOtherBtnTitle:String? ,
                    completion : alertCompletionBlock){
        configure( title: aStrTitle, message: aStrMessage, btnCancelTitle: aCancelBtnTitle, btnOtherTitle: aOtherBtnTitle)
        isOkonly = false
        isBottom = isBottomShow
        block = completion
        show()

    }
    
    /**
     Display an Alert With "OK" Button
     
     - parameter aStrMessage: Message to display in Alert
     - parameter completion:  Completion block. OK Button Index - 0
     */
    
    public func showAlertWithOkButton(isBottomShow:Bool, aStrTitle:String,aStrMessage:String , aOKBtnTitle:String?,                                completion : alertCompletionBlock){
        configure1(title: aStrTitle, message: aStrMessage, btnOKTitle:aOKBtnTitle)
        isOkonly = true
        isBottom = isBottomShow
        block = completion
        show()

    }
 }

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
