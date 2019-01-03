//
//  ShowBetCell.swift
//  Makestagram3
//
//  Created by Bella on 1/2/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class ShowBetCell: UITableViewCell {
    
    
    static let height: CGFloat = 100

    // label outlet (not working atm)
    @IBOutlet weak var betDescription: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var disagreeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
