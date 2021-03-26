//
//  UserModel.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/21.
//

import UIKit
import MapKit

enum ImageType {
    case large, medium, thumbnail
}

struct UserModel {
    var user: User

    var titleName: String {
        return self.user.name.title + " " + self.user.name.first + " " + self.user.name.last
    }
    var age: Int {
        return self.user.dob.age
    }
    var name: String {
        return self.user.name.first + " " + self.user.name.last
    }
    var gender: String {
        return self.user.gender
    }
    var genderImage: UIImage {
        return self.user.gender.getGenderImage.as(UIImage())
    }
    var email: String {
        return self.user.email
    }
    var phone: String {
        return self.user.cell
    }
    var location: String {
        return self.user.location.country + ", " + self.user.location.state + ", " + self.user.location.city
    }
    var fullAddres: String {
        var stringArray = [self.user.location.country,
                       self.user.location.state,
                       self.user.location.city,
                       self.user.location.street.name]
        if let number = self.user.location.street.number {
            stringArray.append("\(number)")
        }
        let string = stringArray.map { "\($0!)" }.joined(separator: ", ")
        
        return string
    }
    var latitude: CLLocationDegrees? {
        return CLLocationDegrees(self.user.location.coordinates.latitude)
    }
    var longitude: CLLocationDegrees? {
        return CLLocationDegrees(self.user.location.coordinates.longitude)
    }
    
    var isSaved: Bool {
        let realmModels = AppSettings().realm.objects(RealmUserModel.self)
        guard !realmModels.isEmpty else { return false }
        var saved = false
        
        realmModels.forEach { (userModel) in
            if userModel.email == self.user.email {
                saved = true
                return
            }
        }
        
        return saved
    }

    
    init(user: User) {
        self.user = user
    }
    
    
    func getImageURL(with imageType: ImageType) -> URL? {
        switch imageType {
        case .large: return URL(string: user.picture.large)
        case .medium: return URL(string: user.picture.medium)
        case .thumbnail: return URL(string: user.picture.thumbnail)
        }
    }
}


// MARK: - String+GetGenderImage -

fileprivate extension String {
    var getGenderImage: UIImage? {
        switch self.lowercased() {
        case "female": return #imageLiteral(resourceName: "FemaleImage")
        case "male": return #imageLiteral(resourceName: "MaleImage")
        default: return nil
        }
    }
}
