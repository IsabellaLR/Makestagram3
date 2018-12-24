//
//  CreateUsernameViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/23/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit

class CreateUsernameViewController: UIViewController {
    
    // MARK: - Subviews
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 6
    }
    
    // MARK: -IBActions
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // create new user in database
    }
}
