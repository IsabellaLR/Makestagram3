//
//  PopOverViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/29/18.
//  Copyright © 2018 Bella. All rights reserved.
//

//import Foundation
//import UIKit
//import FirebaseDatabase.FIRDataSnapshot
//
//class PopOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
////    var followeeName: [String] = FindFriendsViewController(coder: UIViewController).followee
//
//    @IBOutlet weak var Popupview: UIView!
//
//    @IBOutlet weak var tableView: UITableView!
//
//    var names: [String] = ["Mumbai","New York","Tokyo","London","Beijing","Sydney","Wellington","Madrid","Rome","Cape Town","Ottawa"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.dataSource = self
//        tableView.delegate = self
//
//        // Apply radius to Popupview
//        Popupview.layer.cornerRadius = 10
//        Popupview.layer.masksToBounds = true
//
//    }
//
////    static func followees(for user: User, completion: @escaping ([User]) -> Void) {
////
////        let followeesRef = Database.database().reference().child("followers").child(user.uid)
////
////        // 2
////        followeesRef.observeSingleEvent(of: .value, with: { (snapshot) in
////            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
////                else { return completion([]) }
////        })
////    }
//
//    // Returns count of items in tableView
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.names.count;
//    }
//
//    //Assign values for tableView
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
//
//        cell.textLabel?.text = PopOverViewController.followers[indexPath.row] as? User
//        return cell
//    }
//
//    // Close PopUp
//    @IBAction func closePopup(_ sender: Any) {
//
//        dismiss(animated: true, completion: nil)
//    }
//}



