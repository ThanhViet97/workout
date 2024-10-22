//
//  BaseViewController.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    
    var cancellables = Set<AnyCancellable>()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.didPullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    @objc func didPullToRefresh() { }

    deinit {
        print("DEINIT: ", String(describing: Self.self))
    }
}
