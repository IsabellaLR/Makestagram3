//
//  FriendsListViewController.swift
//  Makestagram3
//
//  Created by Bella on 4/19/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class FriendsListViewController: UIViewController {
    
    var followingKeys = [String]()
    var followingKeys2 = [String]()
    var uid: String?
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FollowService.followingUsernames(for: User.current) { (followingKeys) in
            self.followingKeys = followingKeys
            self.tableView.reloadData()
        }
        
        FollowService.followingUids(for: User.current) { (followingKeys2) in
            self.followingKeys2 = followingKeys2
            self.tableView.reloadData()
        }
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FriendsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followingKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendsListCell") as? FriendsListCell else {
            fatalError("Could not retrieve cell")
        }
        configure(cell: cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configure(cell: FriendsListCell, atIndexPath indexPath: IndexPath) {
        
        cell.username.text = followingKeys[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FriendProfileViewController") as? FriendProfileViewController
        vc?.name = followingKeys2[indexPath.row]
        uid = vc?.name
        UserDefaults.standard.set(uid, forKey: "uid")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension FriendsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
