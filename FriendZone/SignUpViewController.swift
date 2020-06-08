//
//  SignUpViewController.swift
//  FriendZone
//
//  Created by user162638 on 5/16/20.
//  Copyright © 2020 user162638. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onSignUp(_ sender: Any) {
        let domainCheck = emailTextField.text?.hasSuffix("@purdue.edu") ?? false
        if domainCheck {
            var user = PFUser()
            user.email = emailTextField.text!
            user.username = usernameTextField.text!
            user.password = passwordTextField.text!
            user.signUpInBackground { (suceeded, error) in
                if error != nil {
                    if ((self.usernameTextField.text == nil) || (self.usernameTextField.text == "")) {
                        let alert = UIAlertController(title: "Error", message: "Please Enter a Username!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    else if ((self.passwordTextField.text == nil) || (self.passwordTextField.text == "")) {
                        let alert = UIAlertController(title: "Error", message: "Please Enter a Password", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    else {
                        let alert = UIAlertController(title: "Error", message: "Username Already Exists!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
                else {
                    let defaultImage : UIImage = UIImage(named: "blank-profile-picture-973460_640")!
                    let imageData = defaultImage.jpegData(compressionQuality: 0.1)
                    PFUser.current()?["photo"] = PFFileObject(name: "profile.png", data: imageData!)
                    
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
                                let alert = UIAlertController(title: "Error", message: "Profile updated successfully", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alert, animated: true)
                            }
                                
                        })
                    self.performSegue(withIdentifier: "signUpToProfile", sender: nil)
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Please Use a Purdue Email!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        /*let index = emailTextField.text?.firstIndex(of: "@") ?? emailTextField.text?.endIndex
        if (index == emailTextField.text?.endIndex) {
            let alert = UIAlertController(title: "Error", message: "Invalid Email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else {
            
        }*/
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "signUpToProfile") {
            let editProfileViewController = segue.destination as! EditProfileViewController
            editProfileViewController.mode = 1
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
