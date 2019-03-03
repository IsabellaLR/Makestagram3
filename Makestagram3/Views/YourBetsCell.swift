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
    
    var tapAgreeAction: ((UITableViewCell) -> Void)?
    var tapDisagreeAction: ((UITableViewCell) -> Void)?
    var tapClaimWinAction: ((UITableViewCell) -> Void)?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameHeaderLabel: UILabel!
    @IBOutlet weak var betDescription: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var disagreeButton: UIButton!
    @IBOutlet weak var agreeImage: UIImageView!
    @IBOutlet weak var disagreeImage: UIImageView!
    @IBOutlet weak var showPointsLabel: UILabel!
    @IBOutlet weak var showEpisodeLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var whoWonLabel: UILabel!
    @IBOutlet weak var claimWin: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func agreeButtonTapped(_ sender: Any) {
        agreeImage.isUserInteractionEnabled = true
        tapAgreeAction?(self)
    }
    
    @IBAction func disagreeButtonTapped(_ sender: Any) {
        disagreeImage.isUserInteractionEnabled = true
        tapDisagreeAction?(self)
    }
    
    @IBAction func claimWinTapped(_ sender: Any) {
        tapClaimWinAction?(self)
    }
}
