//
//  LoginViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/22/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("login button tapped")
    }
}
