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
    
    var selectedRows: [Int] = []
    
//    weak var delegate: SendToFollowersCellDelegate?

    @IBOutlet weak var followerName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRows.append(indexPath.row)
    }
}
