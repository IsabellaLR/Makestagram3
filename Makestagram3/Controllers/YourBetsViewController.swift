//
//  YourBetsViewController.swift
//  Makestagram3
//
//  Created by Bella on 3/1/19.
//  Copyright © 2019 Bella. All rights reserved.
//

//
//  ViewBetsViewController.swift
//  Makestagram3
//
//  Created by Bella on 1/2/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import Kingfisher

class YourBetsViewController: UIViewController {
    
    @IBOutlet weak var tableView2: UITableView!
    
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
        
        tableView2.rowHeight = 71
        // remove separators for empty cells
        tableView2.tableFooterView = UIView()
        
        ProfileService.show { [weak self] (profile) in
            self?.profile = profile
        }
        
        userBetsHandle = UserService.observeBets { [weak self] (parentKeys, ref, bets) in
            self?.userBetsRef = ref
            self?.bets = bets
            self?.parentKeys = parentKeys
            
            DispatchQueue.main.async {
                self?.tableView2.reloadData()
            }
        }
    }
    
    deinit {
        userBetsRef?.removeObserver(withHandle: userBetsHandle)
    }
}


// MARK: - UITableViewDataSource

extension YourBetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var yourBets = 0
        for bet in bets {
            if bet.senderUsername == User.current.username {
                yourBets += 1
            }
        }
        return yourBets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourBetsCell") as! YourBetsCell
        
        let bet = bets[indexPath.row]
        
        if (bet.senderUsername == User.current.username) {
        
            tableView.separatorStyle = .singleLine
            
//            cell.claimWin.setTitle("Claim", for: .normal)
            
            cell.userImage.layer.cornerRadius = 0.5 * cell.userImage.bounds.size.width
            cell.userImage.clipsToBounds = true
            cell.userImage.layer.borderWidth = 0.5
            cell.userImage.layer.borderColor = UIColor.lightGray.cgColor
        
            cell.usernameHeaderLabel.text = bet.sentToUser
            
            //colors
            if bet.color == "green" {
                cell.backgroundColor = UIColor.green
            }
            if bet.color == "blue" {
                cell.backgroundColor = UIColor.blue
            }else if bet.color == "white" {
                cell.backgroundColor = UIColor.white
            }
            
            
            //user profile image
            ProfileService.showOtherUser(user: bet.sentToUser) { [weak self] (profile2) in
                if  (self!.show == true){
                    self?.profile2 = profile2
                    if (profile2?.imageURL == "") {
                        cell.userImage.image = UIImage(named: "ninja")
                        self?.show = false
                    }else{
                        let imageURL = URL(string: ((profile2?.imageURL ?? "")))
                        cell.userImage.kf.setImage(with: imageURL)
                        self?.show = false
                    }
                }
            }
        
            cell.betDescription.text = bet.description
            cell.betDescription.textAlignment = .left
            cell.showEpisodeLabel.text = bet.episode
            
            if (HomeViewController().checkDates().contains(bet.episode)) {
                cell.wonButton.isHidden = false
                cell.lossButton.isHidden = false
                cell.tieButton.isHidden = false
                cell.outcomeLabel.text = "Claim"
            }else{
                cell.wonButton.isHidden = true
                cell.lossButton.isHidden = true
                cell.tieButton.isHidden = true
                cell.outcomeLabel.text = ""
            }
            
            cell.tappedWonAction = { (cell) in
                HistoryService.save(username: User.current.username, description: bet.description, winner: User.current.username, loser: bet.sentToUser, reward: "reward", episode: bet.episode)
                HistoryService.save(username: bet.sentToUser, description: bet.description, winner: User.current.username, loser: bet.sentToUser, reward: "reward", episode: bet.episode)
                BetService.remove(parentKey: bet.key ?? "", user: bet.sentToUser)
            }
            
            cell.tappedLossAction = { (cell) in
                HistoryService.save(username: User.current.username, description: bet.description, winner: bet.sentToUser, loser: User.current.username, reward: "reward", episode: bet.episode)
                HistoryService.save(username: bet.sentToUser, description: bet.description, winner: bet.sentToUser, loser: User.current.username, reward: "reward", episode: bet.episode)
                BetService.remove(parentKey: bet.key ?? "", user: bet.sentToUser)
            }
            
            cell.tappedTieAction = { (cell) in
                HistoryService.save(username: User.current.username, description: bet.description, winner: "tie", loser: "tie", reward: "reward", episode: bet.episode)
                HistoryService.save(username: bet.sentToUser, description: bet.description, winner: "tie", loser: "tie", reward: "reward", episode: bet.episode)
                BetService.remove(parentKey: bet.key ?? "", user: bet.sentToUser)
            }
//            cell.showPointsLabel.text = bet.points + " pts"
//            let date = bet.creationDate
//            cell.timeAgoLabel.text = bet.creationDate
            
            //assign action when user selects claim win
//            cell.tapClaimWinAction = { (cell) in
//                let parentKey = self.parentKeys[indexPath.row]
//                UserDefaults.standard.set(parentKey, forKey: "parentKey")
//                BetService.setBetWinner(parentKey: UserDefaults.standard.string(forKey: "parentKey") ?? "nil", user1: bet.senderUsername, user2: bet.sentToUser)
//            }
        }
        return cell
    }
    
    //deleting cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            bets.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate

extension YourBetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

