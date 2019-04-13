//
//  HouseViewController.swift
//  Makestagram3
//
//  Created by Bella on 4/13/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class HouseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let houseImages = ["Lannister", "houseTarg", "houseStark", "tyrell"]
    
    var selectedIndex:Int?
    var estimateWidth = 100.0
    var cellMarginSize = 1.0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.houseImages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "houseCell", for: indexPath) as! HouseViewCell
        
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
        
        cell.houseImage.image = UIImage(named: houseImages[indexPath.row])
        
        return cell
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = selectedIndex == indexPath.row ? nil : indexPath.row
        ProfileService.updateChild(child: "house", childVal: houseImages[indexPath.item])
        self.dismiss(animated: true, completion: nil)
    }
}

extension HouseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 150
        let height = 150
        return CGSize(width: width, height: width)
    }
}
