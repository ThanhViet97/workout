//
//  ReusableView.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import UIKit

internal protocol ReusableView: AnyObject { }

internal extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

internal protocol NibLoadableView: AnyObject { }

internal extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        // notice the new describing here
        // now only one place to refactor if describing is removed in the future
        return String(describing: self)
    }
    
}

extension UITableViewCell: NibLoadableView { }
extension UITableViewCell: ReusableView { }
extension UITableViewHeaderFooterView: NibLoadableView { }
extension UITableViewHeaderFooterView: ReusableView { }

internal extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerHeaderFooterNib<T: UITableViewHeaderFooterView>(_: T.Type) {
        
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue view with identifier: \(T.reuseIdentifier)")
        }
        return view
    }
    
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
          fatalError(
            "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
              + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
              + "and that you registered the cell beforehand"
          )
        }
        return cell
    }
}
