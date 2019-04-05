//
//  InstructionsViewController.swift
//  Makestagram3
//
//  Created by Bella on 4/5/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit
import Foundation

class InstructionsViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func tappedNext(_ sender: Any) {
        performSegue(withIdentifier: "askNumber", sender: nil)
    }
}
