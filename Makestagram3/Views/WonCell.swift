//
//  WonCell.swift
//  Makestagram3
//
//  Created by Bella on 3/27/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit
import FirebaseDatabase

class WonCell: UITableViewCell {
    
    static let height: CGFloat = 30
    
    var tappedClaimAction: ((UITableViewCell) -> Void)?
    
    @IBOutlet weak var claimButton: UIButton!
    @IBOutlet weak var betDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func claimTapped(_ sender: Any) {
        tappedClaimAction?(self)
//        claimButton.setImage(UIImage(named: "greenCheck"), for: .normal)
    }
}
