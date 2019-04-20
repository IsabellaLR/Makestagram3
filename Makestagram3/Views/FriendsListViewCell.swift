//
//  FriendsListViewCell.swift
//  Makestagram3
//
//  Created by Bella on 4/19/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class FriendsListViewCell: UITableViewCell {
    
    var selectedRows: [Int] = []
    
    //    weak var delegate: SendToFollowersCellDelegate?
    
    @IBOutlet weak var username: UILabel!
    
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
