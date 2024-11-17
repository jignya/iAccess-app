//
//  ImShStoryboards.swift
//

import Foundation
import UIKit

enum ImShStoryboards: String {
    case Login
    case Home
    case Other
    case Profile
    case Explore
    case Jobs
    
    var instance: UIStoryboard {
        return UIStoryboard.init(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type,
                                             function: String = #function,
                                             line: Int = #line,
                                             file: String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID) not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(fromImShStoryboard: ImShStoryboards) -> Self {
        return fromImShStoryboard.viewController(viewControllerClass: self)
    }
}
