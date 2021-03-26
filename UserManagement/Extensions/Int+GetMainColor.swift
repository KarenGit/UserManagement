//
//  Int+GetMainColor.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/25.
//

import UIKit

extension Int {
    var getMainColor: UIColor? {
        switch self {
        case 0: return UIColor.systemYellow
        case 1: return UIColor.blue
        case 2: return UIColor.cyan
        default: return nil
        }
    }
}
