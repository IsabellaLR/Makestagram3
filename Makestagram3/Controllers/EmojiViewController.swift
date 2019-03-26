//
//  EmojiViewController.swift
//  Makestagram3
//
//  Created by Bella on 2/17/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class EmojiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let emojiImages = ["GOT-baby", "GOT-betray", "GOT-breakup", "GOT-destroy", "GOT-duel", "GOT-fallinlove", "GOT-greenstuff", "GOT-iced", "GOT-injured", "GOT-marry", "GOT-outrank", "GOT-slay", "GOT-sleep", "GOT-suicide"]
    
    var selectedIndex: Int?
    var estimateWidth = 100.0
    var cellMarginSize = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.emojiImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiCell", for: indexPath) as! EmojiViewCell
        let emoji = emojiImages[indexPath.row]
        cell.emojiImage.image = UIImage(named: emojiImages[indexPath.row])
        
        if selectedIndex == indexPath.row {
            cell.backgroundColor =  UIColor.red
            self.dismiss(animated: true, completion: nil)
            UserDefaults.standard.set(emoji, forKey: "emojiPicked")
        }else{
            cell.backgroundColor = UIColor.clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = selectedIndex == indexPath.row ? nil : indexPath.row
        collectionView.reloadData()
    }
}

extension EmojiViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
}
