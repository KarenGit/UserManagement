//
//  Street.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/20.
//

struct Street: Codable {
    let number: Int!
    let name: String!
    
    private enum CodingKeys: String, CodingKey {
        case number, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.number = try? container.decode(Int.self, forKey: .number)
        self.name = try? container.decode(String.self, forKey: .name)
    }
}
