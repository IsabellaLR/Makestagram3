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
    var datesAndYear = ["2019-01-14", "2019-04-30", "2019-05-7", "2019-05-14", "2019-05-21", "2019-05-28"]
    var dates = ["January 14", "April 30", "May 7", "May 14", "May 21", "May 28"]
    var epAndDates = ["The Queen of Winterfell Arpril 24", "Fire and Ice April 30", "Viserys May 7", "The Last Debt May 14", "The Wheel Has Broken May 21", "End Game May 28"]
    var episodeName: String?
    var profile2: Profile?
    var premieurIndex: Int?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // today's date
        let currentDateTime = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var premieurEps = [String]()
        for i in 0..<6 {
            let date = dateFormatter.date(from: datesAndYear[i])
            if (currentDateTime >= date!) {
                let premieurEp = totalEpisodes[i]
                self.premieurIndex = i
                premieurEps.append(premieurEp)
                UserDefaults.standard.set(premieurEp, forKey: "premieurEp")
            }
        }
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
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
        
        cell?.isUserInteractionEnabled = true
        cell?.contentView.alpha = 1.0
        
        if premieurIndex != nil {
            if (indexPath.row <= premieurIndex!) {
                cell?.isUserInteractionEnabled = false
                cell?.contentView.alpha = 0.5
            }
        }
        
        cell?.homeEpisodeLabel.text = totalEpisodes[indexPath.row]
        cell?.homeImage.image = UIImage(named: episodeImages[indexPath.row])
        cell?.dateLabel.text = dates[indexPath.row]

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if premieurIndex != nil {
//            if (indexPath.row <= premieurIndex!) {
//                return nil
//            }
//        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MakeBetViewController") as? MakeBetViewController
        vc?.name = totalEpisodes[indexPath.row]
        episodeName = vc?.name
        UserDefaults.standard.set(episodeName, forKey: "episodeName")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
