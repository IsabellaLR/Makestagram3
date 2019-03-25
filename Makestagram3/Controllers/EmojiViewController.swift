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
    //
    //    var shouldTintBackgroundWhenSelected = true // You can change default value
    //    var specialHighlightedArea: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "throneCell", for: indexPath) as! CharacterViewCell
    //
    //        selectedIndex = indexPath.row
    //        cell.backgroundColor = UIColor.clear
    //        collectionView.reloadData()
    //    }
}

extension EmojiViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = self.calculateWith()
        return CGSize(width: 40, height: 40)
    }

//    func calculateWith() -> CGFloat {
//        let estimatedWidth = CGFloat(estimateWidth)
//        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
//
//        let margin = CGFloat(cellMarginSize * 2)
//        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
//
//        return width
//    }
}
