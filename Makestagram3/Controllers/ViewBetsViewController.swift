//
//  ViewBetsViewController.swift
//  Makestagram3
//
//  Created by Bella on 1/2/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import Foundation
import UIKit

class ViewBetsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
//    func configureTableView() {
//        // remove separators for empty cells
//        tableView.tableFooterView = UIView()
//        // remove separators from cells
//        tableView.separatorStyle = .none
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureTableView()
//
//        // ...
//    }
    
//    var bets = [Bet]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        UserService.bets(for: User.current) { (bets) in
//            self.bets = bets
//            self.tableView.reloadData()
//        }
//    }
}

// MARK: - UITableViewDataSource

//extension ViewBetsViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let bet = bets[indexPath.section]
//
//            switch indexPath.row {
//            case 0:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "BetHeaderCell") as! BetHeaderCell
//                cell.usernameHeaderLabel.text = User.current.username
//
//                return cell
//
//            case 1:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "ShowBetCell") as! ShowBetCell
//                // need the description bet here
//
//                return cell
//
//            default:
//                fatalError("Error: unexpected indexPath.")
//            }
//        }
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return bets.count
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0:
//            return BetHeaderCell.height
//
//        case 1:
//            let bet = bets[indexPath.section]
//            return bet.imageHeight
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
//
//        return post.imageHeight
//    }
//}
