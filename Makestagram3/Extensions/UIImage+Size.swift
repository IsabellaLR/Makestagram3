//
//  UIImage+Size.swift
//  Makestagram3
//
//  Created by Bella on 12/26/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit

extension UIImage {
    var aspectHeight: CGFloat {
        let heightRatio = size.height / 736
        let widthRatio = size.width / 414
        let aspectRatio = fmax(heightRatio, widthRatio)
        
        return size.height / aspectRatio
    }
}
