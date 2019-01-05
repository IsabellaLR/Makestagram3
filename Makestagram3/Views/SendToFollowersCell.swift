//
//  SendToFollowersCell.swift
//  Makestagram3
//
//  Created by Bella on 12/30/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit

//protocol SendToFollowersCellDelegate: class {
//    func didTapFollowButton(_ sendButton: UIButton, on cell: SendToFollowersCell)
//}

class SendToFollowersCell: UITableViewCell {
    
//    weak var delegate: SendToFollowersCellDelegate?

    @IBOutlet weak var followerName: UILabel!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        selectionStyle = .none
//    }
    
//        followButton.layer.borderColor = UIColor.lightGray.cgColor
//        followButton.layer.borderWidth = 1
//        followButton.layer.cornerRadius = 6
//        followButton.clipsToBounds = true
//
//        followButton.setTitle("Follow", for: .normal)
//        followButton.setTitle("Following", for: .selected)
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    
    
//    @IBAction func followButtonTapped(_ sender: UIButton) {
//        delegate?.didTapFollowButton(sender, on: self)
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // update UI
        accessoryType = selected ? .checkmark : .none
    }
    
}
