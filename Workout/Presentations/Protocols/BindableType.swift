//
//  BindableType.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import UIKit

protocol BindableType: AnyObject {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    func bind(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
