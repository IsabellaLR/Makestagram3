//
//  CreateUsernameViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/23/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    
    // MARK: - Subviews
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 6
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: -IBActions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else { return }
            
            User.setCurrent(user, writeToUserDefaults: true)
            
            ProfileService.create(username: User.current.uid, posValue: 0, negValue: 0, wins: 0, losses: 0)
            
            self.performSegue(withIdentifier: "Characters", sender: self)
            
//            let initialViewController = UIStoryboard.initialViewController(for: .onBoarding)
//            self.view.window?.rootViewController = initialViewController
//            self.view.window?.makeKeyAndVisible()
        }
    }
}
