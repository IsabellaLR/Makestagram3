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

class ViewBetsViewController: UIViewController {

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

extension ViewBetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var FriendBets = 0
        for bet in bets {
            if bet.senderUsername != User.current.uid {
                FriendBets += 1
            }
        }
        print("FRIEND" + String(FriendBets))
        return FriendBets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BetHeaderCell") as! BetHeaderCell
        
        var info = [Bet]()
        var keys = [String]()
        var index = 0
        for bet in bets {
            if bet.senderUsername != User.current.uid {
                info.append(bet)
                keys.append(parentKeys[index])
            }
            index += 1
        }
        let bet = info[indexPath.row]
        let key = keys[indexPath.row]

        if (bet.senderUsername != User.current.uid){
            
            tableView.separatorStyle = .singleLine
            
            cell.userImage.layer.cornerRadius = 0.5 * cell.userImage.bounds.size.width
            cell.userImage.clipsToBounds = true
            cell.userImage.layer.borderWidth = 1
            cell.userImage.layer.borderColor = UIColor.darkGray.cgColor
            
            UserService.show(forUID: bet.senderUsername) { (user) in
                cell.usernameHeaderLabel.text = user?.username ?? ""
            }
                
                //user profile image
            ProfileService.showOtherUser(user: bet.senderUsername) { [weak self] (profile2) in
//                if  (self!.show == true){
                    self?.profile2 = profile2
                    if (profile2?.imageURL == "") {
                        cell.userImage.image = UIImage(named: "ninja")
//                        self?.show = false
                    }else{
                        let imageURL = URL(string: ((profile2?.imageURL ?? "")))
                        cell.userImage.kf.setImage(with: imageURL)
//                        self?.show = false
//                    }
                }
            }
            
            if (HomeViewController().checkDates().contains(bet.episode)) {
                cell.agreeButton.isHidden = true
                cell.disagreeButton.isHidden = true
            }else{
                cell.agreeButton.isHidden = false
                cell.disagreeButton.isHidden = false
            }
                
            cell.betDescription.text = bet.description
            cell.betDescription.textAlignment = .left
            cell.showPointsLabel.text = bet.points
            cell.showEpisodeLabel.text = bet.episode
            
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
            if (HomeViewController().checkDates().contains(bet.episode) == false) {
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
                if bet.color == "blue" {
                    BetService.setBetColor(color: "white", parentKey: key, user1: bet.senderUsername, user2: bet.sentToUser)
                } else {
                    BetService.setBetColor(color: "blue", parentKey: key, user1: bet.senderUsername, user2: bet.sentToUser)
                }
                //
//                if (bet.episode == UserDefaults.standard.string(forKey: "premieurEp") ?? ""){
//                    if bet.senderUsername == User.current.uid {
//                        self.show = true
//                        UserDefaults.standard.set(bet.sentToUser, forKey: "otherUsername")
//
//                    }else{
//                        self.show = true
//                        UserDefaults.standard.set(bet.senderUsername, forKey: "otherUsername")
//                    }
//                    changeToWin()
//                }else{
//                    changeAgreeImage()
//                    let parentKey = self.parentKeys[indexPath.row]
//                    UserDefaults.standard.set(parentKey, forKey: "parentKey")
//                    if (self.agreeImageHighlighted == true) {
//                        BetService.setBetColor(color: "blue", parentKey: UserDefaults.standard.string(forKey: "parentKey") ?? "nil", user1: bet.senderUsername, user2: bet.sentToUser)
//                    }else{
//                        BetService.setBetColor(color: "white", parentKey: UserDefaults.standard.string(forKey: "parentKey") ?? "nil", user1: bet.senderUsername, user2: bet.sentToUser)
//                    }
//                }
            }
            
            //Disagree - green
            cell.tapDisagreeAction = { (cell) in
                if bet.color == "green" {
                    BetService.setBetColor(color: "white", parentKey: key, user1: bet.senderUsername, user2: bet.sentToUser)
                } else {
                    BetService.setBetColor(color: "green", parentKey: key, user1: bet.senderUsername, user2: bet.sentToUser)
                }
//                if (bet.episode == UserDefaults.standard.string(forKey: "premieurEp") ?? ""){
//                    if bet.senderUsername == User.current.uid {
//                        self.show = true
//                        UserDefaults.standard.set(bet.sentToUser, forKey: "otherUsername")
//
//                    }else{
//                        self.show = true
//                        UserDefaults.standard.set(bet.senderUsername, forKey: "otherUsername")
//                    }
//                    changeToLose()
//                }else{
//                    changeDisagreeImage()
//                    let parentKey = self.parentKeys[indexPath.row]
//                    UserDefaults.standard.set(parentKey, forKey: "parentKey")
//                    if (self.disagreeImageHighlighted == true) {
//                        BetService.setBetColor(color: "green", parentKey: UserDefaults.standard.string(forKey: "parentKey") ?? "nil", user1: bet.senderUsername, user2: bet.sentToUser)
//                    }else{
//                        BetService.setBetColor(color: "white", parentKey: UserDefaults.standard.string(forKey: "parentKey") ?? "nil", user1: bet.senderUsername, user2: bet.sentToUser)
//                    }
//                }
            }
            
//            func changeToWin(){
//                cell.agreeImage.image = UIImage(named: "winner")
//                if bet.senderUsername == User.current.uid {
//
//                    ProfileService.showOtherUser(user: UserDefaults.standard.string(forKey: "otherUsername") ?? "") { [weak self] (profile2) in
//                        if  (self!.show == true){
//                            self?.profile2 = profile2
//                            outcome1()
//                            self?.show = false
//                        }
//                    }
//
//                }else{
//
//                    ProfileService.showOtherUser(user: UserDefaults.standard.string(forKey: "otherUsername") ?? "") { [weak self] (profile2) in
//                        if  (self!.show == true){
//                            self?.profile2 = profile2
//                            outcome2()
//                            self?.show = false
//                        }
//                    }
//                }
//            }
//
//            func changeToLose(){
//                cell.disagreeImage.image = UIImage(named: "loser")
//                if bet.senderUsername == User.current.uid {
//
//                    ProfileService.showOtherUser(user: UserDefaults.standard.string(forKey: "otherUsername") ?? "") { [weak self] (profile2) in
//                        if  (self!.show == true){
//                            self?.profile2 = profile2
//                            outcome3()
//                            self?.show = false
//                        }
//                    }
//
//                }else{
//
//                    ProfileService.showOtherUser(user: UserDefaults.standard.string(forKey: "otherUsername") ?? "") { [weak self] (profile2) in
//                        if  (self!.show == true){
//                            self?.profile2 = profile2
//                            outcome4()
//                            self?.show = false
//                        }
//                    }
//                }
//            }
//
//            func outcome1(){
//                let pointsValue: Int? = Int(bet.points)
//                ProfileService.create(username: bet.sentToUser, posValue: 0 + (profile2?.posPoints ?? 0), negValue: (pointsValue ?? 0) + (profile2?.negPoints ?? 0), wins: 0 + (profile2?.wins ?? 0), losses: 1 + (profile2?.losses ?? 0))
//                ProfileService.create(username: User.current.uid, posValue: (pointsValue ?? 0) + (profile?.posPoints ?? 0), negValue: 0 + (profile?.negPoints ?? 0), wins: 1 + (profile?.wins ?? 0), losses: 0 + (profile?.losses ?? 0))
//                BetService.remove(parentKey: bet.key ?? "", user: bet.sentToUser)
//            }
//
//            func outcome2(){
//                let pointsValue: Int? = Int(bet.points)
//                ProfileService.create(username: bet.senderUsername, posValue: 0 + (profile2?.posPoints ?? 0), negValue: (pointsValue ?? 0) + (profile2?.negPoints ?? 0), wins: 0 + (profile2?.wins ?? 0), losses: 1 + (profile2?.losses ?? 0))
//                ProfileService.create(username: User.current.uid, posValue: (pointsValue ?? 0) + (profile?.posPoints ?? 0), negValue: 0 + (profile?.negPoints ?? 0), wins: 1 + (profile?.wins ?? 0), losses: 0 + (profile?.losses ?? 0))
//                BetService.remove(parentKey: bet.key ?? "", user: bet.senderUsername)
//            }
//
//            func outcome3(){
//                let pointsValue: Int? = Int(bet.points)
//                ProfileService.create(username: bet.sentToUser, posValue: (pointsValue ?? 0) + (profile2?.posPoints ?? 0), negValue: 0 + (profile2?.negPoints ?? 0), wins: 1 + (profile2?.wins ?? 0), losses: 0 + (profile2?.losses ?? 0))
//                ProfileService.create(username: User.current.uid, posValue: 0 + (profile?.posPoints ?? 0), negValue: (pointsValue ?? 0) + (profile?.negPoints ?? 0), wins: 0 + (profile?.wins ?? 0), losses: 1 + (profile?.losses ?? 0))
//                BetService.remove(parentKey:  bet.key ?? "", user: bet.sentToUser)
//            }
//
//            func outcome4(){
//                let pointsValue: Int? = Int(bet.points)
//                ProfileService.create(username: bet.senderUsername, posValue: (pointsValue ?? 0) + (profile2?.posPoints ?? 0), negValue: 0 + (profile2?.negPoints ?? 0), wins: 1 + (profile2?.wins ?? 0), losses: 0 + (profile2?.losses ?? 0))
//                ProfileService.create(username: User.current.uid, posValue: 0 + (profile?.posPoints ?? 0), negValue: (pointsValue ?? 0) + (profile?.negPoints ?? 0), wins: 0 + (profile?.wins ?? 0), losses: 1 + (profile?.losses ?? 0))
//                BetService.remove(parentKey: bet.key ?? "", user: bet.senderUsername)
//            }
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
