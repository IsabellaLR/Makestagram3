//
//  MakeBetViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/28/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit

class MakeBetViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var betTextField: UITextField!
    @IBOutlet weak var ptsLabel: UILabel!
    @IBOutlet weak var pickButton: UIButton!
    @IBOutlet weak var pickButton2: UIButton!
    @IBOutlet weak var emojiButton: UIButton!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    var betDescription: String?
    var points: String?
    var controller: String?
    var reward: String?
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var betDescription: String = betTextField.text ?? ""
        
        episodeLabel.text = "Make a bet for \(name)"
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        betTextField.textAlignment = .left
        betTextField.contentVerticalAlignment = .top
        
        self.pickButton.setTitle(UserDefaults.standard.string(forKey: "character1") ?? "", for: .normal)
        self.pickButton2.setTitle(UserDefaults.standard.string(forKey: "character2") ?? "", for: .normal)
    }

    
    @IBAction func segmentedTapped(_ sender: Any) {
        let getIndex = segment.selectedSegmentIndex
        
        switch (getIndex) {
        case 0:
            reward = "shots"
        case 1:
            reward = "dollars"
        case 2:
            reward = "points"
        default:
            reward = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnSelect(_ sender: Any) {
        betDescription = betTextField.text
        UserDefaults.standard.set(betDescription, forKey: "betDescription")
    }
    
    @IBAction func selectChar1(_ sender: Any) {
        controller = "1"
        UserDefaults.standard.set(controller, forKey: "controller")
    }
    
    @IBAction func selectChar2(_ sender: Any) {
        controller = "2"
        UserDefaults.standard.set(controller, forKey: "controller")
    }
    
    @IBAction func emojiButtonTapped(_ sender: UIButton) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "EmojiController") as! EmojiViewController
        VC.preferredContentSize = CGSize(width: 200, height: 100)
        let navController = UINavigationController(rootViewController: VC)
        navController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        let popOver = navController.popoverPresentationController
        popOver?.permittedArrowDirections = .up
        popOver?.sourceView = sender
        popOver?.sourceRect = sender.bounds
        popOver?.delegate = self
        
        self.present(navController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
    @IBAction func changeStepperValue(_ sender: UIStepper) {
        let pointVlaue = Int(sender.value).description
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
