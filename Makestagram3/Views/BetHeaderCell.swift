//
//  BetHeaderCell.swift
//  Makestagram3
//
//  Created by Bella on 1/2/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class BetHeaderCell: UITableViewCell {

    static let height: CGFloat = 30
    
    var tapAgreeAction: ((UITableViewCell) -> Void)?
    var tapDisagreeAction: ((UITableViewCell) -> Void)?
    var tappedColor = ""
    
    @IBOutlet weak var usernameHeaderLabel: UILabel!
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
    
    @IBAction func agreeButtonTapped(_ sender: Any) {
        tapAgreeAction?(self)
    }
    
    @IBAction func disagreeButtonTapped(_ sender: Any) {
        tapDisagreeAction?(self)
    }
}
