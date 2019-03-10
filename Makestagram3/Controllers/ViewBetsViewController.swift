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
        tableView.tableFooterView = UIView(frame: .zero)
        
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
        return bets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BetHeaderCell") as! BetHeaderCell
        
        let bet = bets[indexPath.row]
        
        if (bet.senderUsername != User.current.username){
            
            tableView.separatorStyle = .singleLine
            
//            cell.claimWin.setTitle("Claim", for: .normal)
            
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
            
            if (cell.showEpisodeLabel.text == UserDefaults.standard.string(forKey: "premieurEp") ?? "") {
                cell.agreeImage.image = UIImage(named: "winnerb4")
                cell.disagreeImage.image = UIImage(named: "loserb4")
                cell.whoWonLabel.text = "Who won?"
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
            
            //assign action when user selects claim win
//            cell.tapClaimWinAction = { (cell) in
//                let parentKey = self.parentKeys[indexPath.row]
//                BetService.setBetWinner(parentKey: UserDefaults.standard.string(forKey: "parentKey") ?? "nil", user1: bet.senderUsername, user2: bet.sentToUser)
//            }
            
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
                //
                if (bet.episode == UserDefaults.standard.string(forKey: "premieurEp") ?? ""){
                    if bet.senderUsername == User.current.username {
                        self.show = true
                        UserDefaults.standard.set(bet.sentToUser, forKey: "otherUsername")

                    }else{
                        self.show = true
                        UserDefaults.standard.set(bet.senderUsername, forKey: "otherUsername")
                    }
                    changeToWin()
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
                    if bet.senderUsername == User.current.username {
                        self.show = true
                        UserDefaults.standard.set(bet.sentToUser, forKey: "otherUsername")
                        
                    }else{
                        self.show = true
                        UserDefaults.standard.set(bet.senderUsername, forKey: "otherUsername")
                    }
                    changeToLose()
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
            
            func changeToWin(){
                cell.agreeImage.image = UIImage(named: "winner")
                if bet.senderUsername == User.current.username {
                    
                    ProfileService.showOtherUser(user: UserDefaults.standard.string(forKey: "otherUsername") ?? "") { [weak self] (profile2) in
                        if  (self!.show == true){
                            self?.profile2 = profile2
                            outcome1()
                            self?.show = false
                        }
                    }

                }else{
                    
                    ProfileService.showOtherUser(user: UserDefaults.standard.string(forKey: "otherUsername") ?? "") { [weak self] (profile2) in
                        if  (self!.show == true){
                            self?.profile2 = profile2
                            outcome2()
                            self?.show = false
                        }
                    }
                }
            }
            
            func changeToLose(){
                cell.disagreeImage.image = UIImage(named: "loser")
                if bet.senderUsername == User.current.username {
                    
                    ProfileService.showOtherUser(user: UserDefaults.standard.string(forKey: "otherUsername") ?? "") { [weak self] (profile2) in
                        if  (self!.show == true){
                            self?.profile2 = profile2
                            outcome3()
                            self?.show = false
                        }
                    }
                    
                }else{
                    
                    ProfileService.showOtherUser(user: UserDefaults.standard.string(forKey: "otherUsername") ?? "") { [weak self] (profile2) in
                        if  (self!.show == true){
                            self?.profile2 = profile2
                            outcome4()
                            self?.show = false
                        }
                    }
                }
            }
            
            func outcome1(){
                let pointsValue: Int? = Int(bet.points)
                ProfileService.create(username: bet.sentToUser, posValue: 0 + (profile2?.posPoints ?? 0), negValue: (pointsValue ?? 0) + (profile2?.negPoints ?? 0), wins: 0 + (profile2?.wins ?? 0), losses: 1 + (profile2?.losses ?? 0))
                ProfileService.create(username: User.current.username, posValue: (pointsValue ?? 0) + (profile?.posPoints ?? 0), negValue: 0 + (profile?.negPoints ?? 0), wins: 1 + (profile?.wins ?? 0), losses: 0 + (profile?.losses ?? 0))
                BetService.remove(parentKey: bet.key ?? "", user: bet.sentToUser)
            }
            
            func outcome2(){
                let pointsValue: Int? = Int(bet.points)
                ProfileService.create(username: bet.senderUsername, posValue: 0 + (profile2?.posPoints ?? 0), negValue: (pointsValue ?? 0) + (profile2?.negPoints ?? 0), wins: 0 + (profile2?.wins ?? 0), losses: 1 + (profile2?.losses ?? 0))
                ProfileService.create(username: User.current.username, posValue: (pointsValue ?? 0) + (profile?.posPoints ?? 0), negValue: 0 + (profile?.negPoints ?? 0), wins: 1 + (profile?.wins ?? 0), losses: 0 + (profile?.losses ?? 0))
                BetService.remove(parentKey: bet.key ?? "", user: bet.senderUsername)
            }
            
            func outcome3(){
                let pointsValue: Int? = Int(bet.points)
                ProfileService.create(username: bet.sentToUser, posValue: (pointsValue ?? 0) + (profile2?.posPoints ?? 0), negValue: 0 + (profile2?.negPoints ?? 0), wins: 1 + (profile2?.wins ?? 0), losses: 0 + (profile2?.losses ?? 0))
                ProfileService.create(username: User.current.username, posValue: 0 + (profile?.posPoints ?? 0), negValue: (pointsValue ?? 0) + (profile?.negPoints ?? 0), wins: 0 + (profile?.wins ?? 0), losses: 1 + (profile?.losses ?? 0))
                BetService.remove(parentKey:  bet.key ?? "", user: bet.sentToUser)
            }
           
            func outcome4(){
                let pointsValue: Int? = Int(bet.points)
                ProfileService.create(username: bet.senderUsername, posValue: (pointsValue ?? 0) + (profile2?.posPoints ?? 0), negValue: 0 + (profile2?.negPoints ?? 0), wins: 1 + (profile2?.wins ?? 0), losses: 0 + (profile2?.losses ?? 0))
                ProfileService.create(username: User.current.username, posValue: 0 + (profile?.posPoints ?? 0), negValue: (pointsValue ?? 0) + (profile?.negPoints ?? 0), wins: 0 + (profile?.wins ?? 0), losses: 1 + (profile?.losses ?? 0))
                BetService.remove(parentKey: bet.key ?? "", user: bet.senderUsername)
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
