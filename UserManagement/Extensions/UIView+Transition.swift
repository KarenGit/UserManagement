//
//  UIView+Transition.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/23.
//

import UIKit

extension UIView {
    func transit(_ animations: (() -> Void)?,
                 _ duration: TimeInterval = 0.5,
                 _ options: UIView.AnimationOptions = [.transitionCrossDissolve],
                 _ completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: self,
                          duration: duration,
                          options: [.transitionCrossDissolve],
                          animations: animations,
                          completion: completion)
    }
}
