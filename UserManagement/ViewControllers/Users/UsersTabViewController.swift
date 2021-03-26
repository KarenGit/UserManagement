//
//  UsersTabViewController.swift
//  UserManagement
//
//  Created by Karen Madoyan on 2021/3/20.
//

import UIKit

class UsersTabViewController: UIViewController {
    @IBOutlet private weak var userSearchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    private var loadingCellid = "loadingcellid"
    private var userCellid = "userCellid"
    private let pageSize = 50
    private var currentPage = 1
    private lazy var userListViewModel = UserListViewModel(self.pageSize, self.currentPage, isSavedUsers: self.isSaved, reloadTableViewClosure: {
        self.reloadData()
    })
    var isSaved = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCells()
        if !self.isSaved {
            self.userListViewModel.fetchData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = (self.isSaved
                                                                    ? Constants.Localization.savedUsers.localized
                                                                    : Constants.Localization.users.localized)
        self.userSearchBar.placeholder = Constants.Localization.searchPlaceholder.localized
        if self.isSaved {
            self.userListViewModel.fetchSavedUsersData()
        }
        self.reloadData()
    }
    
    
    
    // MARK: - Private Methods -
    
    private func configureCells() {
        //Register Cells
        let loadingCellNib = UINib(nibName: LoadingCell.typeName,
                                   bundle: nil)
        self.tableView.register(loadingCellNib,
                                forCellReuseIdentifier: self.loadingCellid)
        let userCellNib = UINib(nibName: UserTableViewCell.typeName,
                                bundle: nil)
        self.tableView.register(userCellNib,
                                forCellReuseIdentifier: self.userCellid)
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func deleteRow(index: Int) {
        guard self.isSaved else { return }
        
        self.userListViewModel.userModels.remove(at: index)
        let indexPath = IndexPath(item: index, section: 0)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    
    private func saveOrDeleteIfNeeded(_ saveOrDelete: Bool, _ user: User) {
        if saveOrDelete {
            self.userListViewModel.seveUserAction(user)
        } else {
            self.userListViewModel.deleteUserModel(user)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard self.userSearchBar.searchTextField.text.notNil,
              self.userSearchBar.searchTextField.text!.isEmpty,
              !self.isSaved else { return }
        
        self.userListViewModel.fetchData()
    }
}


// MARK: - UISearchBarDelegate -

extension UsersTabViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.userListViewModel.search(searchQuery: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.userSearchBar.endEditing(true)
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate -

extension UsersTabViewController: UITableViewDataSource & UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return self.userListViewModel.userModels.count
        case 1: return (self.isSaved || !self.userSearchBar.text!.isEmpty ? 0 : 1)
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let loadingCell = tableView.dequeueReusableCell(withIdentifier: self.loadingCellid, for: indexPath) as! LoadingCell
            loadingCell.loadingActivityIndicator.startAnimating()
            return loadingCell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.userCellid) as? UserTableViewCell else { return UITableViewCell() }
        
        cell.tag = indexPath.row
        cell.selectionStyle = .none
        cell.userModel = self.userListViewModel.getData(at: indexPath)
        
        cell.deleteRowClosure = self.deleteRow
        
        cell.didTapSaveOrRemoveUserButton = { [weak self] (user, saveOrDelete) in
            self?.saveOrDeleteIfNeeded(saveOrDelete, user)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (indexPath.section == 0 ? UITableView.automaticDimension : 100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetailsPageViewController = UserDetailsPageViewController()
        userDetailsPageViewController.userModel = self.userListViewModel.getData(at: indexPath)
        self.push(userDetailsPageViewController)
    }
}
