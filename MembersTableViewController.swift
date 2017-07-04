//
//  MembersTableViewController.swift
//  Project Bob
//
//  Created by Emil Safier on 3/10/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//

import UIKit

class MembersTableViewController: UITableViewController {
    
    //  Array of Members
//    var members = [Member]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///  Bob-2  SLIDE 37 - enable Edit button in TableView
        // self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

/*  //  Bob-2  SLIDE 35 - Unwind from MemberViewController
    @IBAction func unwindSaveMember(sender: UIStoryboardSegue) {
        print ("SAVE button in MemberView pressed")
        if let sourceViewController = sender.source as? MemberViewController  {
            let member = sourceViewController.thisMember
            
           //      TEST for bug  ------------------------
           // let count = sampleMembers.count
           // for i in 0..<count {
           //     print("ACTION Person \(i) is called \(sampleMembers[i].name)")
           //     }
           //  --------------------------------------
            
            //  if a row is selected then update it on unwind;
            if let selectedIndexPath = self.tableView.indexPathForSelectedRow  {
                print("UPDATE ROW:  \(selectedIndexPath.row)")
                sampleMembers[selectedIndexPath.row ] = member
                self.tableView.reloadRows(at: [selectedIndexPath], with: UITableViewRowAnimation.automatic)
            } else {
                // Add new member if no row is selected
                let newIndexPath = IndexPath(row: sampleMembers.count, section: 0)
                 print("APPEND:  \(newIndexPath.row)")
                 print("MEMBER COUNT:  \(sampleMembers.count)")
                sampleMembers.append(member)
                 print("+MEMBER COUNT:  \(sampleMembers.count)")
                 print("INDEXPATH: \(newIndexPath) ")
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
   }    // unwindSave
*/    // s-35
    

    
    // MARK: - Table view data source

/* //  Bob-2  SLIDE 16 - dequeue Reusable Cell
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return sampleMembers.count
    }
*/   //   s-16


    

/*     //  Bob-2  SLIDE 16 - dequeue Reusable Cell -- CUSTOM CELL
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MemberTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! MemberTableViewCell
        // Configure the cell...
        let member = sampleMembers[indexPath.row]
        print("ROW:  \(indexPath.row) \n NAME: \(member.name)")
        cell.memberNameLabel.text = member.name
        cell.memberCityLabel.text = member.city
        cell.memberStatusLabel.text = status[ member.status]
        cell.memberSwiftLevelLabel.text = swiftLevel[member.level]
        cell.memberImage.image = member.image
        return cell
    }
*/    //  s-16

/*     //  Bob-2  SLIDE 37 - Override to support editing the table view. Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
*/      // s-37

/*      //    Bob-2  SLIDE 37 - Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            sampleMembers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
*/    // s-37

    
    
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


    // MARK: - Navigation
    
/*       //  Bob-2  SLIDE 27
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print ("ID: \(segue.identifier ?? "**** none") ")
        if segue.identifier == "addMember" {
            let navVC = segue.destination as? UINavigationController                // target in NavController
            let targetVC = (navVC?.topViewController as? MemberViewController)!     // but we need ViewController
            targetVC.newMember = true                                               // to access this Bool
            targetVC.title = "Add Member"
        }
            
    /*  //  Bob-2  SLIDE 28
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
            
            //  TEST for BUG
            // let count = sampleMembers.count
            // for i in 0..<count {
            //    print("Person \(i) is called \(sampleMembers[i].name)")
            // }
           
            targetVC?.thisMember = selectedMember
        }
    */    //  S-28
    }
*/    //  s-27

}     //  ===== LAST LINE ======










 
