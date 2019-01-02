//
//  SendToPopOverViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/30/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit

class SendToPopOverViewController: UIViewController {
    
    var followersKey = [String]()
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
//        tableView.rowHeight = 71
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FollowService.followers(for: User.current) { [unowned self] (followersKey) in
                self.followersKey = followersKey
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendTapped(_ sender: Any) {
        let initialViewController = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
}

extension SendToPopOverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followersKey.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SendToFollowersCell") as! SendToFollowersCell
//        cell.delegate = self
        configure(cell: cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configure(cell: SendToFollowersCell, atIndexPath indexPath: IndexPath) {
        let followers = followersKey[indexPath.row]
        
        cell.followerName.text = followers
    }
}

//extension SendToPopOverViewController: SendToFollowersCellDelegate {
//    func didTapFollowButton(_ sendButton: UIButton, on cell: SendToFollowersCell) {
//        //you could just pass around the indexpath here instead of the whole cell
//        print("Cell with \(cell.tag) was pressed")
//        //the answer to your question is no
//     //su
//    }
//}

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
