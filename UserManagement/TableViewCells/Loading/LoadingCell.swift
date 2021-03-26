//
//  LoadingCell.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/20.
//

import UIKit

class LoadingCell: UITableViewCell {
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
