//
//  MembersTableViewController.swift
//  Project Bob
//
//  Created by Emil Safier on 3/10/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//  [ purged all references to Bob-2 Aug 29 - 2017 ]

import UIKit
import CoreData


//  Bob-3  SLIDE xx - add FetchedRe..Delegate
class MembersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //  Array of Members/Users/emilsafier/Documents/SWIFT 101/Project Bob/Project Bob/Member+CoreDataProperties.swift
    //  Bob-3  SLIDE 18 - will replace sampleMembers
   // var members = [Member]()
    
    //  CoreData vars
    //  Bob-3  SLIDE xx - add context and FRController
    var moc:NSManagedObjectContext!    // Managed Object Context
    var fetchedResultsController: NSFetchedResultsController<Member>?  // TableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moc = BobDatabase.context
        _ = fetchData()
        
        //        //  Bob-3  SLIDE 18 - will fetch Member data from CoreData
        //        let fetchRequest: NSFetchRequest<Member> = Member.fetchRequest()
        //        //  sort in descending order (guru, ... beginner)
        //        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "level", ascending: false), NSSortDescriptor(key: "status", ascending: true)]
        //        do {
        //            let members = try BobDatabase.context.fetch(fetchRequest)
        //            print ("LOADED:  \(members.count)")
        //            self.members = members
        //            tableView.reloadData()
        //            print("STOP:  2  ")
        //        } catch {print (error) }
        
        //  enable Edit button in TableView
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
    //  MARK: - Actions
    
    //  load Sample Data
    
    @IBAction func loadSampleMembers(_ sender: UIBarButtonItem) {
        for  smem in sampleMembers {
            print("NAME:  \(smem.name)")
     //       self.members.append(switchIt(sampleMem: smem))
        }
        tableView.reloadData()
        BobDatabase.saveContext()
        
    }
    func switchIt(sampleMem: XMember)-> Member {
        print("ok")
        let mem = Member(context: BobDatabase.context)
        print("ok 1")
        mem.name = sampleMem.name
        //    print ("memNAME:   \(mem.name)")
        mem.city = sampleMem.city
        mem.eMail = sampleMem.eMail
        mem.level = Int16(sampleMem.level)
        mem.status = Int16(sampleMem.status)
        let imageData: NSData = UIImageJPEGRepresentation(sampleMem.image!, 1.0)! as NSData
        mem.image = imageData
        mem.dateJoined = sampleMem.dateJoined
        return mem
    }
    
    //  Unwind from MemberViewController - Save Button
    @IBAction func unwindSaveMember(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? MemberViewController  {
            //  Bob-3  SLIDE 21 - replace addMember/sampleMembers
        //    let member = sourceViewController.newMember
        //    print("unwindSaveMember:  \(member.name)  ")
            //  if a row is selected then update it on unwind;
            BobDatabase.saveContext()
            
            
            if let selectedIndexPath = self.tableView.indexPathForSelectedRow  {
                print("EDIT ")
             //   members[selectedIndexPath.row ] = member
             //   self.tableView.reloadRows(at: [selectedIndexPath], with: UITableViewRowAnimation.automatic)
            } else {
                print("ADD ")
                // Add new member if no row is selected
       //         let newIndexPath = IndexPath(row: members.count, section: 0)
             //   members.append(member)
            //    self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            //      print("SAVE:  \(member.name )   \(members.count)")
            //   BobDatabase.saveContext()       // saves the context;  saves the data
            //      print("saved...")
        }
    }
    
    
    
    //  MARK: - FetchedResultsController for TableView
    
    //    function to initialize fetchedResultsController
    func fetchData() {
        let request: NSFetchRequest<Member> = Member.fetchRequest()     //(entityName: "Member")
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [nameSort]
        
        self.fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: moc,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedResultsController?.delegate = self as! NSFetchedResultsControllerDelegate
        
        do {
            try fetchedResultsController?.performFetch()
            tableView.reloadData()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    //  Sections in table
    //  Bob-3  SLIDE xx - use FRController
    override func numberOfSections(in tableView: UITableView) -> Int {
        //  let sectionsCount = fetchedResultsController?.sections?.count {
        return fetchedResultsController?.sections?.count ?? 1           // if Nil, return 1
    }
    // return the number of sections
    // return 1
    
    
    // return the number of rows
    //  Bob-3  SLIDE xx - use FRController
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection:   ")
        if let sections = fetchedResultsController?.sections   {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        } else {
            return 0
        }
        
        //  Bob-3  SLIDE 19 - replace sampleMembers
        // return sampleMembers.count
    }
    
    //  dequeue Reusable Cell -- CUSTOM CELL
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MemberTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! MemberTableViewCell
        print("cellForRowAt:  \(indexPath)")
        //  Bob-3  SLIDE 19 - replace sampleMembers and NSData/Int16 conversion
        if let member = self.fetchedResultsController?.object(at: indexPath) {
            //    members[indexPath.row]     //sampleMembers[indexPath.row]
            cell.memberNameLabel.text = member.name
            cell.memberCityLabel.text = member.city
            cell.memberStatusLabel.text = status[ Int(member.status)]
            cell.memberSwiftLevelLabel.text = swiftLevel[Int(member.level)]
            if let data = member.image  {
                cell.memberImage.image = UIImage(data: data as Data )  // UIImage(data: member.image)  // convert NSData to UIImage
            }
        }
        print("cellForRowAt:  ------------ ")
        
        
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
            print("editingStyle:  .delete ")
            // Delete the row from the data source
            //  Bob-3  SLIDE xx - delete Member in CoreData/ update with .saveContext
            let context = BobDatabase.context
            let memberToDelete = self.fetchedResultsController?.object(at: indexPath)
            context.delete(memberToDelete!)
            BobDatabase.saveContext()

//            members.remove(at: indexPath.row)
        //    tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            print("editingStyle:  .insert ")
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    //  MARK: - Fetched results controller deledgate functions
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType){
        switch type {
        case .insert: tableView.insertSections([sectionIndex], with: .fade)
        case .delete: tableView.deleteSections([sectionIndex], with: .fade)
        default: break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert: tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete: tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update: tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
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
        print("prepare(:for segue:  ")
        if segue.identifier == "addMember" {
            let navVC = segue.destination as? UINavigationController                // target in NavController
            let targetVC = (navVC?.topViewController as? MemberViewController)!     // but we need ViewController
            // Bob-22  SLIDE 11 - renamed newMember -> addMember
            targetVC.addMember = true                                               // to access this Bool
            targetVC.title = "Add Member"
        }
        else {
            let targetVC = segue.destination as? MemberViewController
            // Bob-3  SLIDE 22 - renamed newMember -> addMember
            targetVC?.addMember = false
            targetVC?.title = "Edit Member"
            
            // get info on selected cell
            guard let selectedMemberCell = sender as? MemberTableViewCell  else {
                fatalError("Unexpected Sender")
            }
            guard let indexPath =  self.tableView.indexPath(for: selectedMemberCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            if let selectedMember = self.fetchedResultsController?.object(at: indexPath) {
                print("STOP:  \(selectedMember.name )  ")
                // Bob-3  SLIDE 22 - reference change from thisMember to newMember
                targetVC?.newMember = selectedMember
              print("prepare(for segue:: at end ")
            }
         //   let members = fetchedResultsController! as [Member]
         //   let selectedMember = tableView.
            // fetchedResultsController![indexPath]
           // let selectedMember = members[indexPath.row]
      
        }
        
    }
    
}     // ===== last curly braces for MembersTableViewController.swift  =====











