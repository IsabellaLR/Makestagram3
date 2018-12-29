//
//  MakeBetViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/28/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit

class MakeBetViewController: UIViewController {

    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodeLabel.text = "Make a bet for \(name)"
        
        btnSelect.backgroundColor = .clear
        btnSelect.layer.cornerRadius = 5
        btnSelect.layer.borderWidth = 0.5
        btnSelect.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
