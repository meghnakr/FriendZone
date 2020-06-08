//
//  MatchesViewController.swift
//  FriendZone
//
//  Created by user162638 on 5/21/20.
//  Copyright © 2020 user162638. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class MatchesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchItemTextField: UITextField!
    @IBOutlet weak var noMatchesLabel: UILabel!
    @IBOutlet weak var matchesTableView: UITableView!
    
    var searchItem = String()
    var matchesArray = [PFUser]()
    var usersArray = [PFUser]()
    var userScores = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchesTableView.dataSource = self
        matchesTableView.delegate = self
        
        reloadScreen()
        
        /*let query = PFUser.query()
        
        query?.whereKey("username", notEqualTo: PFUser.current()?["username"]!)
        
        searchItem = searchItemTextField.text!
        
        if ((searchItem == "") || (searchItem == nil)) {
            query?.findObjectsInBackground(block: { (objects, error) in
                
                if let users = objects {
                    
                    
                    for object in users {
                     
                        
                        if let user = object as? PFUser {
                            print("username = \(user["username"] ?? "")")
                            self.usersArray.append(user)
                            let currentInterestsArray = PFUser.current()?["interests"] as! [String]
                            let eachInterestsArray = user["interests"] as! [String]
                            var score = 0
                            print("calculating score")
                            for interest in currentInterestsArray {
                                print("\(interest)")
                                if (eachInterestsArray.contains(interest)) {
                                    print("incrementing")
                                    score = score + 1
                                }
                            }
                            print("appending")
                            self.userScores.append(score)
                        }
                        print("after inner if")
                        
                    }
                    print("after users for")
                    
                }
                print("after outer if")
                
                print("before loop 1")
                var i = 0
                while (i < self.userScores.count - 1) {
                    var max = i
                    var j = i + 1
                    print("before inner loop")
                    while (j < self.userScores.count) {
                        if (self.userScores[j] > self.userScores[max]) {
                            max = j
                        }
                        j = j + 1
                    }
                    print("after inner loop")
                    let tempScore = self.userScores[i]
                    self.userScores[i] = self.userScores[max]
                    self.userScores[max] = tempScore
                    let tempUser = self.usersArray[i]
                    self.usersArray[i] = self.usersArray[max]
                    self.usersArray[max] = tempUser
                    i = i + 1
                }
                
                print("after loop 1")
                
                print("users: \(self.usersArray)")
                print("scores: \(self.userScores)")
                
                i = 0
                while (i < self.userScores.count) {
                    if (self.userScores[i] == 0) {
                        break
                    }
                    self.matchesArray.append(self.usersArray[i])
                    print("matched user = \(self.usersArray[i])")
                    i = i + 1
                }
                
                self.matchesTableView.reloadData()
            })
            print("after query")
        }*/
        /*print("before loop 1")
        var i = 0
        while (i < self.userScores.count - 1) {
            var max = self.userScores[i]
            var j = i + 1
            print("before inner loop")
            while (j < self.userScores.count) {
                if (self.userScores[j] > self.userScores[max]) {
                    max = j
                }
                j = j + 1
            }
            print("after inner loop")
            let tempScore = self.userScores[i]
            self.userScores[i] = self.userScores[max]
            self.userScores[max] = tempScore
            let tempUser = self.usersArray[i]
            self.usersArray[i] = self.usersArray[max]
            self.usersArray[max] = tempUser
            i = i + 1
        }
        
        print("after loop 1")
        
        print("users: \(usersArray)")
        print("scores: \(userScores)")
        
        i = 0
        while (i < self.userScores.count) {
            if (self.userScores[i] == 0) {
                break
            }
            self.matchesArray.append(self.usersArray[i])
            print("matched user = \(self.usersArray[i])")
            i = i + 1
        }
        
        matchesTableView.reloadData()*/
        // Do any additional setup after loading the view.
    }
    
    func reloadScreen() {
        
        matchesArray = []
        usersArray = []
        userScores = []
        
        let query = PFUser.query()
        
        query?.whereKey("username", notEqualTo: PFUser.current()?["username"]!)
        
        searchItem = searchItemTextField.text!
        
        if ((searchItem != "") && (searchItem != nil)) {
            query?.whereKey("interests", contains: searchItem)
        }
            query?.findObjectsInBackground(block: { (objects, error) in
                
                if let users = objects {
                    
                    
                    for object in users {
                     
                        
                        if let user = object as? PFUser {
                            print("username = \(user["username"] ?? "")")
                            self.usersArray.append(user)
                            let currentInterestsArray = PFUser.current()?["interests"] as! [String]
                            let eachInterestsArray = user["interests"] as! [String]
                            var score = 0
                            print("calculating score")
                            if ((self.searchItem != nil) &&
                                (self.searchItem != "") &&
                                (!currentInterestsArray.contains(self.searchItem))) {
                                score = score + 1
                            }
                            for interest in currentInterestsArray {
                                print("\(interest)")
                                if (eachInterestsArray.contains(interest)) {
                                    print("incrementing")
                                    score = score + 1
                                }
                            }
                            print("appending")
                            self.userScores.append(score)
                        }
                        print("after inner if")
                        
                    }
                    print("after users for")
                    
                }
                print("after outer if")
                
                print("before loop 1")
                var i = 0
                while (i < self.userScores.count - 1) {
                    var max = i
                    var j = i + 1
                    print("before inner loop")
                    while (j < self.userScores.count) {
                        if (self.userScores[j] > self.userScores[max]) {
                            max = j
                        }
                        j = j + 1
                    }
                    print("after inner loop")
                    let tempScore = self.userScores[i]
                    self.userScores[i] = self.userScores[max]
                    self.userScores[max] = tempScore
                    let tempUser = self.usersArray[i]
                    self.usersArray[i] = self.usersArray[max]
                    self.usersArray[max] = tempUser
                    i = i + 1
                }
                
                print("after loop 1")
                
                print("users: \(self.usersArray)")
                print("scores: \(self.userScores)")
                
                i = 0
                while (i < self.userScores.count) {
                    if (self.userScores[i] == 0) {
                        break
                    }
                    self.matchesArray.append(self.usersArray[i])
                    print("matched user = \(self.usersArray[i])")
                    i = i + 1
                }
                
                self.matchesTableView.reloadData()
            })
            print("after query")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if matchesArray.count != 0 {
            noMatchesLabel.text = ""
        }
        return matchesArray.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = matchesTableView.dequeueReusableCell(withIdentifier: "MatchCell") as! MatchCell
        
        //let cell = UITableViewCell()
        cell.nameLabel?.text = matchesArray[indexPath.row]["name"] as? String
        cell.usernameLabel?.text = matchesArray[indexPath.row].username
        cell.aboutLabel?.text = matchesArray[indexPath.row]["about"] as? String
        
        let imageFile = matchesArray[indexPath.row]["photo"] as! PFFileObject
        imageFile.getDataInBackground { (data, error) in
            if let imageData = data {
                let size = CGSize(width: 100, height: 100)
                let unscaledImage = UIImage(data: imageData)
                let scaledImage = unscaledImage?.af_imageAspectScaled(toFit: size)
                cell.profileImageView.image = scaledImage
            }
        }
        return cell
    }
    
    @IBAction func searchForInterest(_ sender: Any) {
        reloadScreen()
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
