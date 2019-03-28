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
    
    @IBOutlet weak var tableView3: UITableView!
    
    var bets = [History]()
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
        
        tableView3.rowHeight = 71
        // remove separators for empty cells
        tableView3.tableFooterView = UIView()
        
        ProfileService.show { [weak self] (profile) in
            self?.profile = profile
        }
        
        userBetsHandle = HistoryService.observeHistory { [weak self] (parentKeys, ref, bets) in
            self?.userBetsRef = ref
            self?.bets = bets
            self?.parentKeys = parentKeys
            
            DispatchQueue.main.async {
                self?.tableView3.reloadData()
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
        var lossBets = 0
        for bet in bets {
            if bet.winner != User.current.username {
                lossBets += 1
            }
        }
        return lossBets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DebtBetsCell") as! DebtBetsCell
        
        let bet = bets[indexPath.row]
        
        //winner
        if bet.winner != User.current.username {
            
            tableView.separatorStyle = .singleLine

            cell.betDescription.text = bet.episode + ": You owe " + bet.winner + bet.reward + " for the bet ~ " + bet.description
        }
        
        //tie
        if bet.winner == "tie" {
            
            tableView.separatorStyle = .singleLine
            
            cell.betDescription.text = bet.episode + ": No one voted for the bet ~ " + bet.description
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
