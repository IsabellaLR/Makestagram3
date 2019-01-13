//
//  MyProfile.swift
//  Makestagram3
//
//  Created by Bella on 1/9/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class MyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var myPointsLabel: UILabel!
    
    var profiles = [Profile]()
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        profileButton.frame = CGRect(x: 160, y: 130, width: 100, height: 100)
        profileButton.layer.cornerRadius = 0.5 * profileButton.bounds.size.width
        profileButton.clipsToBounds = true
//        profileButton.layer.borderWidth = 1
//        profileButton.layer.borderColor = UIColor.black.cgColor
//        self.applyRoundCorner(profileButton)
        
        ProfileService.show(user: User.current) { [unowned self] (profiles) in
            self.profiles = profiles
        }
        myPointsLabel.text = "hello"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    func applyRoundCorner(_ object: AnyObject) {
//        object.layer.cornerRadius = object.frame.size.width / 2
//        object.layer.masksToBounds = true
//    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if (UIImagePickerController.isSourceTypeAvailable(.camera))
        {
            let cameraAction = UIAlertAction(title: "Use Camera", style: .default) { (action) in
                
                let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                
                if (status == .authorized){
                    self.DisplayPicker(type: .camera)
                }
                if (status == .restricted){
                    self.HandleRestricted()
                }
                if (status == .denied){
                    self.HandleDenied()
                }
                if (status == .notDetermined){
                    AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                        if (granted){
                            self.DisplayPicker(type: .camera)
                        }
                    })
                }
            }
             alertController.addAction(cameraAction)
        }
        
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            let photoLibraryAction = UIAlertAction(title: "Use Photo Library", style: .default) { (action) in

                let status = PHPhotoLibrary.authorizationStatus()
                
                if (status == .authorized){
                    self.DisplayPicker(type: .photoLibrary)
                }
                if (status == .restricted){
                    self.HandleRestricted()
                }
                if (status == .denied){
                    self.HandleDenied()
                }
                if (status == .notDetermined){
                    PHPhotoLibrary.requestAuthorization({ (status) in
                        if (status == PHAuthorizationStatus.authorized){
                            self.DisplayPicker(type: .photoLibrary)
                        }
                    })
                }
            }
            alertController.addAction(photoLibraryAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = self.profileButton
        alertController.popoverPresentationController?.sourceRect = self.profileButton.bounds
        
        present(alertController, animated: true, completion: nil)
    }
    
    func HandleDenied(){
        let alertController = UIAlertController(title: "Media Access Denied", message: "CameraTutorial does not access to your device's media. Please update your settings", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Go to Settings", style: .default){ (action) in
            DispatchQueue.main.async {
                UIApplication.shared.open(NSURL(string: UIApplication.openSettingsURLString)! as URL)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.popoverPresentationController?.sourceView = self.profileButton
        alertController.popoverPresentationController?.sourceRect = self.profileButton.bounds
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func HandleRestricted(){
        let alertController = UIAlertController(title: "Media Access Denied", message: "This device is restricited from accessing any media at this time", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertController.popoverPresentationController?.sourceView = self.profileButton
        alertController.popoverPresentationController?.sourceRect = self.profileButton.bounds
        
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func DisplayPicker(type: UIImagePickerController.SourceType){
        self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: type)!
        self.imagePicker.sourceType = type
        self.imagePicker.allowsEditing = true
        
        DispatchQueue.main.async {
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        profileButton.imageView?.contentMode = .scaleAspectFill
        profileButton.setImage(chosenImage, for: .normal)

        dismiss(animated: true, completion: nil)
    }
}
