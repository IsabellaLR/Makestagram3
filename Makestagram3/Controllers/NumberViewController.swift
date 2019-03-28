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
    
    
    @IBAction func tappedNext(_ sender: Any) {
        if numberTextField.text?.count ?? 0 >= 10 {
            UserService.addNumber(childVal: numberTextField.text ?? "")
            performSegue(withIdentifier: "pickChar", sender: nil)
        }
    }
}
