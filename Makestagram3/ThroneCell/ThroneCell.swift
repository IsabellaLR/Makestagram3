//
//  ThroneCell.swift
//  Makestagram3
//
//  Created by Bella on 2/4/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class ThroneCell: UICollectionViewCell {
    
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    func setData(text: String, image: UIImage){
    func setData(text: String){
        self.characterLabel.text = text
//        self.characterImage.image = image
    }
    
}

