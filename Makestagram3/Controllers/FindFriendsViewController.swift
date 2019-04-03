//
//  FindFriendsViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/25/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit

class FindFriendsViewController: UIViewController {
    
    var users = [User]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchItem = [String]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 71
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserService.usersExcludingCurrentUser { [unowned self] (users) in
            self.users = users
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension FindFriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchItem.count
        } else {
            return users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindFriendsCell") as! FindFriendsCell
        
//        let user = users[indexPath.row]
        
        var usernamesArr = [String]()
        for user in users {
            usernamesArr.append(user.username)
        }
        
        if searching {
            cell.usernameLabel?.text = searchItem[indexPath.row]
        } else {
            cell.usernameLabel?.text = usernamesArr[indexPath.row]
//            cell.delegate = self
            configure(cell: cell, atIndexPath: indexPath)
        }
        
        return cell
    }
    
    func configure(cell: FindFriendsCell, atIndexPath indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        cell.usernameLabel.text = user.username
        cell.followButton.isSelected = user.isFollowed
    }
}

extension FindFriendsViewController: FindFriendsCellDelegate {
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFriendsCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        followButton.isUserInteractionEnabled = false
        let followee = users[indexPath.row]
        
        FollowService.setIsFollowing(!followee.isFollowed, fromCurrentUserTo: followee) { (success) in
            defer {
                followButton.isUserInteractionEnabled = true
            }
            
            guard success else { return }
            
            followee.isFollowed = !followee.isFollowed
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}

extension FindFriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var usernamesArr = [String]()
        for user in users {
            usernamesArr.append(user.username)
        }
        searchItem = usernamesArr.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
}
