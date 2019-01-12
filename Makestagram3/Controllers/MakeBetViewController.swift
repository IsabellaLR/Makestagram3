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
    @IBOutlet weak var betTextField: UITextField!
    @IBOutlet weak var ptsLabel: UILabel!
    
    var betDescription: String?
    var points: String?
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var betDescription: String = betTextField.text ?? ""
        
        episodeLabel.text = "Make a bet for \(name)"
        
        btnSelect.backgroundColor = .clear
        btnSelect.layer.cornerRadius = 5
        btnSelect.layer.borderWidth = 0.5
        btnSelect.layer.borderColor = UIColor.lightGray.cgColor
        betTextField.textAlignment = .left
        betTextField.contentVerticalAlignment = .top
        
//        btnSelect(_ sender: Any)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnSelect(_ sender: Any) {
        betDescription = betTextField.text
        UserDefaults.standard.set(betDescription, forKey: "betDescription")
    }
    
    
    @IBAction func changeStepperValue(_ sender: UIStepper) {
        let pointVlaue = Int(sender.value).description + " pts"
        self.ptsLabel.text = pointVlaue
        points = pointVlaue
        UserDefaults.standard.set(points, forKey: "points")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {
        case "popover":
            print("go to popover")
            
        default:
            print("Unexpected segue identifier")
        }
    }
}
