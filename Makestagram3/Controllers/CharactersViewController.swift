//
//  Characters.swift
//  Makestagram3
//
//  Created by Bella on 2/4/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

/// same with UITableViewCell's selected backgroundColor
//private let highlightedColor = UIColor(rgb: 0xD8D8D8)

class CharactersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let characters = ["Jaime Lannister", "Cersei Lannister", "Daenerys Targaryen",  "Jon Snow", "Sansa Stark", "Arya Stark", "Theon Greyjoy", "Bran Stark", "The Hound", "Tyrion Lannister", "Davos Seaworth", "Samwell Tarly", "Melisandre", "Bronn", "Varys", "Gendry", "Brienne of Tarth", "Gilly", "Daario Naharis", "Missandei", "Jaqen H'ghar", "Podrick Payne", "Yara Greyjoy", "Grey Worm", "Meera Reed", "Ghost", "none"]
    let characterImages = ["Jaime", "Cersei", "Danny",  "JonSnow", "Sansa", "Arya", "Theon", "Bran", "Hound", "Tyrion", "Davos", "Samwell", "Melisandre", "Bronn", "Varys", "Gendry", "Brienne", "Gilly", "Daario", "Missandei", "Jaqen", "Podrick", "Yara", "Greyworm", "Meera", "Ghost", "none"]
    
    var selectedIndex:Int?
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "throneCell", for: indexPath) as! CharacterViewCell
        let character = characters[indexPath.row]
//        cell.characterName.text = characters[indexPath.row]
        cell.characterImage.image = UIImage(named: characterImages[indexPath.row])
        
        if selectedIndex == indexPath.row {
            onBoardingService.pickCharacter(character: character)
            cell.contentView.layer.borderColor = UIColor.yellow.cgColor
            cell.contentView.layer.borderWidth = 2.0
            cell.backgroundColor =  UIColor.red
        }else{
            cell.backgroundColor = UIColor.clear
            onBoardingService.removeCharacter(character: character)
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

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
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

//extension UIColor {
//    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
//        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0xFF00) >> 8) / 255.0, blue: CGFloat(rgb & 0xFF) / 255.0, alpha: alpha)
//    }
//}
