//
//  MembersTableViewController.swift
//  Project Bob
//
//  Created by Emil Safier on 3/10/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//

import UIKit

class MembersTableViewController: UITableViewController {
/*
    //  Bob-2  SLIDE 11 - Outlets for Cell Style: SubTitle
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var memberImage: UIImageView!
 */
    
    //  Array of Members
    var members = [Member]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions
    
    @IBAction func unwindCancel(sender: UIStoryboardSegue){
        print("CANCEL button pressed")
    }   // unwindCancel
    
    @IBAction func unwindSaveMember(sender: UIStoryboardSegue) {
        print ("SAVE button pressed")
        if let sourceViewController = sender.source as? MemberViewController  {
            let member = sourceViewController.thisMember
            
            if let selectedIndexPath = self.tableView.indexPathForSelectedRow  {
                sampleMembers[selectedIndexPath.row ] = member
               // self.tableView.rectForRow(at: selectedIndexPath)
                self.tableView.reloadRows(at: [selectedIndexPath], with: UITableViewRowAnimation.automatic)
            } else {
            // Add new member
            let newIndexPath = IndexPath(row: sampleMembers.count, section: 0)
            print("MEMBER COUNT:  \(sampleMembers.count)")
            sampleMembers.append(member)
            print("+MEMBER COUNT:  \(sampleMembers.count)")
            print("INDEXPATH: \(newIndexPath) ")
            self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }    // unwindSave
    
    // MARK: - Table view data source
    
//*
    //  Bob-2  SLIDE 10 - dequeue Reusable Cell
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sampleMembers.count
    }
//*/

//*
    //  Bob-2  SLIDE 12 - dequeue Reusable Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MemberTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! MemberTableViewCell
        // Configure the cell...
        let member = sampleMembers[indexPath.row]
      
        print("ROW:  \(indexPath.row) \n NAME: \(member.name)")
        //\n CITY:  \(member.city!) \n  STATUS:  \(member.status)")
       
        cell.memberNameLabel.text = member.name
        cell.memberCityLabel.text = member.city
        cell.memberStatusLabel.text = status[ member.status]
        cell.memberSwiftLevelLabel.text = swiftLevel[member.level]
        cell.memberImage.image = member.image

        
/*      //  Bob-2  SLIDE 14 - remove references to Style Subtitle
        cell.textLabel?.text =  member.name
        cell.detailTextLabel?.text = member.city! + "      " + status[ member.status]  + " - " + swiftLevel[member.level]
        cell.imageView?.image = UIImage(named: member.imageName!)
*/      //  14
        return cell
    }    // tableView
//*/    //  12

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print ("ID: \(segue.identifier ?? "**** none") ")
        
        if segue.identifier == "addMember" {
            let navVC = segue.destination as? UINavigationController                // target in NavController
            let targetVC = (navVC?.topViewController as? MemberViewController)!     // but we need ViewController
            targetVC.newMember = true                                               // to access this Bool
            targetVC.title = "Add Member"
        } else {
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
            
        }     // prepare
    }

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }




    //*/





 
