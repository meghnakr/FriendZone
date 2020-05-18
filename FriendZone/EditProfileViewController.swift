//
//  EditProfileViewController.swift
//  FriendZone
//
//  Created by user162638 on 5/16/20.
//  Copyright © 2020 user162638. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var aboutTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageFile = PFUser.current()?["photo"] as! PFFileObject
        imageFile.getDataInBackground { (data, error) in
            if let imageData = data {
                self.profileImageView.image = UIImage(data: imageData)
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func changeProfilePicture(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
        /*@IBAction func updateProfileImage(_ sender: Any) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            if let image = info[UIImagePickerControllerOriginalImage] as! UIImage? {
                userImage.image = image
            }
            
            self.dismiss(animated: true, completion: nil)
        }*/
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage? {
            profileImageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveData(_ sender: Any) {
        if ((nameTextField.text == nil) || (nameTextField.text == "")) {
            let alert = UIAlertController(title: "Error", message: "Please Enter a Name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else {
            let name = nameTextField.text
            
            var age = ""
            if ((ageTextField.text == nil) || (ageTextField.text == "")) {
                age = "Not provided"
            }
            else {
                age = ageTextField.text!
            }
            
            var about = ""
            if ((aboutTextField.text == nil) || (ageTextField.text == "")) {
                about = "Not provided"
            }
            else {
                about = aboutTextField.text
            }
            
            let imageData = profileImageView.image!.jpegData(compressionQuality: 0.1)
            PFUser.current()?["photo"] = PFFileObject(name: "profile.png", data: imageData!)
            
            PFUser.current()?["name"] = name
            PFUser.current()?["age"] = age
            PFUser.current()?["about"] = about
            PFUser.current()?["interests"] = []
            
            PFUser.current()?.saveInBackground(block: { (success, error) in
                                
                if error != nil {
                                
                    var errorMessage = "Update failed - please try again"
                                    
                    let error = error as NSError?
                                    
                    if let parseError = error?.userInfo["error"] as? String {
                                        
                        errorMessage = parseError
                                        
                    }
            
                    let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                                    
                } else {
                                
                    print("Updated")
                    let alert = UIAlertController(title: "Success", message: "Profile updated successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        self.performSegue(withIdentifier: "profileToInterests", sender: nil)
                    }))
                    self.present(alert, animated: true)
                }
                                
            })
            
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "profileToInterests") {
            let interestViewController = segue.destination as! InterestViewController
            interestViewController.mode = 1
        }
    }
    
    /*
    // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
