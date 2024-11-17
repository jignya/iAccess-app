//
//  ImSh_String.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 10/20/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import UIKit

extension String {
    
    /// To check if string is a number
    public var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: NSCharacterSet.decimalDigits.inverted) == nil
        }
    }

    /// To convert string to Double
    public var getDouble: Double {
        return Double(self) ?? 0.0
    }

    /// To convert string to Float
    public var getFloat: Float {
        return Float(self) ?? 0.0
    }

    /// To get UIImage? with string as name
    public var getImage: UIImage? {
        return UIImage(named: self)
    }

    /// To convert string to URL?
    public var getURL: URL? {
        return URL(string: self.encodeUrl())
    }
    
    /// To get first character of string
    public var first: String {
        return String(prefix(1))
    }
    
    /// To get last character of string
    public var last: String {
        return String(suffix(1))
    }
    
    /// To convert string with first character uppercased
    public var uppercaseFirst: String {
        return first.uppercased() + String(dropFirst())
    }
    
    public func encodeUrl() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    public func decodeUrl() -> String {
        return self.removingPercentEncoding!
    }
    
    /// To check if string is a valid email
    public var isValidEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", options: .caseInsensitive)
            
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    /// To get height with predefined width
    ///
    /// - Parameters:
    ///   - width: CGFloat
    ///   - font: UIFont
    /// - Returns: CGFloat
    public func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    /// To get width with predefined height
    ///
    /// - Parameters:
    ///   - height: CGFloat
    ///   - font: UIFont
    /// - Returns: CGFloat
    public func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
    
    /// To remove extra white spaces and new lines
    ///
    /// - Returns: String
    public func collapseWhitespace() -> String {
        let comp = components(separatedBy: CharacterSet.whitespacesAndNewlines).filter { !$0.isEmpty }
        return comp.joined(separator: " ")
    }
    
    /// Clean string with predicate
    ///
    /// - Parameters:
    ///   - with: String
    ///   - allOf: String...
    /// - Returns: String
    public func clean(with: String, allOf: String...) -> String {
        var string = self
        for target in allOf {
            string = string.replacingOccurrences(of: target, with: with)
        }
        return string
    }
    
    private static let allowedCharacters = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-")
    /// To slugify the string
    ///
    /// - Returns: String
    public func slugify() -> String {
        let cocoaString = NSMutableString(string: self) as CFMutableString
        CFStringTransform(cocoaString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(cocoaString, nil, kCFStringTransformStripCombiningMarks, false)
        CFStringLowercase(cocoaString, .none)
        
        return String(cocoaString)
            .components(separatedBy: String.allowedCharacters.inverted)
            .filter { $0 != "" }
            .joined(separator: "-")
    }
    
    /// To get a random string of length
    ///
    /// - Parameter length: Int
    /// - Returns: String
    static public func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 "
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    /// String will be cached to UserDefaults with Key and Synchronized
    ///
    /// - Parameter key: String
    public func cache(key: String) {
        let defaults = UserDefaults.standard
        defaults.set(self, forKey: key)
        defaults.synchronize()
    }
    
    /// Cached string for the Key will be returned optionally
    ///
    /// - Parameter key: String
    /// - Returns: String?
    public static func cached(key: String) -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: key)
    }
    
}

extension NSString {
    
    /// To get ranges for given pattern strings
    ///
    /// - Parameter Patterns: [String]
    /// - Returns: [NSRange]
    func ranges(of Patterns: [String]) -> [NSRange] {
        var returnRanges = [NSRange]()
        for Pattern in Patterns {
            do {
                let regex = try NSRegularExpression(pattern: Pattern, options: [])
                returnRanges += regex.matches(in: self as String, options: [], range: NSMakeRange(0, (self as String).count)).map {$0.range}
            } catch {
                // DONT DO ANYTHING - SKIP
            }
        }
        return returnRanges
    }
    
}
