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
        if numberTextField.text?.count ?? 0 == 10 {
            UserService.addNumber(childVal: numberTextField.text ?? "")
            
            self.dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "pickChar", sender: nil)
        }
    }
}
