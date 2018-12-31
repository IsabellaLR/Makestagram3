//
//  SendToPopOverViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/30/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit

class SendToPopOverViewController: UIViewController {
    
    var followersArr = [User]()
 
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
//        tableView.rowHeight = 71
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FollowService.retrieveFollowers(for: User.current) { [unowned self] (followersArr) in
            if let followersArray = followersArr {
                self.followersArr = followersArray
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SendToPopOverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followersArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SendToFollowersCell") as! SendToFollowersCell
        cell.delegate = self
        configure(cell: cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configure(cell: SendToFollowersCell, atIndexPath indexPath: IndexPath) {
        let followers = followersArr[indexPath.row]
        
        cell.followerName.text = followers.username
    }
}

extension SendToPopOverViewController: SendToFollowersCellDelegate {
    func didTapFollowButton(_ sendButton: UIButton, on cell: SendToFollowersCell) {
        //you could just pass around the indexpath here instead of the whole cell
        print("Cell with \(cell.tag) was pressed")
        //the answer to your question is no
     //su
    }
}

/*extension SendToPopOverViewController: FindFriendsCellDelegate {
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

*/
