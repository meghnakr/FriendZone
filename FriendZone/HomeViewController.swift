//
//  HomeViewController.swift
//  FriendZone
//
//  Created by user162638 on 5/21/20.
//  Copyright © 2020 user162638. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if (segue.identifier == "homeToProfile") {
            let editProfileViewController = segue.destination as! EditProfileViewController
            editProfileViewController.nameTextField.text = PFUser.current()?["name"] as? String
            editProfileViewController.ageTextField.text = PFUser.current()?["age"] as? String
            editProfileViewController.aboutTextField.text = PFUser.current()?["about"] as? String
        }*/
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
