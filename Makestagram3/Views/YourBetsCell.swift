//
//  YourBetsCell.swift
//  Makestagram3
//
//  Created by Bella on 3/2/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class YourBetsCell: UITableViewCell {
    
    static let height: CGFloat = 30
    
    var tappedWonAction: ((UITableViewCell) -> Void)?
    var tappedLossAction: ((UITableViewCell) -> Void)?
    var tappedTieAction: ((UITableViewCell) -> Void)?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameHeaderLabel: UILabel!
    @IBOutlet weak var betDescription: UILabel!
    @IBOutlet weak var showPointsLabel: UILabel!
    @IBOutlet weak var showEpisodeLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var whoWonLabel: UILabel!
    
    @IBOutlet weak var wonButton: UIButton!
    @IBOutlet weak var lossButton: UIButton!
    @IBOutlet weak var tieButton: UIButton!
    @IBOutlet weak var outcomeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func wonTapped(_ sender: Any) {
        tappedWonAction?(self)
    }
    
    @IBAction func lossTapped(_ sender: Any) {
        tappedLossAction?(self)
    }
    
    @IBAction func tieTapped(_ sender: Any) {
        tappedTieAction?(self)
    }
}
