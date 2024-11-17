//
//  ImShLanguage.swift
//  Omahat
//
//  Created by Imran Mohammed on 3/8/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import UIKit

open class ImShLanguage {
    
    private let IMSH_LANGUAGE_KEY = "_ImShDefaultLanguage"
    private let IMSH_INITIAL_SET_KEY = "_ImShInitialSetKey"
    private let APPLE_LANGUAGE_KEY = "AppleLanguages"
    
    public static let shared = ImShLanguage()
    
    /// get current Apple language
    public func currAppleLang() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let currentWithoutLocale = current.prefix(2)
        return String(currentWithoutLocale)
    }
    
    /// set @lang to be the first in Applelanguages list
    public func setApple(language lang: String) {
        let userDef = UserDefaults.standard
        userDef.set([lang.lowercased(), currAppleLang()], forKey: APPLE_LANGUAGE_KEY)
        userDef.synchronize()
    }
    
    public func get() -> LanguagesSupported {
        let locale = UserDefaults.standard.string(forKey: IMSH_LANGUAGE_KEY) ?? "en"
        return LanguagesSupported.init(locale: locale) ?? LanguagesSupported.english
    }
    
    public func getSupported() -> [LanguagesSupported] {
        return [LanguagesSupported.english, .arabic]
    }
    
    public func set(language: LanguagesSupported) {
        let userDef = UserDefaults.standard
        userDef.set(language.rawValue, forKey: IMSH_LANGUAGE_KEY)
        userDef.synchronize()
        
        /// Setting apple language
        setApple(language: language.rawValue)
        
        NotificationCenter.default.post(name: .ImShLanguageChangedNotification, object: nil, userInfo: nil)
    }
    
    public func isInitialSet() -> Bool {
        return UserDefaults.standard.bool(forKey: IMSH_INITIAL_SET_KEY)
    }
    
    public func setInitial() {
        let userDef = UserDefaults.standard
        userDef.set(true, forKey: IMSH_INITIAL_SET_KEY)
        userDef.synchronize()
    }
    
    /**
     Get the current language with locae e.g. ar-KW
     
     @return language identifier string
     */
    public func currLocaleID() -> String {
        let userDef = UserDefaults.standard
        let langArray = userDef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    /**
     **Check if the current language is Arabic**
     @description see if the prefix of the language is ar
     
     @return is arabic boolean
     */
    public func isArabic() -> Bool {
        return get().rawValue == "ar"
    }
    
}

extension String {
    
    var localized: String {
        let baseLanguage = ImShLanguage.shared.get().rawValue
        guard let path = Bundle.main.path(forResource: baseLanguage, ofType: "lproj") else { return self }
        guard let languageBundle: Bundle = Bundle(path: path) else { return self }
        return NSLocalizedString(self, tableName: nil, bundle: languageBundle, value: "", comment: "")
    }
    
}

extension Notification.Name {
    
    static let ImShLanguageChangedNotification = Notification.Name.init("ImShLanguageChangedNotification")
    
}

/// LANGUAGES SUPPORTED
public enum LanguagesSupported: String {
    case english = "en"
    case arabic = "ar"
    
    init?(locale: String) {
        self.init(rawValue: locale)
    }
    
    func name() -> (original: String, english: String) {
        switch self {
        case .english:
            return ("English", "English")
        case .arabic:
            return ("العربية", "Arabic")
        }
    }
    
}
