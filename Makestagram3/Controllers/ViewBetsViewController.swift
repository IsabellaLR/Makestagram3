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
    
    var userBetsHandle: DatabaseHandle = 0
    var userBetsRef: DatabaseReference?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    func configureTableView() {
//        // remove separators for empty cells
////        tableView.tableFooterView = UIView()
////        // remove separators from cells
////        tableView.separatorStyle = .none
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.delegate = self
//        self.tableView.datasource = self
        
        tableView.rowHeight = 71
        // remove separators for empty cells
        tableView.tableFooterView = UIView()
        
        // 2
        
        userBetsHandle = UserService.observeBets { [weak self] (ref, bets) in
            self?.userBetsRef = ref
            self?.bets = bets

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
}
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        BetService.show(user: User.current) { (bet) in
//            self.bets = bets
//            self.tableView.reloadData()
//        }
//    }
//    UserService.observeBet(user: User.current) { (bets) in
//            self.bets = bets
//            self.tableView.reloadData()
//        }
//    }

// MARK: - UITableViewDataSource

extension ViewBetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bets.count
    }

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return bets.count
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BetHeaderCell") as! BetHeaderCell
        
        let bet = bets[indexPath.row]
        cell.usernameHeaderLabel.text = bet.senderUsername
        cell.betDescription.text = bet.description
        
        return cell
    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let bet = bets[indexPath.section]
//
//        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "BetHeaderCell") as! BetHeaderCell
//            cell.usernameHeaderLabel.text = bet.senderUsername
//
//            return cell
//
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ShowBetCell") as! ShowBetCell
//            cell.betDescription.text = bet.description
//
//            return cell
//
//        default:
//            fatalError("Error: unexpected indexPath.")
//        }
//    }
}


//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let bet = bets[indexPath.section]
//        switch indexPath.row {
//        case 0:
//            return BetHeaderCell.height
//
//        case 1:
//            let somethingBet = bet[indexPath.section]
//
//        default:
//            fatalError()
//        }
//    }
//}

 // MARK: - UITableViewDelegate

//extension ViewBetsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let bet = bets[indexPath.row]
//        return post.imageHeight
//    }
//}
