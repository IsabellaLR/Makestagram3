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

extension YourBetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourBetsCell") as! YourBetsCell
        
        let bet = bets[indexPath.row]
        
        if (bet.senderUsername == User.current.username) {
        
            tableView.separatorStyle = .singleLine
            
            cell.claimWin.setTitle("Claim", for: .normal)
            
            cell.userImage.layer.cornerRadius = 0.5 * cell.userImage.bounds.size.width
            cell.userImage.clipsToBounds = true
            cell.userImage.layer.borderWidth = 0.5
            cell.userImage.layer.borderColor = UIColor.lightGray.cgColor
        
            cell.usernameHeaderLabel.text = bet.sentToUser
            
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
            cell.showPointsLabel.text = bet.points + " pts"
            let date = bet.creationDate
            cell.timeAgoLabel.text = bet.creationDate
            cell.showEpisodeLabel.text = bet.episode
            
            //assign action when user selects claim win
            cell.tapClaimWinAction = { (cell) in
                let parentKey = self.parentKeys[indexPath.row]
                UserDefaults.standard.set(parentKey, forKey: "parentKey")
                BetService.setBetWinner(parentKey: UserDefaults.standard.string(forKey: "parentKey") ?? "nil", user1: bet.senderUsername, user2: bet.sentToUser)
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension YourBetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

