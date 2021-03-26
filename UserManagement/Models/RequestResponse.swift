//
//  RequestResponse.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/20.
//

struct RequestResponse: Codable {
    let users: [User]!
    
    private enum CodingKeys: String, CodingKey {
        case users = "results"
    }
}
