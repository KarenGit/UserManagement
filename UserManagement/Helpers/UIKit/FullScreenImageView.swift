//
//  FullScreenImageView.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/20.
//

import Foundation
import UIKit
import Kingfisher

class FullScreenImageView: UIView {
    private let imageView = UIImageView()
    var didDismiss: (() -> Void)? = nil
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    
    // MARK: - Private Methods -
    
    private func commonInit() {
        self.backgroundColor = .black
        self.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismiss(gesture:)))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        self.imageView.frame = CGRect(origin: .zero, size: CGSize(width: self.frame.width, height: self.frame.width))
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.center = self.center
        self.imageView.layer.masksToBounds = false
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = self.frame.width/2
        self.addSubview(self.imageView)
    }
    
    @objc private func dismiss(gesture: UITapGestureRecognizer) {
        self.didDismiss?()
    }
    
    
    // MARK: - Methods -
    
    func setImage(_ imageURL: URL) {
        self.imageView.kf.setImage(with: imageURL)
    }
}
