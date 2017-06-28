//
//  MembersSubTitleTableViewController.swift
//  Project Bob
//
//  Created by Emil Safier on 4/16/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//

import UIKit

class MembersSubTitleTableViewController: UITableViewController {
    

    //  Array of Members
//    var members = [Member]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/* //  Bob-2  SLIDE 10 - table view specifications
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sampleMembers.count
    }
*/      //  s-10
    
    
/* //  Bob-2  SLIDE 12 - dequeue Reusable Cell - SubTitle
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        // Configure the cell...
        let member = sampleMembers[indexPath.row]
        cell.textLabel?.text =  member.name
        //  Sueeze three properties into one line
        cell.detailTextLabel?.text = member.city! + "      " + status[ member.status] + " - " + swiftLevel[member.level]
        cell.imageView?.image =  member.image
        return cell
    }
*/      //  s-12

    

}
