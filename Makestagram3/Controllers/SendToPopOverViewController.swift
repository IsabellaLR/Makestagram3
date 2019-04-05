//
//  SendToPopOverViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/30/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

class SendToPopOverViewController: UIViewController {

    var followingKeys = [String]()
    var followingKeys2 = [String]()
    var selectedUsers = [String]()
    var selectedUsers2 = [String]()
    var profile2: Profile?
    
    var newVariableName = MakeBetViewController()
 
    //get values from selected rows
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var usernamesView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.register(SendToFollowersCell.self, forCellReuseIdentifier: "SendToFollowersCell")
//        tableView.tableFooterView = UIView()//        tableView.rowHeight = 71
        self.tableView.allowsMultipleSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.usernamesView.layer.borderWidth = 1
        self.usernamesView.layer.borderColor = UIColor(red:170/255, green: 170/255, blue: 170/255, alpha: 0.5).cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FollowService.followerUsernames(for: User.current) { (followingKeys) in
            self.followingKeys = followingKeys
            self.tableView.reloadData()
        }
        
        FollowService.followerUids(for: User.current) { (followingKeys2) in
            self.followingKeys2 = followingKeys2
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
        guard let selectedIndexPathArray = self.tableView.indexPathsForSelectedRows else {
            return
        }
        for user in selectedIndexPathArray {
            selectedUsers.append(followingKeys[user.row])
        }
        
        for user in selectedIndexPathArray {
            selectedUsers2.append(followingKeys2[user.row])
        }
        
//        MakeBetViewController().completionHandler = { (reward) -> ()in
//            var rewardAndPoints = reward
//        }
        
        BetService.create(description: UserDefaults.standard.string(forKey: "betDescription") ?? "", senderUsername: User.current.uid, sentToUsernames: selectedUsers2, points: UserDefaults.standard.string(forKey: "rewardAndPoints") ?? "", episode: UserDefaults.standard.string(forKey: "episodeName") ?? "")
        print("REW AND POINTS: " + (UserDefaults.standard.string(forKey: "rewardAndPoints") ?? ""))
    }
    
}

extension SendToPopOverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followingKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SendToFollowersCell") as? SendToFollowersCell else {
            fatalError("Could not retrieve cell")
        }
        
        cell.userImage.layer.cornerRadius = 0.5 * cell.userImage.bounds.size.width
        cell.userImage.clipsToBounds = true
        cell.userImage.layer.borderWidth = 0.5
        cell.userImage.layer.borderColor = UIColor.lightGray.cgColor
        
        //        cell.delegate = self
        configure(cell: cell, atIndexPath: indexPath)
        
        // not showing images
        ProfileService.showOtherUser(user: cell.followerName.text) { [weak self] (profile2) in
            self?.profile2 = profile2
            if (profile2?.imageURL == "") {
                cell.userImage.image = UIImage(named: "ninja")
                print("NINJAAAAAAAA")
            }else{
                let imageURL = URL(string: ((profile2?.imageURL ?? "ninja")))
                cell.userImage.kf.setImage(with: imageURL)
                print("IMAGGGGGGGGGE")
            }
        }
        
        return cell
    }
    
    func configure(cell: SendToFollowersCell, atIndexPath indexPath: IndexPath) {
            
        cell.followerName.text = followingKeys[indexPath.row]
    }
}

// MARK: - UITableViewDelegate

extension SendToPopOverViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

