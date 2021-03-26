//
//  Dob.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/20.
//

struct Dob: Codable {
    let date: String!
    let age: Int!
    
    private enum CodingKeys: String, CodingKey {
        case date, age
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try? container.decode(String.self, forKey: .date)
        self.age = try? container.decode(Int.self, forKey: .age)
    }
}
