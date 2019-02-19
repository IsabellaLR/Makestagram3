//
//  Characters2ViewController.swift
//  Makestagram3
//
//  Created by Bella on 2/16/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class Characters2ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let characters = ["Jaime", "Cersei", "Danny",  "JonSnow", "Sansa", "Arya", "Theon", "Bran", "Hound", "Tyrion", "Davos", "Samwell", "Melisandre", "Bronn", "Varys", "Gendry", "Brienne", "Gilly", "Daario", "Missandei", "Jaqen", "Podrick", "Yara", "Greyworm", "Meera", "Ghost"]
    let characterImages = ["Jaime", "Cersei", "Danny",  "JonSnow", "Sansa", "Arya", "Theon", "Bran", "Hound", "Tyrion", "Davos", "Samwell", "Melisandre", "Bronn", "Varys", "Gendry", "Brienne", "Gilly", "Daario", "Missandei", "Jaqen", "Podrick", "Yara", "Greyworm", "Meera", "Ghost"]
    
    var selectedIndex:Int?
    var estimateWidth = 125.0
    var cellMarginSize = 5.0
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
        return self.characters.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "throneCell", for: indexPath) as! Character2ViewCell
        let character = characters[indexPath.row]
        cell.characterName.text = characters[indexPath.row]
        cell.characterImage.image = UIImage(named: characterImages[indexPath.row])
        cell.characterImage.frame = CGRect(x: 0, y: 0, width: 125, height: 125)
        
        if selectedIndex == indexPath.row {
            cell.backgroundColor =  UIColor.red
            self.dismiss(animated: true, completion: nil)
            UserDefaults.standard.set(character, forKey: "characterPicked")
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

extension Characters2ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: width)
    }
    
    func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
}
