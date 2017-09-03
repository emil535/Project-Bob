//
//  Member+CoreDataProperties.swift
//  Project Bob
//
//  Created by Emil Safier on 8/31/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//

import Foundation
import CoreData

extension Member {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Member> {
        return NSFetchRequest<Member>(entityName: "Member")
    }
    @NSManaged public var name: String?
    @NSManaged public var city: String?
    @NSManaged public var eMail: String?
    @NSManaged public var status: Int16
    @NSManaged public var level: Int16
    @NSManaged public var dateJoined: String?
    @NSManaged public var image: NSData?
    
    
    
}
