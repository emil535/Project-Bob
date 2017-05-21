//
//  MembersSubTitleTableViewController.swift
//  Project Bob
//
//  Created by Emil Safier on 4/16/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//

import UIKit

class MembersSubTitleTableViewController: UITableViewController {
    
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
//* //  Bob-2  SLIDE 10 - table view specifications
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sampleMembers.count
    }
//*/
    
//* //  Bob-2  SLIDE 12 - dequeue Reusable Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> TableViewSubtitleCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberSubtitleCell", for: indexPath) as! TableViewSubtitleCell

        // Configure the cell...
        let member = sampleMembers[indexPath.row]

//*      Bob-2  SLIDE 14 - remove references to Style Subtitle
        cell.textLabel?.text =  member.name
        cell.detailTextLabel?.text = member.city! + "      " + status[ member.status]  + " - " + swiftLevel[member.level]
        cell.imageView?.image =  member.image
//*/
        
        return cell 
    }
//*/

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
