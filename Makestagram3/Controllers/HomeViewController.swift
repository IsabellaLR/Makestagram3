//
//  HomeViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/25/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var totalEpisodes = ["The Dungeon", "Cersei Dies", "3", "4", "5", "6", "7", "8",]
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? HomeTableViewCell
        cell?.homeLabel.text = totalEpisodes[indexPath.row]
//        cell?.homeImage.image = UIImage(named: totalEpisodes[indexPath.row])
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MakeBetViewController") as? MakeBetViewController
        vc?.name = totalEpisodes[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
