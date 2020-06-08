//
//  InterestViewController.swift
//  FriendZone
//
//  Created by user162638 on 5/17/20.
//  Copyright © 2020 user162638. All rights reserved.
//

import UIKit
import Parse

class InterestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var noInterestsLabel: UILabel!
    @IBOutlet weak var newInterestTextField: UITextField!
    @IBOutlet weak var interestTableView: UITableView!
    
    var interestArray = [String]()
    
    var mode = Int()
    
    var selectedInterest = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interestTableView.dataSource = self
        interestTableView.delegate = self
        
        interestArray = PFUser.current()?["interests"] as! [String]
        interestTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("over here")
        if (interestArray.isEmpty) {
            noInterestsLabel.text = "You have not added any interests"
        }
        else {
            noInterestsLabel.text = ""
        }
        return interestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = interestArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        if (self.mode == 0) {
            let cell = interestTableView.cellForRow(at: indexPath)
            selectedInterest = cell?.textLabel?.text as! String
            performSegue(withIdentifier: "interestsToMatches", sender: interestTableView.cellForRow(at: indexPath))
        }
        interestTableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addInterest(_ sender: Any) {
        if ((newInterestTextField.text == nil) || (newInterestTextField.text == "")) {
            let alert = UIAlertController(title: "", message: "Type an interest to add", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else if (interestArray.contains(newInterestTextField.text!)) {
            let alert = UIAlertController(title: "", message: "Interest already in list", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else {
            interestArray.append(newInterestTextField.text!)
            PFUser.current()?["interests"] = interestArray
            PFUser.current()?.saveInBackground(block: { (success, error) in
                                
                if error != nil {
                                
                    var errorMessage = "Update failed - please try again"
                                    
                    let error = error as NSError?
                                    
                    if let parseError = error?.userInfo["error"] as? String {
                                        
                        errorMessage = parseError
                                        
                    }
                    self.interestArray.remove(at: self.interestArray.count - 1)
                    let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                                
                    print("Updated")
                    self.newInterestTextField.text = ""
                    self.interestTableView.reloadData()
                    let alert = UIAlertController(title: "Success", message: "Interests updated successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            })
        }
    }
    
    @IBAction func exitInterests(_ sender: Any) {
        self.performSegue(withIdentifier: "interestsToHome", sender: nil)
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func onLongPress(_ sender: Any) {
        print("long pressed")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "interestsToMatches") {
            let cell = sender as! UITableViewCell
            let matchesViewController = segue.destination as! MatchesViewController
            matchesViewController.givenSearchItem = selectedInterest
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
    
    // MARK: - UIContextMenuInteractionDelegate
}

/*extension InterestViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration
    }
}*/
