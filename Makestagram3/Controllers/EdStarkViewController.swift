//
//  EdStarkViewController.swift
//  Makestagram3
//
//  Created by Bella on 3/9/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class EdStarkViewController: UIViewController {
    
    @IBOutlet weak var edView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edView.layer.cornerRadius = 10
        edView.layer.masksToBounds = true
    }
    
    @IBAction func closeEd(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
