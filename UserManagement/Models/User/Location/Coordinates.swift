//
//  Coordinates.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/20.
//

struct Coordinates: Codable {
    let latitude: String!
    let longitude: String!
    
    private enum CodingKeys: String, CodingKey {
        case latitude, longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try? container.decode(String.self, forKey: .latitude)
        self.longitude = try? container.decode(String.self, forKey: .longitude)
    }
}
