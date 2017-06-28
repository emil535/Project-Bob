//
//  Member.swift
//  Project Bob
//
//  Created by Emil Safier on 1/20/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//

import Foundation
import UIKit



/*   //  Bob-2  SLIDE 4 - Add Member Class in Model
class Member {
    var name: String        // name of Member
    var city: String?       // city of member
    var eMail: String?      // e-Mail address
    var status: Int         // 0, 1, 2, 3   Guest Member Presenter Organizer
    var level: Int          // swift level  Beginner, Novice, Qualified, Expert
    var dateJoined: String?
    // Bob-2  SLIDE 26 - change image variable name to UIImage type
    // var imageName: String     // image name of member  [ CORRECTION ]
    var image: UIImage?
    
    init(
        name: String,
        city: String?,
        eMail: String?,
        status: Int,
        level: Int,
        dateJoined: String?,
        // Bob-2  SLIDE 26 - change image variable name to UIImage type
        // imageName: String?   //  [ CORRECTION ]
        image: UIImage?
        )
    {
        self.name = name
        self.city = city
        self.eMail = eMail
        self.status = status
        self.level = level
        self.dateJoined = dateJoined
        // Bob-2  SLIDE 26 - change image variable name to UIImage type
        // self.imageName = imageName   //  [ CORRECTION ]
        self.image = image
    }
}
*/      //  s-4

/*      //  Bob-2  SLIDE 4 - Sample data
var sampleMembers = [
    Member(name: "Emil Safier",
           city: "Tokyo",
           eMail: "Emil502@Gmail.com",
           status: 2,
           level: 4,
           dateJoined: "June 14, 2017",
           image: UIImage(named: "Emil")),
    Member(name: "Lucy Bodacious",
           city: "Los Angeles",
           eMail: "LucyBod.Aol.com",
           status: 0,
           level: 3,
           dateJoined: "Jan aa, 2016",
           // imageName: "Lucy")),  //  [ CORRECTION ]
        image: UIImage(named: "Lucy")),
    Member(name: "Albert Einstein",
            city: "Princeton, NJ",
            eMail: "Albert@Gmail.com",
            status: 1,
            level: 2,
            dateJoined: "Mar 14, 1979",
            image: UIImage(named: "Albert")),
    Member(name: "Fred Zapata",
           city: "Lima Peru",
           eMail: "Fred8989@Gmail.com",
           status: 1,
           level: 2,
           dateJoined: "Feb 14, 2015",
           image: UIImage(named: "Zapata")),

    Member(name: "Barnabe McGee",
           city: "San Francisco",
           eMail: "Barnabe302@Gmail.com",
           status: 0,
           level: 0,
           dateJoined: "Feb 14, 2017",
           image: UIImage(named: "Barnabe"))
]
*/   //  s-4


let status = ["Guest", "Member", "Presenter", "Organizer"]
/*     //  Bob-2  SLIDE 5 - Add array for Swift Level, and Array of Arrays
let swiftLevel = [ "Beginner", "Novice", "Experienced", "Expert", "Swift Guru"]
// Array consisting of two arrays representing choices for status and level of member
let memberInfo = [status, swiftLevel]
*/   //  s-5

