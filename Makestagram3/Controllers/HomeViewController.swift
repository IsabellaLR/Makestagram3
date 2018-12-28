//
//  HomeViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/25/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    @IBOutlet var tableView: UITableView!
    var totalEpisodes = ["1", "2", "3", "4", "5", "6", "7", "8",]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
//
//        UserService.posts(for: User.current) { (posts) in
//            self.posts = posts
//            self.tableView.reloadData()
//        }
//    }
//
//    var posts = [Post]()
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        
        let episode = totalEpisodes[indexPath.row]
        
        return cell
    }
        
//        cell.topicLabel.text = bigTopic
//        cell.topicLabel.font = UIFont(name: "Courier-Bold", size: 24)
//        cell.topicLabel.addCharacterSpacing(kernValue: 2)
        
//        switch indexPath.row {
//        case 0:
//            cell.backgroundColor = hexStringToUIColor(hex: "#FFA557")
//            cell.tintColor = hexStringToUIColor(hex: "#FFA557")
//        case 1:
//            cell.backgroundColor = hexStringToUIColor(hex: "#FF648D")
//            cell.iconImage.image = #imageLiteral(resourceName: "Career")
//            cell.tintColor = hexStringToUIColor(hex: "#FF648D")
//        case 2:
//            cell.backgroundColor = hexStringToUIColor(hex: "#AEE880")
//            cell.iconImage.image = #imageLiteral(resourceName: "Music")
//            cell.backgroundColor = hexStringToUIColor(hex: "#AEE880")
//        case 3:
//            cell.backgroundColor = hexStringToUIColor(hex: "#58D9E8")
//            cell.iconImage.image = #imageLiteral(resourceName: "School")
//            cell.tintColor = hexStringToUIColor(hex: "#58D9E8")
//        case 4:
//            cell.backgroundColor = hexStringToUIColor(hex: "#39ABFF")
//            cell.iconImage.image = #imageLiteral(resourceName: "Hobbies")
//            cell.tintColor = hexStringToUIColor(hex: "#39ABFF")
//            //        case 5:
//            //            cell.backgroundColor = UIColor.blue
//        //            cell.iconImage = Religion
//        default:
//            cell.backgroundColor = UIColor.blue
//        }
        
//        //        cell.accessoryType = .disclosureIndicator
//
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalEpisodes.count
    }
}

//extension HomeViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return posts.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath)
//        cell.backgroundColor = .red
//
//        return cell
//    }
//
//}
