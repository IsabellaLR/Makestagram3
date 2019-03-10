//
//  DebtBetViewController.swift
//  Makestagram3
//
//  Created by Bella on 3/1/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import Kingfisher

class DebtBetsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var bets = [Bet]()
    var profile: Profile?
    var profile2: Profile?
    var parentKeys = [String]()
    var agreeImageHighlighted = false
    var disagreeImageHighlighted = false
    var isPremieurEp = false
    var show = true
    
    var userBetsHandle: DatabaseHandle = 0
    var userBetsRef: DatabaseReference?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 71
        // remove separators for empty cells
        tableView.tableFooterView = UIView()
        
        ProfileService.show { [weak self] (profile) in
            self?.profile = profile
        }
        
        userBetsHandle = UserService.observeBets { [weak self] (parentKeys, ref, bets) in
            self?.userBetsRef = ref
            self?.bets = bets
            self?.parentKeys = parentKeys
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    deinit {
        userBetsRef?.removeObserver(withHandle: userBetsHandle)
    }
}


// MARK: - UITableViewDataSource

extension DebtBetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DebtBetsCell") as! DebtBetsCell
        
        let bet = bets[indexPath.row]
        
        if bet.winner != "tbd" {
            
            tableView.separatorStyle = .singleLine
        
            if (bet.winner == User.current.username) {
                
                if bet.senderUsername == User.current.username {
                    cell.betDescription.text = User.current.username + " beat " + bet.sentToUser + " for " + bet.description
                }else{
                    cell.betDescription.text = User.current.username + " beat " + bet.senderUsername + " for " + bet.description
                }
            }
            
            if (bet.winner != User.current.username) {
                
                if bet.senderUsername == User.current.username {
                    cell.betDescription.text = User.current.username + " loss to " + bet.sentToUser + " for " + bet.description
                }else{
                    cell.betDescription.text = User.current.username + " loss to " + bet.senderUsername + " for " + bet.description
                }
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DebtBetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
