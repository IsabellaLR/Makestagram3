//
//  NumberViewController.swift
//  Makestagram3
//
//  Created by Bella on 3/27/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit
import Foundation

class NumberViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func tappedNext(_ sender: Any) {
        if numberTextField.text?.count ?? 0 == 10 && numberTextField.text != "e.g 4155156226" {
            UserService.addChild(child: "phoneNumber", childVal: numberTextField.text ?? "")
//            let initialViewController = UIStoryboard.initialViewController(for: .main)
//            self.view.window?.rootViewController = initialViewController
//            self.view.window?.makeKeyAndVisible()
            performSegue(withIdentifier: "pickChar", sender: nil)
//            self.dismiss(animated: true, completion: nil)
        }
    }
}
