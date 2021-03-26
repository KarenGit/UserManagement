//
//  UIViewController+ShowFullScreenImage.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/23.
//

import UIKit

extension UIViewController {
    
    func showFullScreenImageIfNeeded(_ imageURL: URL?) {
        guard let url = imageURL else { return }
        
        let fullScreenImageView = FullScreenImageView(frame: UIScreen.main.bounds)
        fullScreenImageView.setImage(url)
        fullScreenImageView.didDismiss = { [weak self] in
            self?.view.transit({
                fullScreenImageView.removeFromSuperview()
            })
        }
        
        self.view.transit({ [weak self] in
            self?.view.addSubview(fullScreenImageView)
        })
    }
}
