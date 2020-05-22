//
//  MatchesViewController.swift
//  FriendZone
//
//  Created by user162638 on 5/21/20.
//  Copyright © 2020 user162638. All rights reserved.
//

import UIKit
import Parse

class MatchesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchItemTextField: UITextField!
    @IBOutlet weak var noMatchesLabel: UILabel!
    @IBOutlet weak var matchesTableView: UITableView!
    
    var searchItem = String()
    var matchesArray = [PFUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchesTableView.dataSource = self
        matchesTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchesArray.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = matchesTableView.dequeueReusableCell(withIdentifier: "MatchCell") as! MatchCell
        
        cell.nameLabel.text = matchesArray[indexPath.row]["name"] as! String
        cell.
        
        return cell
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
