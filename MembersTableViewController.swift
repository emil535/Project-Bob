//
//  MembersTableViewController.swift
//  Project Bob
//
//  Created by Emil Safier on 3/10/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//  [ purged all references to Bob-2 Aug 29 - 2017 ]

import UIKit

class MembersTableViewController: UITableViewController {
    
    //  Array of Members
    var members = [Member]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  enable Edit button in TableView
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //  MARK: - Actions
    //  Unwind from MemberViewController - Save Button
    @IBAction func unwindSaveMember(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MemberViewController  {
            let member = sourceViewController.thisMember
            
            //  if a row is selected then update it on unwind;
            if let selectedIndexPath = self.tableView.indexPathForSelectedRow  {
                sampleMembers[selectedIndexPath.row ] = member
                self.tableView.reloadRows(at: [selectedIndexPath], with: UITableViewRowAnimation.automatic)
            } else {
                // Add new member if no row is selected
                let newIndexPath = IndexPath(row: sampleMembers.count, section: 0)
                sampleMembers.append(member)
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

    //  MARK: - Table view data source
    //  dequeue Reusable Cell
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return sampleMembers.count
    }
    //  dequeue Reusable Cell -- CUSTOM CELL
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MemberTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! MemberTableViewCell
        // Configure the cell...
        let member = sampleMembers[indexPath.row]
        cell.memberNameLabel.text = member.name
        cell.memberCityLabel.text = member.city
        cell.memberStatusLabel.text = status[ member.status]
        cell.memberSwiftLevelLabel.text = swiftLevel[member.level]
        cell.memberImage.image = member.image
        return cell
    }

    //  Override to support editing the table view. Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    //  Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            sampleMembers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    //*
    // MARK: - Navigation

    // preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMember" {
            let navVC = segue.destination as? UINavigationController                // target in NavController
            let targetVC = (navVC?.topViewController as? MemberViewController)!     // but we need ViewController
            targetVC.newMember = true                                               // to access this Bool
            targetVC.title = "Add Member"
        }
        else {
            let targetVC = segue.destination as? MemberViewController
            targetVC?.newMember = false
            targetVC?.title = "Edit Member"
            
            // get info on selected cell
            guard let selectedMemberCell = sender as? MemberTableViewCell  else {
                fatalError("Unexpected Sender")
            }
            guard let indexPath =  self.tableView.indexPath(for: selectedMemberCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedMember = sampleMembers[indexPath.row]
            targetVC?.thisMember = selectedMember
        }
    
    }

}     // ===== last curly braces for MembersTableViewController.swift  =====










 
