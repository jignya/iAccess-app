//
//  BottomServiceList.swift
//

import Foundation
import UIKit

open class BottomServiceView: UIView {
    public typealias ButtonCallback = ((Int) -> Void)?


    // MARK: - Constants
    private let kDefaultButtonHeight: CGFloat = 50
    private let kDefaultButtonSpacerHeight: CGFloat = 1
    private let kCornerRadius: CGFloat = 25
    private let kDoneButtonTag: Int = 1

    // MARK: - Views
    private var dialogView: UIView!
    private var titleLabel: UILabel!
    private var doneButton: UIButton!

    // MARK: - Variables
    private var callback : ButtonCallback?


    private var textColor: UIColor!
    private var buttonColor: UIColor!
    private var font: UIFont!

    private var container: UIView?
    private lazy var gradient = CAGradientLayer(layer: self.layer)

    // MARK: - Dialog initialization
    @objc public init(
        textColor: UIColor? = nil,
        buttonColor: UIColor? = nil,
        font: UIFont = .boldSystemFont(ofSize: 15)) {
        let size = UIScreen.main.bounds.size
        super.init(frame: CGRect(x: 0, y: size.height - 170 , width: size.width, height: 120))
        self.textColor = UIColor.black
        self.buttonColor = UIColor.white
        self.font = UIFont.roboto(size: 15, weight: .Regular)!
        setupView()
    }

    @available(*, unavailable)
    @objc required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView() {
        dialogView = createContainerView()

        dialogView?.layer.shouldRasterize = true
        dialogView?.layer.rasterizationScale = UIScreen.main.scale

        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale

        dialogView?.layer.opacity = 0.5
        dialogView?.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)

        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

        if let dialogView = dialogView {
            addSubview(dialogView)
        }
    }

    /// Create the dialog view, and animate opening the dialog
    open func show(
        _ title: String,
        ButtonTitle: String = "SERVICE LIST",
        callback: ButtonCallback) {
        self.titleLabel.text = title
        self.doneButton.setTitle(ButtonTitle, for: .normal)
        self.callback = callback

        /* Add dialog to main window */
        guard let appDelegate = UIApplication.shared.delegate else { fatalError() }
        guard let window = appDelegate.window else { fatalError() }
        window?.addSubview(self)
        window?.bringSubviewToFront(self)
        window?.endEditing(true)
        
//        let controller = UIApplication.topViewController()
//        controller?.view.addSubview(self)
//        controller?.view.bringSubviewToFront(self)
        
        self.backgroundColor = UIColor.white
        self.dialogView?.layer.opacity = 1
        self.dialogView?.layer.transform = CATransform3DMakeScale(1, 1, 1)

       
        /* Anim */
//        UIView.animate(
//            withDuration: 0.2,
//            delay: 0,
//            options: .transitionFlipFromBottom,
//            animations: {
//                self.backgroundColor = UIColor.white
//                self.dialogView?.layer.opacity = 1
//                self.dialogView?.layer.transform = CATransform3DMakeScale(1, 1, 1)
//            }
//        )
    }

    /// Dialog close animation then cleaning and removing the view from the parent
    func close() {
        let currentTransform = self.dialogView.layer.transform

        let startRotation = (self.value(forKeyPath: "layer.transform.rotation.z") as? NSNumber) as? Double ?? 0.0
        let rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + .pi * 270 / 180), 0, 0, 0)

        self.dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1))
        self.dialogView.layer.opacity = 1
        
        for v in self.subviews {
            v.removeFromSuperview()
        }

        self.removeFromSuperview()
        self.setupView()

//        UIView.animate(
//            withDuration: 0.2,
//            delay: 0,
//            options: [],
//            animations: {
//                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
//                let transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
//                self.dialogView.layer.transform = transform
//                self.dialogView.layer.opacity = 0
//            }
//        ) { _ in
//            for v in self.subviews {
//                v.removeFromSuperview()
//            }
//
//            self.removeFromSuperview()
//            self.setupView()
//        }
    }

    /// Creates the container view here: create the dialog, then add the custom content and buttons
    private func createContainerView() -> UIView {
        let screenSize = UIScreen.main.bounds.size
        
        var bottomPadding : CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            bottomPadding = (window?.safeAreaInsets.bottom)!
        }

        // For the black background
        self.frame = CGRect(x: 0, y: screenSize.height - 170 - bottomPadding, width: screenSize.width, height: 120)

        // This is the dialog's container; we attach the custom content and the buttons to this one
        let container = UIView()
        self.container = container

        container.frame = self.bounds
        
        container.backgroundColor = UIColor.white
        // First, we style the dialog to match the iOS8 UIAlertView >>>
        gradient.frame = container.bounds

//        let cornerRadius = kCornerRadius
//        gradient.cornerRadius = cornerRadius
//        container.layer.insertSublayer(gradient, at: 0)
////        container.layer.cornerRadius = cornerRadius
////        container.layer.borderWidth = 1
//        container.layer.shadowRadius = 3
//        container.layer.shadowOpacity = 0.1
//        container.layer.shadowOffset = CGSize(width: 0 - (cornerRadius + 5) / 2, height: 0 - (cornerRadius + 5) / 2)
//        container.layer.shadowColor = UIColor.black.cgColor
//        container.layer.shadowPath = UIBezierPath(
//            roundedRect: container.bounds,
//            cornerRadius: container.layer.cornerRadius
//        ).cgPath
        
        
        let shadowSize : CGFloat = 10.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.frame.size.width + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.layer.shadowPath = shadowPath.cgPath

        // There is a line above the button
//        let yPosition = container.bounds.size.height - kDefaultButtonHeight - kDefaultButtonSpacerHeight
//        let lineView = UIView(frame: CGRect(
//            x: 0,
//            y: yPosition,
//            width: container.bounds.size.width,
//            height: kDefaultButtonSpacerHeight
//        ))
//        container.addSubview(lineView)

        //Title
        self.titleLabel = UILabel(frame: CGRect(x: -10, y: (self.frame.size.height - 30)/2, width: 200, height: 30))
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = self.textColor
        self.titleLabel.font = self.font.withSize(18)
        container.addSubview(self.titleLabel)

        // Add the buttons
        addButtonsToView(container: container)

        return container
    }

    /// Add buttons to container
    private func addButtonsToView(container: UIView) {
        let buttonWidth = container.bounds.size.width / 2 - 50

        let leftButtonFrame = CGRect(
            x: 20,
            y: (container.bounds.size.height - kDefaultButtonHeight)/2,
            width: buttonWidth,
            height: kDefaultButtonHeight
        )
        let rightButtonFrame = CGRect(
            x: self.frame.size.width - buttonWidth - 30,
            y: (container.bounds.size.height - kDefaultButtonHeight)/2,
            width: buttonWidth,
            height: kDefaultButtonHeight
        )
      
        let interfaceLayoutDirection = UIApplication.shared.userInterfaceLayoutDirection
        let isLeftToRightDirection = interfaceLayoutDirection == .leftToRight

        self.doneButton = UIButton(type: .system)
        self.doneButton.frame = isLeftToRightDirection ? rightButtonFrame : leftButtonFrame
        self.doneButton.tag = kDoneButtonTag
        self.doneButton.setTitleColor(self.buttonColor, for: .normal)
        self.doneButton.setTitleColor(self.buttonColor, for: .highlighted)
        self.doneButton.titleLabel?.font = self.font.withSize(16)
        self.doneButton.layer.cornerRadius = kCornerRadius
        self.doneButton.backgroundColor = UserSettings.shared.themeColor()
        self.doneButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        let imageview = UIImageView(frame: CGRect(x: self.doneButton.frame.origin.x + buttonWidth - 20, y: self.doneButton.frame.origin.y + 20, width: 10, height: 10))
        imageview.image = UIImage(named: "Arrow")
        imageview.tintColor = UIColor.white
        imageview.contentMode = .scaleAspectFit
        
        container.addSubview(self.doneButton)
        container.addSubview(imageview)

    }

    @objc func buttonTapped(sender: UIButton) {
        
        callback!!(0)
        close()
    }
    
}
