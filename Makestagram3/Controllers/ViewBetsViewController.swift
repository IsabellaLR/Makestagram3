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

class ViewBetsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var bets = [Bet]()
    var parentKeys = [String]()
    var agreeImageHighlighted = false
    var disagreeImageHighlighted = false
    var isPremieurEp = false
    
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
        
        // 2
        
        userBetsHandle = UserService.observeBets { [weak self] (parentKeys, ref, bets) in
            self?.userBetsRef = ref
            self?.bets = bets
            self?.parentKeys = parentKeys

            // 3
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    deinit {
        // 4
        userBetsRef?.removeObserver(withHandle: userBetsHandle)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        ProfileService.show(user: User) { [unowned self] (profiles) in
//            self.profiles = profiles
//        }
//    }
}


// MARK: - UITableViewDataSource

extension ViewBetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BetHeaderCell") as! BetHeaderCell
        
        let bet = bets[indexPath.row]

        if (bet.senderUsername == User.current.username) {
            cell.usernameHeaderLabel.text = bet.sentToUser
        }else{
            cell.usernameHeaderLabel.text = bet.senderUsername
        }
        cell.betDescription.text = bet.description
        cell.betDescription.textAlignment = .left
        cell.showPointsLabel.text = bet.points + " pts"
        let date = bet.creationDate
        cell.timeAgoLabel.text = bet.creationDate
        cell.showEpisodeLabel.text = bet.episode
        
        if (cell.showEpisodeLabel.text == UserDefaults.standard.string(forKey: "premieurEp") ?? "") {
            isPremieurEp == true
            cell.agreeImage.image = UIImage(named: "winnerb4")
            cell.disagreeImage.image = UIImage(named: "loserb4")
            cell.whoWonLabel.text = "Who won?"
        }
        
        func changeToWin(){
            cell.agreeImage.image = UIImage(named: "winner")
            let pointsValue: Int? = Int(bet.points)
            if bet.senderUsername == User.current.username {
                ProfileService.create(username: User.current.username, posValue: pointsValue ?? 0, negValue: 0)
                ProfileService.create(username: bet.sentToUser, posValue: 0, negValue: pointsValue ?? 0)
            }else{
                ProfileService.create(username: User.current.username, posValue: pointsValue ?? 0, negValue: 0)
                ProfileService.create(username: bet.senderUsername, posValue: 0, negValue: pointsValue ?? 0)
            }
        }
        
        func changeToLose(){
            let pointsValue: Int? = Int(bet.points)
            cell.disagreeImage.image = UIImage(named: "loser")
            if bet.senderUsername == User.current.username {
                ProfileService.create(username: bet.sentToUser, posValue: pointsValue ?? 0, negValue: 0)
                ProfileService.create(username: User.current.username, posValue: 0, negValue: pointsValue ?? 0)
            } else {
                ProfileService.create(username: bet.senderUsername, posValue: pointsValue ?? 0, negValue: 0)
                ProfileService.create(username: User.current.username, posValue: 0, negValue: pointsValue ?? 0)
            }
        }
        
        //images - highlighted and nonhighlighted
        func changeAgreeImage() {
            if (agreeImageHighlighted == false) {
                cell.agreeImage.image = UIImage(named: "agree")
                cell.disagreeImage.image = UIImage(named: "disagreeb4")
                agreeImageHighlighted = true
                disagreeImageHighlighted = false
            }else{
                cell.agreeImage.image = UIImage(named: "agreeb4")
                agreeImageHighlighted = false
                disagreeImageHighlighted = false
            }
        }
        
        func changeDisagreeImage() {
            if (disagreeImageHighlighted == false){
                cell.disagreeImage.image = UIImage(named: "disagree")
                cell.agreeImage.image = UIImage(named: "agreeb4")
                disagreeImageHighlighted = true
                agreeImageHighlighted = false
            }else{
                cell.disagreeImage.image = UIImage(named: "disagreeb4")
                disagreeImageHighlighted = false
                agreeImageHighlighted = false
            }
        }
        
        //color
        enum Color: String {
            case white
            case blue
            case green
            
            var create: UIColor {
                switch self {
                case .white:
                    return UIColor.white
                case .blue:
                    return UIColor.blue
                case .green:
                    return UIColor.green
                }
            }
        }
        
        let color = Color(rawValue: bet.color)
        
        let colorSelected = color?.create
        
        cell.backgroundColor = colorSelected
        
        // assigning image states for other users
        if (cell.showEpisodeLabel.text != UserDefaults.standard.string(forKey: "premieurEp") ?? ""){
            if (bet.senderUsername != User.current.username) {
                if bet.color == "white" {
                    cell.agreeImage.image = UIImage(named: "agreeb4")
                    cell.disagreeImage.image = UIImage(named: "disagreeb4")
                }else if (bet.color == "blue") {
                    cell.agreeImage.image = UIImage(named: "agree")
                    cell.disagreeImage.image = UIImage(named: "disagreeb4")
                }else{
                    cell.agreeImage.image = UIImage(named: "agreeb4")
                    cell.disagreeImage.image = UIImage(named: "disagree")
                }
            }
        }
        
        // Assign the tap action which will be executed when the user taps the UIButton
        
        //Agree - blue
        cell.tapAgreeAction = { (cell) in
            if (bet.episode == UserDefaults.standard.string(forKey: "premieurEp") ?? ""){
                changeToWin()
            }
            if (bet.senderUsername == User.current.username) {
                return
            }else{
                changeAgreeImage()
                let parentKey = self.parentKeys[indexPath.row]
                UserDefaults.standard.set(parentKey, forKey: "parentKey")
                if (self.agreeImageHighlighted == true) {
                    BetService.setBetColor(color: "blue", parentKey: UserDefaults.standard.string(forKey: "parentKey") ?? "nil", user1: bet.senderUsername, user2: bet.sentToUser)
                }else{
                    BetService.setBetColor(color: "white", parentKey: UserDefaults.standard.string(forKey: "parentKey") ?? "nil", user1: bet.senderUsername, user2: bet.sentToUser)
                }
            }
        }
        
        //Disagree - green
        cell.tapDisagreeAction = { (cell) in
            if (bet.episode == UserDefaults.standard.string(forKey: "premieurEp") ?? ""){
                changeToLose()
            }
            if (bet.senderUsername == User.current.username) {
                return
            }else{
                changeDisagreeImage()
                let parentKey = self.parentKeys[indexPath.row]
                UserDefaults.standard.set(parentKey, forKey: "parentKey")
                if (self.disagreeImageHighlighted == true) {
                    BetService.setBetColor(color: "green", parentKey: UserDefaults.standard.string(forKey: "parentKey") ?? "nil", user1: bet.senderUsername, user2: bet.sentToUser)
                }else{
                    BetService.setBetColor(color: "white", parentKey: UserDefaults.standard.string(forKey: "parentKey") ?? "nil", user1: bet.senderUsername, user2: bet.sentToUser)
                }
            }
        }
        
        return cell
    }
}

 // MARK: - UITableViewDelegate

extension ViewBetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
