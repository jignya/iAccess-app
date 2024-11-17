//
//  DataManager.swift
//  Omahat
//
//  Created by Imran Mohammed on 3/5/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private func documentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        return documentDirectory as NSString
    }
    
    func saveAnyObject(_ anyObj: Any, path: Path) {
        let file = documentsDirectory().appendingPathComponent(path.rawValue)
        NSKeyedArchiver.archiveRootObject(anyObj, toFile: file)
    }
    
    func loadObj<T>(_ path: Path) -> T? {
        let file = documentsDirectory().appendingPathComponent(path.rawValue)
        return NSKeyedUnarchiver.unarchiveObject(withFile: file) as? T
    }
    
    @discardableResult func removeObject(_ path: Path) -> Bool {
        let file = documentsDirectory().appendingPathComponent(path.rawValue)
        do {
            try FileManager.default.removeItem(atPath: file)
            return true
        } catch {
            return false
        }
    }
    
//    func isValidEmail(testStr:String) -> Bool
//    {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: testStr)
//    }
    
}

public enum Path: String {
    case supportedCountries = "supportedCountries"
    case supportedCurrencies = "supportedCurrencies"
    case exchangeRates = "exchangeRates"
}

