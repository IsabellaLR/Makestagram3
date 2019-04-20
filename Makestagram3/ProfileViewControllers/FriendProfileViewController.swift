//
//  FriendProfileViewController.swift
//  Makestagram3
//
//  Created by Bella on 4/19/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import FirebaseStorage
import FirebaseAuth
import Kingfisher

class FriendProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var name = ""
    
    @IBOutlet weak var coupleButton: UIButton!
    @IBOutlet weak var shipButton: UIButton!
    @IBOutlet weak var favCharButton: UIButton!
    @IBOutlet weak var houseButton: UIButton!
    
    @IBOutlet weak var coupleLabel: UILabel!
    @IBOutlet weak var shipLabel: UILabel!
    @IBOutlet weak var favCharLabel: UILabel!
    @IBOutlet weak var throneCharLabel: UILabel!
    
    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    
    var profile2: Profile?
    var setImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileButton.layer.cornerRadius = 0.5 * profileButton.bounds.size.width
        profileButton.clipsToBounds = true
        
        name = (UserDefaults.standard.string(forKey: "username") ?? "")
        
        ProfileService.showOtherUser(user: name) { [weak self] (profile2) in
            //                if  (self!.show == true){
            self?.profile2 = profile2
            
            //display profile image and remove ninja default image
            if let imageURL = URL(string: (profile2?.imageURL ?? "")) {
                if self?.setImage == false {
                    DispatchQueue.main.async {
                        self?.profileButton.setImage(nil, for: .normal)
                        self?.profileButton.kf.setBackgroundImage(with: imageURL, for: .normal)
                        self?.profileButton.layer.borderWidth = 0.5
                        self?.profileButton.layer.borderColor = UIColor.lightGray.cgColor
                    }
                }
            }else{
                let image = UIImage(named: "ninja")
                self?.profileButton.setImage(image, for: .normal)
            }
            
            if let house = profile2?.house {
                DispatchQueue.main.async {
                    self?.houseImage.image = UIImage(named: house)
                }
            }
            
            if let couple = profile2?.couple {
                DispatchQueue.main.async {
                    self?.coupleLabel.text = "Best couple: " + couple
                }
            }
            
            if let ship = profile2?.ship {
                DispatchQueue.main.async {
                    self?.shipLabel.text = "Cutest ship: " + ship
                }
            }
            
            if let fav = profile2?.fav {
                DispatchQueue.main.async {
                    self?.favCharLabel.text = "Fav character: " + fav
                }
            }
            
            if let throneChar = profile2?.throneChar {
                DispatchQueue.main.async {
                    self?.throneCharLabel.text = throneChar
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
