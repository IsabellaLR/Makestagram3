//
//  FavoriteViewController.swift
//  Makestagram3
//
//  Created by Bella on 3/25/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

/// same with UITableViewCell's selected backgroundColor
//private let highlightedColor = UIColor(rgb: 0xD8D8D8)

class FavoriteViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let characters = ["Jaime Lannister", "Cersei Lannister", "Daenerys Targaryen",  "Jon Snow", "Sansa Stark", "Arya Stark", "Theon Greyjoy", "Bran Stark", "The Hound", "Tyrion Lannister", "Davos Seaworth", "Samwell Tarly", "Melisandre", "Bronn", "Varys", "Gendry", "Brienne of Tarth", "Gilly", "Daario Naharis", "Missandei", "Jaqen H'ghar", "Podrick Payne", "Yara Greyjoy", "Grey Worm", "Meera Reed", "Ghost", "Night King"]
    let characterImages = ["Jaime", "Cersei", "Danny",  "JonSnow", "Sansa", "Arya", "Theon", "Bran", "Hound", "Tyrion", "Davos", "Samwell", "Melisandre", "Bronn", "Varys", "Gendry", "Brienne", "Gilly", "Daario", "Missandei", "Jaqen", "Podrick", "Yara", "Greyworm", "Meera", "Ghost", "NightKing"]
    
    var selectedIndex:Int?
    var estimateWidth = 100.0
    var cellMarginSize = 10.0

    var completionHandler:((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        let initialViewController = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as! FavoriteViewCell
        let character = characters[indexPath.row]
        cell.characterImage.image = UIImage(named: characterImages[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = selectedIndex == indexPath.row ? nil : indexPath.row
        ProfileService.updateChild(child: "fav", childVal: characters[indexPath.item])
        self.dismiss(animated: true, completion: nil)
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
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

