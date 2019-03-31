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
    
    var winner: String?
    
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
            if bet.winner != User.current.uid {
                lossBets += 1
            }
        }
        print("NUM BETS" + String(lossBets))
        return lossBets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DebtBetsCell") as! DebtBetsCell
        
        var info = [History]()
        var keys = [String]()
        var index = 0
        for bet in bets {
            if bet.winner != User.current.uid {
                info.append(bet)
                keys.append(parentKeys[index])
            }
            index += 1
        }
        let bet = info[indexPath.row]
        let key = keys[indexPath.row]
        
        if bet.check == "check1" {
            cell.swordButton.setImage(UIImage(named: "greenCheck"), for: .normal)
        } else {
            cell.swordButton.setImage(UIImage(named: "reward"), for: .normal)
        }

        cell.tappedSwordAction = { (cell) in
            HistoryService.updateChild(child: "check", childVal: "check1", key: key) //do you love me
        }
        
//        winner
        if (bet.winner != User.current.uid) {
            tableView.separatorStyle = .singleLine
            //tie
            if bet.winner == "tie" {
                print("TIE")
                cell.betDescription.text = bet.episode + ": No one voted for the bet ~ " + bet.description
            }else{
                //this code seems to slow down
                UserService.retrieveChild(uid: bet.winner, child: "username") { (childVal) in
                    if let childVal = childVal {
                        print("LOSS")
                        self.winner = childVal
                        var rewardVal = " " + bet.reward
                        var betVal = " for the bet ~ " + bet.description
                        cell.betDescription.text = bet.episode + ": You owe " + (self.winner ?? "") + rewardVal + betVal
                    }
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
