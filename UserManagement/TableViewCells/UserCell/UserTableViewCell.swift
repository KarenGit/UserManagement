//
//  UserTableViewCell.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/20.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    @IBOutlet private weak var userPictureImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userGenderImageView: UIImageView!
    @IBOutlet private weak var userEmailAddressLabel: UILabel!
    @IBOutlet private weak var userPhoneNumberLabel: UILabel!
    @IBOutlet private weak var userLocationLabel: UILabel!
    @IBOutlet private weak var saveOrRemoveUserButton: UIButton!
    var didTapSaveOrRemoveUserButton: ((User, Bool) -> Void)? = nil
    var reloadRowClosure: ((Int) -> ())? = nil
    var deleteRowClosure: ((Int) -> ())? = nil
    var userModel: UserModel! {
        didSet {
            self.userPictureImageView.kf.setImage(with: self.userModel.getImageURL(with: .thumbnail))
            self.userNameLabel.text = self.userModel.name
            self.userGenderImageView.image = self.userModel.genderImage
            self.userEmailAddressLabel.text = self.userModel.email
            self.userPhoneNumberLabel.text = self.userModel.phone
            self.userLocationLabel.text = self.userModel.location
            
            self.saveOrRemoveUserButton.isSelected = self.userModel.isSaved
            // TODO: - need reload cells -
            self.userPictureImageView.borderColor = AppSettings.shared.appInfo.mainColor.getMainColor
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.saveOrRemoveUserButton.setImage(#imageLiteral(resourceName: "FilledOrangeHeartImage"), for: .selected)
        self.saveOrRemoveUserButton.setImage(#imageLiteral(resourceName: "OrangeHeartImage"), for: .normal)
    }
    
    
    // MARK: - IBAction Methods -
    
    @IBAction private func saveOrRemoveUserButtonAction(_ sender: UIButton) {
        sender.isSelected = (!sender.isSelected ? true : false)
        self.didTapSaveOrRemoveUserButton?(self.userModel.user, sender.isSelected)
        self.deleteRowClosure?(self.tag)
    }
}

