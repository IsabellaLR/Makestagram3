//
//  ReportViewController.swift
//  Makestagram3
//
//  Created by Bella on 4/3/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
    
//    @IBOutlet weak var view: UIView!
    @IBOutlet weak var reportUserTextField: UITextField!
    
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        super.viewDidLoad()
    }
    
    @IBAction func reportUser(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

