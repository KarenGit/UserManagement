//
//  Timezone.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/20.
//

struct Timezone: Codable {
    let offset: String!
    let description: String!
    
    private enum CodingKeys: String, CodingKey {
        case offset, description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.offset = try? container.decode(String.self, forKey: .offset)
        self.description = try? container.decode(String.self, forKey: .description)
    }
}
