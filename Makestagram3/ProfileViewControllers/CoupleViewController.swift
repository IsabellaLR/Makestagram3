//
//  CoupleViewController.swift
//  Makestagram3
//
//  Created by Bella on 3/25/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class CoupleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let characterImages = ["couple1", "couple2", "couple3",  "couple4", "couple5", "couple6", "couple7", "couple8", "couple9", "couple10",
                           "couple11", "couple12"]
    let coupleNames = ["Jon + Ygritte", "Cersei + Jaimie", "Eddard + Catelyn", "Rob + Talisa", "Danny + Drago", "Margery + Joffrey", "Ramsay and Myranda", "Mrycella + Tristane", "Margery + Tomen", "Renly + Loras", "Tyrion + Shae", "Ellaria + Oberyn"]
    
    var selectedIndex:Int?
    var estimateWidth = 100.0
    var cellMarginSize = 1.0
    
    var completionHandler:((String) -> ())?
    
    
    
    //
    //    var shouldTintBackgroundWhenSelected = true // You can change default value
    //    var specialHighlightedArea: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characterImages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shipCell", for: indexPath) as! ShipViewCell
        
        //cornered cells
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        //        cell.contentView.layer.borderWidth = 1.0
        
        cell.shipImage.image = UIImage(named: characterImages[indexPath.row])
        
        //        if selectedIndex == indexPath.row {
        ////            cell.contentView.layer.borderColor = UIColor.yellow.cgColor
        //            cell.contentView.layer.borderWidth = 2.0
        //            let result = completionHandler?(shipNames[selectedIndex!])
        //
        //            self.dismiss(animated: true, completion: nil)
        //
        //        }else{
        //            cell.contentView.layer.borderColor = UIColor.clear.cgColor
        //            cell.contentView.layer.borderWidth = 1.0
        //        }
        
        return cell
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = selectedIndex == indexPath.row ? nil : indexPath.row
        let result = completionHandler?(shipNames[indexPath.item])
        self.dismiss(animated: true, completion: nil)
    }
}

extension ShipViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 150
        let height = 150
        return CGSize(width: width, height: width)
    }
}
