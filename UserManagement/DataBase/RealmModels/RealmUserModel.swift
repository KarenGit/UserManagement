//
//  RealmUserModel.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/20.
//

import Foundation
import RealmSwift


class RealmUserModel: Object, Codable {
    @objc dynamic var gender: String?
    @objc dynamic var name: NameModel?
    @objc dynamic var location: LocationModel?
    @objc dynamic var email: String?
    @objc dynamic var login: LoginModel?
    @objc dynamic var dob: DobModel?
    @objc dynamic var registered: DobModel?
    @objc dynamic var phone: String?
    @objc dynamic var cell: String?
    @objc dynamic var id: IDModel?
    @objc dynamic var picture: PictureModel?
    @objc dynamic var nat: String?
    @objc dynamic var isSaved: Bool = false
}

class NameModel: Object, Codable {
    @objc dynamic var title: String?
    @objc dynamic var first: String?
    @objc dynamic var last: String?
}

class LocationModel: Object, Codable {
    @objc dynamic var street: StreetModel?
    @objc dynamic var city: String?
    @objc dynamic var state: String?
    @objc dynamic var country: String?
    @objc dynamic var postcode: String?
    @objc dynamic var coordinates: CoordinatesModel?
    @objc dynamic var timezone: TimezoneModel?
}
    class StreetModel: Object, Codable {
        @objc dynamic var number: Int = 0
        @objc dynamic var name: String?
    }
    class CoordinatesModel: Object, Codable {
        @objc dynamic var latitude: String?
        @objc dynamic var longitude: String?
    }
    class TimezoneModel: Object, Codable {
        @objc dynamic var offset: String?
        @objc dynamic var descriptionTimezone: String?
    }

class LoginModel: Object, Codable {
    @objc dynamic var uuid: String?
    @objc dynamic var username: String?
    @objc dynamic var password: String?
    @objc dynamic var salt: String?
    @objc dynamic var md5: String?
    @objc dynamic var sha1: String?
    @objc dynamic var sha256: String?
}

class DobModel: Object, Codable {
    @objc dynamic var date: String?
    @objc dynamic var age: Int = 0
}

class IDModel: Object, Codable {
    @objc dynamic var name: String?
    @objc dynamic var value: String?
}

class PictureModel: Object, Codable {
    @objc dynamic var large: String?
    @objc dynamic var medium: String?
    @objc dynamic var thumbnail: String?
}

//class Devices: Object, Decodable {
//    @objc dynamic var addedOn: Double = 0.0
//    @objc dynamic var category: String? = nil
//    @objc dynamic var deviceId = ""
//    @objc dynamic var deviceName: String? = nil
//    @objc dynamic var deviceType : String? = nil
//    @objc dynamic var firmware: String? = nil
//    @objc dynamic var isActive: Bool = true
//    @objc dynamic var lastUpdate: Double = 0.0
//    @objc dynamic var uuDeviceId = ""
//    @objc dynamic var model: String? = nil
//    @objc dynamic var typeId = 0
//    @objc dynamic var userId = 0
//
//    enum CodingKeys: String, CodingKey {
//        case addedOn = "added_on"
//        case category = "category"
//        case deviceId = "device_id"
//        case deviceName = "device_name"
//        case deviceType = "device_type"
//        case firmware = "firmware"
//        case isActive = "is_active"
//        case lastUpdate = "last_update"
//        case uuDeviceId = "uu_device_id"
//        case model = "model"
//        case typeId = "type_id"
//        case userId = "user_id"
//    }
//    override public static func primaryKey() -> String? {
//        return "uuDeviceId"
//    }
//}
