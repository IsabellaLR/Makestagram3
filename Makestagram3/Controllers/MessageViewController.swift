//
//  MessageViewController.swift
//  Makestagram3
//
//  Created by Bella on 3/27/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit
import MessageUI
import Foundation
import FirebaseDatabase
import Kingfisher

class MessageViewController: UIViewController {

    @IBOutlet weak var tableView4: UITableView!
    
    var bets = [History]()
    var profile: Profile?
    var user: User?
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
        
        tableView4.rowHeight = 71
        // remove separators for empty cells
        tableView4.tableFooterView = UIView()
        
        ProfileService.show { [weak self] (profile) in
            self?.profile = profile
        }
        
        UserService.show(forUID: User.current.uid) { [weak self] (user) in
            self?.user = user
        }
        
        userBetsHandle = HistoryService.observeHistory { [weak self] (parentKeys, ref, bets) in
            self?.userBetsRef = ref
            self?.bets = bets
            self?.parentKeys = parentKeys
            
            DispatchQueue.main.async {
                self?.tableView4.reloadData()
            }
        }
    }
    
    deinit {
        userBetsRef?.removeObserver(withHandle: userBetsHandle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MessageViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var wonBets = 0
        for bet in bets {
            if bet.winner == User.current.uid {
                wonBets += 1
            }
        }
        print(wonBets)
        return wonBets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WonCell") as! WonCell
        
        var info = [History]()
        for bet in bets {
            if bet.winner == User.current.uid {
                info.append(bet)
            }
        }
        let bet = info[indexPath.row]
        
        if bet.winner == User.current.uid {
            
            tableView.separatorStyle = .singleLine
            
            cell.betDescription.text = bet.episode + ": Claim " + bet.reward + " for the bet ~ " + bet.description
        }
        
        cell.tappedClaimAction = { (cell) in
            if MFMessageComposeViewController.canSendText() {
                
                let controller = MFMessageComposeViewController()
                controller.body = "You owe me " + bet.reward + " for the bet " + bet.description
                // Change username to uid
                UserService.retrieveChild(uid: bet.loser, child: "phoneNumber") { (childVal) in
                    if let childVal = childVal {
                        controller.recipients = [childVal]
                    }
                }
                controller.messageComposeDelegate = self
                
                self.present(controller, animated: true, completion: nil)
                
                //show check mark
            }
            else {
                print("Cannot send text")
            }
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
