//
//  ShipViewCell.swift
//  Makestagram3
//
//  Created by Bella on 3/25/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class ShipViewCell: UICollectionViewCell {
    
    struct GlobalVariable{
        static var shipName: String = "What is your favorite ship?"
    }
    
    @IBOutlet weak var shipImage: UIImageView!
}
