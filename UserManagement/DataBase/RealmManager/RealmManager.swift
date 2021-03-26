//
//  RealmManager.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/24.
//

import RealmSwift

struct RealmManager {
    static func addUserModel(_ user: User) -> RealmUserModel {
        let nameModel = NameModel()
        nameModel.title = user.name.title
        nameModel.first = user.name.first
        nameModel.last = user.name.last
        
            let streetModel = StreetModel()
            streetModel.number = user.location.street.number
            streetModel.name = user.location.street.name
        
            let coordinatesModel = CoordinatesModel()
            coordinatesModel.latitude = user.location.coordinates.latitude
            coordinatesModel.longitude = user.location.coordinates.longitude
        
            let timezoneModel = TimezoneModel()
            timezoneModel.offset = user.location.timezone.offset
            timezoneModel.descriptionTimezone = user.location.timezone.description

        let locationModel = LocationModel()
        locationModel.street = streetModel
        locationModel.city = user.location.city
        locationModel.state = user.location.state
        locationModel.country = user.location.country
        locationModel.postcode = user.location.postcode
        locationModel.coordinates = coordinatesModel
        locationModel.timezone = timezoneModel
        
        let loginModel = LoginModel()
        loginModel.uuid = user.login.uuid
        loginModel.username = user.login.username
        loginModel.password = user.login.password
        loginModel.salt = user.login.salt
        loginModel.md5 = user.login.md5
        loginModel.sha1 = user.login.sha1
        loginModel.sha256 = user.login.sha256
        
        let dobModel = DobModel()
        dobModel.date = user.dob.date
        dobModel.age = user.dob.age
        
        let registeredModel = DobModel()
        registeredModel.date = user.registered.date
        registeredModel.age = user.registered.age
        
        let idModel = IDModel()
        idModel.name = user.id.name
        idModel.value = user.id.value

        let pictureModel = PictureModel()
        pictureModel.large = user.picture.large
        pictureModel.medium = user.picture.medium
        pictureModel.thumbnail = user.picture.thumbnail
        
        let realmUserModel = RealmUserModel()
        realmUserModel.gender = user.gender
        realmUserModel.name = nameModel
        realmUserModel.location = locationModel
        realmUserModel.email = user.email
        realmUserModel.login = loginModel
        realmUserModel.dob = dobModel
        realmUserModel.registered = registeredModel
        realmUserModel.phone = user.phone
        realmUserModel.cell = user.cell
        realmUserModel.id = idModel
        realmUserModel.picture = pictureModel
        realmUserModel.nat = user.nat
        realmUserModel.isSaved = true
        
        return realmUserModel
    }
}
