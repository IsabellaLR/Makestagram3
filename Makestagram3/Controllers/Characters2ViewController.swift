//
//  Characters2ViewController.swift
//  Makestagram3
//
//  Created by Bella on 2/16/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class Characters2ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let characters = ["Jaime", "Cersei", "Danny",  "JonSnow", "Sansa", "Arya", "Theon", "Bran", "Hound", "Tyrion", "Davos", "Samwell", "Melisandre", "Bronn", "Varys", "Gendry", "Brienne", "Gilly", "Daario", "Missandei", "Jaqen", "Podrick", "Yara", "Greyworm", "Meera", "Ghost", "Night King"]
    let characterImages = ["Jaime", "Cersei", "Danny",  "JonSnow", "Sansa", "Arya", "Theon", "Bran", "Hound", "Tyrion", "Davos", "Samwell", "Melisandre", "Bronn", "Varys", "Gendry", "Brienne", "Gilly", "Daario", "Missandei", "Jaqen", "Podrick", "Yara", "Greyworm", "Meera", "Ghost", "NightKing"]
    
    var selectedIndex: Int?
    var estimateWidth = 100.0
    var cellMarginSize = 10.0

    var completionHandler:((String) -> ())?
    
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "charCell", for: indexPath) as! Character2ViewCell
        let character = characters[indexPath.row]

        cell.characterImage.image = UIImage(named: characterImages[indexPath.row])
        
        if selectedIndex == indexPath.row {
            cell.contentView.layer.borderColor = UIColor.yellow.cgColor
            cell.contentView.layer.borderWidth = 2.0
        }else{
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.borderWidth = 1.0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = selectedIndex == indexPath.row ? nil : indexPath.row
        let result = completionHandler?(characters[indexPath.item])
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }
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
