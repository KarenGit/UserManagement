//
//  UserListViewModel.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/21.
//

import Foundation

class UserListViewModel {
    private let parser = Parser()
    private var realm = AppSettings().realm
    private var isLoadingStarted = true
    private var isSavedUserModels = true
    private var pageSize: Int
    private var lastPageIndex: Int
    private var localUserModels: [UserModel] = []
    private var savedUserModels: [UserModel] = []
    private var searchedUserModels: [UserModel] = []
    var userModels: [UserModel] = [UserModel]() {
        didSet {
            self.reloadTableViewClosure()
        }
    }
    
    
    // MARK: - Closures -
    
    private var reloadTableViewClosure: () -> ()
//    var showAlertClosure: (()->())?
//    var updateLoadingStatusClosure: (()->())?

    
//    var isLoading: Bool = false {
//        didSet {
//            self.updateLoadingStatusClosure?()
//        }
//    }
    
    init(_ pageSize: Int, _ page: Int, isSavedUsers: Bool, reloadTableViewClosure: @escaping () -> ()) {
        self.pageSize = pageSize
        self.lastPageIndex = page
        self.isSavedUserModels = isSavedUsers
        self.reloadTableViewClosure = reloadTableViewClosure
    }
    
    
    // MARK: - Search -
    
    func search(searchQuery: String) {
        let searchTextCount = searchQuery.count
        let searchTextLowercased = searchQuery.lowercased()
        let users = (self.isSavedUserModels ? self.savedUserModels : self.localUserModels)
        self.searchedUserModels = users.filter({ $0.name.lowercased().prefix(searchTextCount) == searchTextLowercased ||
                                                $0.email.lowercased().prefix(searchTextCount) == searchTextLowercased ||
                                                $0.phone.lowercased().prefix(searchTextCount) == searchTextLowercased ||
                                                $0.location.lowercased().prefix(searchTextCount) == searchTextLowercased })
        self.userModels = (searchQuery.isEmpty ? (self.isSavedUserModels ? self.savedUserModels : self.localUserModels) : self.searchedUserModels)
    }
    
    
    // MARK: - Fetching functions -
    
    func fetchData() {
        if isLoadingStarted {
            self.isLoadingStarted = false
            self.parser.parse(pageSize: self.pageSize, page: self.lastPageIndex) { users in
                users.forEach { self.localUserModels.append(UserModel(user: $0)) }
                self.userModels = self.localUserModels
                self.lastPageIndex += 1
                self.isLoadingStarted = true
            }
        }
    }
    
    func seveUserAction(_ user: User) {
        let userModel = RealmManager.addUserModel(user)
        self.realm.beginWrite()
        self.realm.add(userModel)
        try! self.realm.commitWrite()
    }
    
    func deleteUserModel(_ user: User) {
        DispatchQueue.main.async {
            autoreleasepool {
                let model = self.realm.objects(RealmUserModel.self).filter({ (userModel) -> Bool in
                    user.email == userModel.email
                })
                if !model.isEmpty {
                    try! self.realm.write {
                        self.realm.delete(model)
                    }
                }
            }
        }
    }
    
    func fetchSavedUsersData() {
        let data = AppSettings().realm.objects(RealmUserModel.self)
        let jsonData = try! JSONEncoder().encode(data)
        guard let users = try? JSONDecoder().decode([User].self, from: jsonData) else { return }
        
        self.savedUserModels.removeAll()
        for user in users {
            self.savedUserModels.append(UserModel(user: user))
        }
        
        self.userModels = (self.isSavedUserModels ? self.savedUserModels : self.localUserModels)
    }
    
    
    // MARK: - Retrieve Data -
    
    func getData(at indexPath: IndexPath ) -> UserModel {
        return userModels[indexPath.row]
    }
}
