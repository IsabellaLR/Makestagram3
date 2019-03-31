//
//  MakeBetViewController.swift
//  Makestagram3
//
//  Created by Bella on 12/28/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit

class MakeBetViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var betTextField: UITextField!
    @IBOutlet weak var ptsLabel: UILabel!
    @IBOutlet weak var pickButton: UIButton!
    @IBOutlet weak var pickButton2: UIButton!
    @IBOutlet weak var emojiButton: UIButton!
    @IBOutlet weak var betTextView: UITextView!
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var surviveButton: UIButton!
    @IBOutlet weak var dieButton: UIButton!
    
    var betDescription: String?
    var points: String?
    var controller: String?
    var reward: String?
    
    var completionHandler:((String) -> ())?
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var betDescription: String = betTextField.text ?? ""
        
        episodeLabel.text = "Make a bet for \(name)"
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
//        betTextField.textAlignment = .left
//        betTextField.contentVerticalAlignment = .top
//        betTextField.
//        betTextField.sizeToFit()
        betTextView.layer.borderColor = UIColor.lightGray.cgColor
        betTextView.layer.borderWidth = 0.5
        surviveButton.layer.cornerRadius = 5
        surviveButton.layer.borderWidth = 1
        surviveButton.layer.borderColor = UIColor.lightGray.cgColor
        surviveButton.setTitle("  ?  ", for: .normal)
        
        dieButton.layer.cornerRadius = 5
        dieButton.layer.borderWidth = 1
        dieButton.layer.borderColor = UIColor.lightGray.cgColor
        dieButton.setTitle("  ?  ", for: .normal)
        
//        self.pickButton.setTitle(UserDefaults.standard.string(forKey: "character1") ?? "", for: .normal)
//        self.pickButton2.setTitle(UserDefaults.standard.string(forKey: "character2") ?? "", for: .normal)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showEmoji" {
//            if let vc = segue.destination as? EmojiViewController {
//                vc.completionHandler = { (text) -> ()in
//                    let image = UIImage(named: text)
//                    self.emojiButton.setTitle("", for: .normal)
//                    self.emojiButton.setImage(image, for: .normal)
//                }
//            }
//        }
    
//        guard let identifier = segue.identifier else { return }
//
//        switch identifier {
//        case "popover":
//            print("go to popover")
//
//        default:
//            print("Unexpected segue identifier")
//        }
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "surviveChar" {
            if let vc = segue.destination as? Characters2ViewController {
                vc.completionHandler = { (survChar) -> ()in
                    self.surviveButton.setTitle(survChar, for: .normal)
                    self.surviveButton.layer.borderColor = UIColor.clear.cgColor
                    UserDefaults.standard.set(survChar + " will survive", forKey: "betDescription")
                }
            }
        }
        if segue.identifier == "dieChar" {
            if let vc = segue.destination as? Characters2ViewController {
                vc.completionHandler = { (dieChar) -> ()in
                    self.dieButton.setTitle(dieChar, for: .normal)
                    self.dieButton.layer.borderColor = UIColor.clear.cgColor
                    UserDefaults.standard.set(dieChar + " will die", forKey: "betDescription")
                }
            }
        }
    }

    @IBAction func firstCheck(_ sender: Any) {
        if betTextView.text?.count ?? 0 > 3 && reward != "" && ptsLabel.text?.count ?? 0 > 0 {
            betDescription = betTextView.text
            UserDefaults.standard.set(betDescription, forKey: "betDescription")
            let rewPoints = (UserDefaults.standard.string(forKey: "points") ?? "")
            if Int(rewPoints) ?? 0 > 1 {
                UserDefaults.standard.set(rewPoints + " " + (reward ?? "shots") + "s", forKey: "rewardAndPoints")
            }else{
                UserDefaults.standard.set(rewPoints + " " + (reward ?? "shot"), forKey: "rewardAndPoints")
            }
            performSegue(withIdentifier: "sendTo", sender: nil)
        }
    }
    
    @IBAction func secondCheck(_ sender: Any) {
        if surviveButton.titleLabel?.text?.count ?? 0 > 2 && reward != "" && ptsLabel.text?.count ?? 0 > 0 {
            let rewPoints = (UserDefaults.standard.string(forKey: "points") ?? "")
            if Int(rewPoints) ?? 0 > 1 {
                UserDefaults.standard.set(rewPoints + " " + (reward ?? "shots") + "s", forKey: "rewardAndPoints")
            }else{
                UserDefaults.standard.set(rewPoints + " " + (reward ?? "shots"), forKey: "rewardAndPoints")
            }
            performSegue(withIdentifier: "sendTo", sender: nil)
        }
    }
    
    @IBAction func thirdCheck(_ sender: Any) {
        if dieButton.titleLabel?.text?.count ?? 0 > 2 && reward != "" && ptsLabel.text?.count ?? 0 > 0 {
            let rewPoints = (UserDefaults.standard.string(forKey: "points") ?? "")
            if Int(rewPoints) ?? 0 > 1 {
                UserDefaults.standard.set(rewPoints + " " + (reward ?? "shots") + "s", forKey: "rewardAndPoints")
            }else{
                UserDefaults.standard.set(rewPoints + " " + (reward ?? "shots"), forKey: "rewardAndPoints")
            }
            performSegue(withIdentifier: "sendTo", sender: nil)
        }
    }
    
    @IBAction func segmentedTapped(_ sender: Any) {
        let getIndex = segment.selectedSegmentIndex
        
        switch (getIndex) {
        case 0:
            reward = "shot"
        case 1:
            reward = "dollar"
        case 2:
            reward = "point"
        default:
            reward = "shot"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    @IBAction func btnSelect(_ sender: Any) {
//        betDescription = betTextField.text
//        UserDefaults.standard.set(betDescription, forKey: "betDescription")
//    }
    
//    @IBAction func selectChar1(_ sender: Any) {
//        controller = "1"
//        UserDefaults.standard.set(controller, forKey: "controller")
//    }
//
//    @IBAction func selectChar2(_ sender: Any) {
//        controller = "2"
//        UserDefaults.standard.set(controller, forKey: "controller")
//    }
//
//    @IBAction func emojiButtonTapped(_ sender: UIButton) {
//        let VC = storyboard?.instantiateViewController(withIdentifier: "EmojiController") as! EmojiViewController
//        VC.preferredContentSize = CGSize(width: 200, height: 100)
//        let navController = UINavigationController(rootViewController: VC)
//        navController.modalPresentationStyle = UIModalPresentationStyle.popover
//
//        let popOver = navController.popoverPresentationController
//        popOver?.permittedArrowDirections = .up
//        popOver?.sourceView = sender
//        popOver?.sourceRect = sender.bounds
//        popOver?.delegate = self
//
//        self.present(navController, animated: true, completion: nil)
//    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func changeStepperValue(_ sender: UIStepper) {
        sender.maximumValue = 10
        let pointVlaue = Int(sender.value).description
        self.ptsLabel.text = pointVlaue
        points = pointVlaue
        UserDefaults.standard.set(points, forKey: "points")
    }
}
