//
//  UIViewController+Alert.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import UIKit

protocol AlertDisplayer { }

extension AlertDisplayer where Self: UIViewController {
    
    func showErrorMessage(message: String, buttonTitle: String? = nil, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: Strings.Common.error, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle ?? Strings.Common.done, style: .default, handler: { _ in
            completion?()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
