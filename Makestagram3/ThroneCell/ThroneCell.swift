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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(text: String){
        self.characterLabel.text = text
    }
    
}

