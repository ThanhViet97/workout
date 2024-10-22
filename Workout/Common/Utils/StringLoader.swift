//
//  StringLoader.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

class StringLoader {

    private let stringsFilename = "Localization"
    private let stringsPluralname = "LocalizationPlural"
    private let localisedLanguage: String = "en"

    init() { }

    /// Localized string for key in the default language
    func localisedString(forKey key: String, comment: String? = nil) -> String {
        let string = localisedString(forKey: key, language: localisedLanguage)
        return string.isNotEmpty ? string : key
    }
    
    func localizedString(forKey key: String, comment: String? = nil, withArgs: [CVarArg]) -> String {
        return String(format: localisedString(forKey: key), arguments: withArgs)
    }
    
    func localisedPlural(forKey key: String, comment: String? = nil, number: Int) -> String {
        return NSString.localizedStringWithFormat((localisedString(forKey: key, language: localisedLanguage, table: stringsPluralname) ?? key) as NSString, number) as String
    }
}

private extension StringLoader {

    func localisedString(forKey key: String, language: String, comment: String? = nil) -> String {
        if let string = localisedString(forKey: key, language: language, table: stringsFilename), string != key {
            return string
        }
        // Fallback to English language.
        return localisedString(forKey: key, language: "en", table: stringsFilename) ?? key
    }

    func localisedString(forKey key: String, language: String, table: String) -> String? {
        if let path = Bundle.main.path(forResource: language, ofType: "lproj"),
            let stringBundle = Bundle(path: path) {
            let string = stringBundle.localizedString(forKey: key, value: "", table: table)
            return string
        }
        return nil
    }
}
