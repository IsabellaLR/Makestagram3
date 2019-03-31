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
    var datesAndYear = ["2019-03-14", "2019-03-21", "2019-03-28", "2019-05-05", "2019-05-12", "2019-05-19"]
    var dates = ["April 14", "April 21", "April 28", "May 5", "May 12", "May 19"]
    var epAndDates = ["The Queen of Winterfell Arpril 24", "Fire and Ice April 30", "Viserys May 7", "The Last Debt May 14", "The Wheel Has Broken May 21", "End Game May 28"]
    var episodeName: String?
    var profile2: Profile?
    var premieurIndex: Int?
    var premieurEps = [String]()
//    var premieurEps = [String]()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkDates()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func checkDates() -> ([String]) {
        // today's date
        let currentDateTime = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for i in 0..<6 {
            let date = dateFormatter.date(from: datesAndYear[i])
            if (currentDateTime >= date!) {
                let premieurEp = totalEpisodes[i]
                self.premieurIndex = i
                premieurEps.append(premieurEp)
                UserDefaults.standard.set(premieurEp, forKey: "premieurEp")
            }
        }
        return premieurEps
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
