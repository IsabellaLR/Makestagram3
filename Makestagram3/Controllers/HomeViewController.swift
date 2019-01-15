//
//  HomeViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/25/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var totalEpisodes = ["The Queen of Winterfell", "Fire and Ice", "Viserys", "The Last Debt", "The Wheel Has Broken", "End Game"]
    var episodeImages = ["ep1", "comingSoon", "comingSoon", "comingSoon", "comingSoon", "comingSoon"]
    var dates = ["January 15", "April 31", "May 7", "May 14", "May 21", "May 28"]
    var epAndDates = ["The Queen of Winterfell Arpril 24", "Fire and Ice April 31", "Viserys May 7", "The Last Debt May 14", "The Wheel Has Broken May 21", "End Game May 28"]
    var episodeName: String?
    var haveUser = false
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // today's date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM DD"
        let defaultTimeZoneStr = formatter.string(from: NSDate() as Date)
        
        for i in 0..<6 {
            if defaultTimeZoneStr == dates[i] {
                let premieurEp = totalEpisodes[i]
                UserDefaults.standard.set(premieurEp, forKey: "premieurEp")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? HomeTableViewCell
        cell?.homeEpisodeLabel.text = totalEpisodes[indexPath.row]
        cell?.homeImage.image = UIImage(named: episodeImages[indexPath.row])
        cell?.dateLabel.text = dates[indexPath.row]

        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MakeBetViewController") as? MakeBetViewController
        vc?.name = totalEpisodes[indexPath.row]
        episodeName = vc?.name
        UserDefaults.standard.set(episodeName, forKey: "episodeName")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
