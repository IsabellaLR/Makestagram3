//
//  FriendsListCell.swift
//  Makestagram3
//
//  Created by Bella on 4/19/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class FriendsListCell: UITableViewCell {
    
    var selectedRows: [Int] = []
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileButton: UIButton!
}
