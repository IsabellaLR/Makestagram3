//
//  DebtBetsCell.swift
//  Makestagram3
//
//  Created by Bella on 3/3/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class DebtBetsCell: UITableViewCell {
    
    static let height: CGFloat = 30

    @IBOutlet weak var betDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
