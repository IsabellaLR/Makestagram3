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
    @IBOutlet weak var claimButton: UIButton!
    
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
        
        tableView4.rowHeight = 71
        // remove separators for empty cells
        tableView4.tableFooterView = UIView()
        
        ProfileService.show { [weak self] (profile) in
            self?.profile = profile
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
    
    @IBAction func onSMSPress(_ sender: UIButton) {
        
        if MFMessageComposeViewController.canSendText() {
            
            let controller = MFMessageComposeViewController()
            controller.body = self.msgText.text
            controller.recipients = [self.phoneNumber.text!]
            controller.messageComposeDelegate = self
            
            self.present(controller, animated: true, completion: nil)
            
        }
        else {
            print("Cannot send text")
        }
        
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
            if bet.winner != User.current.username {
                wonBets += 1
            }
        }
        return wonBets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wonCell") as! wonCell
        
        let bet = bets[indexPath.row]
        
        //winner
        if bet.winner == User.current.username {
            
            tableView.separatorStyle = .singleLine
            
            cell.betDescription.text = bet.episode + ": Claim " + bet.reward + " for the bet ~ " + bet.description
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
