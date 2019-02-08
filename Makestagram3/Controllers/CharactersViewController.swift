//
//  Characters.swift
//  Makestagram3
//
//  Created by Bella on 2/4/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import Foundation
import UIKit

class CharactersViewController: UIViewController {
    
    //UI for CollectionView
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    var characters = ["Jaime Lannister", "Cersei Lannister", "Daenerys Targaryen",  "Jon Snow", "Sansa Stark", "Arya Stark", "Theon Greyjoy", "Bran Stark", "The Hound", "Tyrion Lannister", "Davos Seaworth", "Samwell Tarly", "Melisandre", "Bronn", "Varys", "Gendry", "Brienne of Tarth", "Gilly", "Daario Naharis", "Missandei", "Jaqen H'ghar", "Podrick Payne", "Yara Greyjoy", "Grey Worm", "Meera Reed", "Ghost"]
    var characterImages = ["ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1", "ep1"]
    
    var estimateWidth = 160.0
    var cellMarginSize = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigationTitle.title = topic.topicType
        
        // Set Delegates
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.allowsMultipleSelection = true
        
        // Register cells
        self.collectionView.register(UINib(nibName: "ThroneCell", bundle: nil), forCellWithReuseIdentifier: "ThroneCell")
        
        // SetupGrid view
        self.setupGridView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupGridView()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setupGridView() {
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
}

extension CharactersViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThroneCell", for: indexPath) as! ThroneCell
        cell.setData(text: self.characters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThroneCell", for: indexPath) as! ThroneCell
        let character = characters[indexPath.row]
        
        onBoardingService.pickCharacter(character: character)
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.gray.cgColor
//        self.collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThroneCell", for: indexPath) as! ThroneCell
        let character = characters[indexPath.row]
        
        onBoardingService.removeCharacter(character: character)
        cell.layer.borderWidth = 5.0
        cell.layer.borderColor = UIColor.red.cgColor
//        self.collectionView.reloadItems(at: [indexPath])
    }
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
