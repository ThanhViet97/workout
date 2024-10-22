//
//  NSObject+Extension.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation

extension NSObject {

    @objc var className: String {
        return String(describing: type(of: self))
    }

    @objc class var className: String {
        return String(describing: self)
    }
}
