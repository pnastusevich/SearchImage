//
//  SelectUserListViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 3.09.24.
//

import UIKit

final class SelectUserListViewController: UITableViewController {
    
    private var userList: [User] = []
    private let storageManager = StorageManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private func fetchData() {
        storageManager.fetchData { [unowned self] result in
            switch result {
            case .success(let userList):
                self.userList = userList
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectUserCell", for: indexPath)
        
        let registeredUser = userList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = registeredUser.name
        content.secondaryText = registeredUser.mail
        cell.contentConfiguration = content

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let loginPageVC = segue.destination as? LoginPageViewController else { return }
            loginPageVC.user = userList[indexPath.row]
        }
    }

}
