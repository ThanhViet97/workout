//
//  AppFont.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import UIKit

enum AppFont {
    static var bold: UIFont {
        guard let font = UIFont(name: "OpenSans-Bold", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "OpenSans-Bold" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return font
    }
    
    static var extraBold: UIFont {
        guard let font = UIFont(name: "OpenSans-ExtraBold", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "OpenSans-Bold" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return font
    }
    
    static var light: UIFont {
        guard let font = UIFont(name: "OpenSans-Light", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "OpenSans-Bold" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return font
    }
    static var medium: UIFont {
        guard let font = UIFont(name: "OpenSans-Medium", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "OpenSans-Bold" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return font
    }
    static var regular: UIFont {
        guard let font = UIFont(name: "OpenSans-Regular", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "OpenSans-Bold" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return font
    }
    static var SemiBold: UIFont {
        guard let font = UIFont(name: "OpenSans-SemiBold", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "OpenSans-Bold" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return font
    }
}
