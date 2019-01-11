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

//    var selectedIndexPathArray = [IndexPath?]()
    var followingKeys = [String]()
    var selectedUsers = [String]()
    
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
        
        FollowService.followingUsernames(for: User.current) { (followingKeys) in
            self.followingKeys = followingKeys
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
        BetService.create(description: UserDefaults.standard.string(forKey: "betDescription") ?? "nil", senderUsername: User.current.username, sentToUsernames: selectedUsers)
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
        
//        cell.delegate = self
        configure(cell: cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configure(cell: SendToFollowersCell, atIndexPath indexPath: IndexPath) {
            
        cell.followerName.text = followingKeys[indexPath.row]
    }
}

