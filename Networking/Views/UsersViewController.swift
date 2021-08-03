//
//  ViewController.swift
//  Networking
//
//  Created by Anna on 8/1/21.
//

import UIKit

class UsersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var users:[UserData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.register(UINib(nibName: UsersTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: UsersTableViewCell.identifier)

        UserService.shared.getUsersPage(completition: {
            switch $0 {
            case let .success(users):
                self.users = users.data
                self.tableView.reloadData()
            case let .failure(error):
                print(error.errorState)
            }
        })
    }

    
}

extension UsersViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.identifier) as! UsersTableViewCell
        
        cell.configure(data: users[indexPath.row])
        
        return cell
    }
}
