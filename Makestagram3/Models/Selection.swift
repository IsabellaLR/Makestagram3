//
//  Selection.swift
//  Makestagram3
//
//  Created by Bella on 1/2/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import Foundation
import UIKit

struct Selection {
    var title: String
}

class ViewSelectionItem {
    private var item: Selection
    
    var isSelected = false
    var title: String {
        return item.title
    }
    
    init(item: Selection) {
        self.item = item
    }
}
