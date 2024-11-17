//
//  uiview+extensions.swift
//  Copyright © 2018 ImSh. All rights reserved.


import Foundation
import UIKit

extension UIFont {
    
    /*
     Font: Montserrat-Medium
     Font: Montserrat-Bold
     */
    
    enum ImShCustomFontWeight: String {
        case Light,Regular, Medium, Bold
    }
    
    static func roboto(size: CGFloat, weight: ImShCustomFontWeight = .Regular) -> UIFont? {
        return UIFont(name: "Montserrat-\(weight.rawValue)", size: size) ?? UIFont(name: "Helvetica Neue", size: size)!
    }
}

extension UIColor {
    
    enum ServiceStatus: String {
        case completed,cancelled, outForService, servicePlaced , inspection
    }
    
    static func statusTextColor(status: ServiceStatus = .completed) -> UIColor?
    {
        switch status {
        case .completed:
            return UIColor(red: 92.0/255.0, green: 194.0/255.0, blue: 119.0/255.0, alpha: 1)
        case .cancelled:
            return UIColor(red: 235.0/255.0, green: 84.0/255.0, blue: 65.0/255.0, alpha: 1)
        case .outForService:
            return UIColor(red: 49.0/255.0, green: 184.0/255.0, blue: 183.0/255.0, alpha: 1)
        case .servicePlaced:
            return UIColor(red: 201.0/255.0, green: 207.0/255.0, blue: 84.0/255.0, alpha: 1)
        case .inspection:
            return UIColor(red: 225.0/255.0, green: 104.0/255.0, blue: 66.0/255.0, alpha: 1)
        }
    }
    static func statusBackgroundColor(status: ServiceStatus = .completed) -> UIColor?
    {
        switch status {
        case .completed:
            return UIColor(red: 228.0/255.0, green: 255.0/255.0, blue: 235.0/255.0, alpha: 1)
        case .cancelled:
            return UIColor(red: 255.0/255.0, green: 233.0/255.0, blue: 230.0/255.0, alpha: 1)
        case .outForService:
            return UIColor(red: 212.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)
        case .servicePlaced:
            return UIColor(red: 244.0/255.0, green: 245.0/255.0, blue: 223.0/255.0, alpha: 1)
        case .inspection:
            return UIColor(red: 245.0/255.0, green: 233.0/255.0, blue: 230.0/255.0, alpha: 1)
        }
    }
}


extension UIImage {
    
    enum CustomImageType: String {
        case image_placeholder, shoppingCart, v_homeColor, v_cartColor , v_wishlist , v_product
    }
    
    static func image(type: CustomImageType) -> UIImage? {
        return UIImage.init(named: type.rawValue)
    }
    
    enum StatusImageType: String {
        case S_Cancelled, S_Completed, S_Inspection, S_Intransit , S_Placed
    }
    
    static func Serviceimage(type: StatusImageType) -> UIImage? {
        return UIImage.init(named: type.rawValue)
    }
}

@IBDesignable
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set (new) {
            self.layer.cornerRadius = new
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set (new) {
            self.layer.borderWidth = new
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.white.cgColor)
        }
        set (new) {
            self.layer.borderColor = new.cgColor
        }
    }
    
    @IBInspectable var isCircle: Bool {
        get {
            return self.layer.cornerRadius == (bounds.height / 2)
        }
        set (new) {
            self.layer.cornerRadius = new ? (bounds.height / 2) : 0
        }
    }
    
    /// For shadow
    @IBInspectable var maskToBounds: Bool {
        get {
            return self.layer.masksToBounds
        }
        set (new) {
            self.layer.masksToBounds = new
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set (new) {
            self.layer.shadowColor = new.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set (new) {
            self.layer.shadowOpacity = new
            self.updateShadow()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set (new) {
            self.layer.shadowRadius = new
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set (new) {
            self.layer.shadowOffset = new
        }
    }
    
    private func updateShadow() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
    }
}

@IBDesignable
extension UIImageView {
    
    @IBInspectable var tint: UIColor {
        get {
            return self.tintColor
        }
        set (new) {
            self.image = image?.withRenderingMode(.alwaysTemplate)
            self.tintColor = new
        }
    }
    
}

extension UICollectionReusableView {
    
    class var className: String {
        return "\(self)"
    }
    
}

extension UITableViewCell {
    
    class var className: String {
        return "\(self)"
    }
    
}

extension UITableView {
    
    public func register(delegate: UITableViewDelegate?, dataSource: UITableViewDataSource?, cellNibWithReuseId: String? = nil) {
        if let nibReuseId = cellNibWithReuseId {
            self.register(UINib.init(nibName: nibReuseId, bundle: nil), forCellReuseIdentifier: nibReuseId)
        }
        self.delegate = delegate
        self.dataSource = dataSource
    }
    
}

extension UINavigationBar {
    
    func transparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
    
}

extension String {
    
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string
        
        return decoded ?? self
    }
    
}

extension UITabBarController {
    
    open func hideTabBar(animated: Bool = true) {
        var frame = self.tabBar.frame
        let height = self.view.frame.size.height + (frame.size.height)
        frame.origin.y = height
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.tabBar.frame = frame
        })
    }
    
    open func showTabBar(animated: Bool = true) {
        var frame = self.tabBar.frame
        let height = self.view.frame.size.height - (frame.size.height)
        frame.origin.y = height
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.tabBar.frame = frame
        })
    }
}

extension Bool {
    /// String will be cached to UserDefaults with Key and Synchronized
    ///
    /// - Parameter key: String
    func cache(key: String) {
        let defaults = UserDefaults.standard
        defaults.set(self, forKey: key)
        defaults.synchronize()
    }
    
    /// Cached string for the Key will be returned optionally
    ///
    /// - Parameter key: String
    /// - Returns: String?
    static func cached(key: String) -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: key)
    }
}

extension Optional where Wrapped == Float {
    
    var explicit: Float {
        return self ?? 0.0
    }
    
}

extension UINavigationItem {
    

}

@IBDesignable
extension UILabel {
    
    @IBInspectable
    var localizedText: String {
        get { return self.text ?? "UILabel" }
        set { self.text = newValue }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.handleLocalizedText()
    }
    
    private func handleLocalizedText() {
        guard let text = self.text else { return }
        self.text = text
    }
    
}


@IBDesignable
extension UIButton {
    
    @IBInspectable
    var localizedText: String {
        get { return self.titleLabel?.text ?? "UIButton" }
        set { self.setTitle(newValue, for: .normal) }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.handleLocalizedText()
    }
    
    private func handleLocalizedText() {
        guard let text = self.titleLabel?.text else { return }
        self.setTitle(text, for: .normal)
    }

}

