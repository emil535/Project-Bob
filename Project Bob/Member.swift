//
//  Member.swift
//  Project Bob
//
//  Created by Emil Safier on 1/20/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//

import Foundation
//*
//  Bob-2  SLIDE 4 - Add Member Class in Model
class Member {
    var name: String        // name of Member
    var city: String?       // city of member
    var eMail: String?      // e-Mail address
    var status: Int         // 0, 1, 2, 3   Guest Member Presenter Organizer
    var level: Int          // swift level  Beginner, Novice, Qualified, Expert
    var dateJoined: String?
    var imageName: String?  // image name of member
    
    init(
        name: String,
        city: String?,
        eMail: String?,
        status: Int,
        level: Int,
        dateJoined: String,
        imageName: String?
        )
    {
        self.name = name
        self.city = city
        self.eMail = eMail
        self.status = status
        self.level = level
        self.dateJoined = dateJoined
        self.imageName = imageName
    }
}
//*/

//*
//  Bob-2  SLIDE 4 - Sample data
let sampleMembers = [
    Member(name: "Lucy Bodacious",
           city: "Los Angeles",
           eMail: "LucyFinkel@Aol.com",
           status: 0,
           level: 3,
           dateJoined: "Jan 22, 2016",
           imageName: "college girl"),
    Member(name: "Bob Loquacious", city: "Santa Monica", eMail: "Bob105@Gmail.com", status: 1, level: 2, dateJoined: "Feb 14, 2017", imageName: "college guy"),
    Member(name: " Fenster Hinklebottom", city: "Tokyo", eMail: "Fenster502@Gmail.com", status: 2, level: 4, dateJoined: "June 14, 2017", imageName: "man in sweather"),
    Member(name: "Minerva Finkle", city: "Santa Monica", eMail: "Minni@Gmail.com", status: 0, level: 0, dateJoined: "Feb 14, 2017", imageName: "white haired lady")
]
//*/

//*
//  Bob-2  SLIDE 5 - Add array for Swift Level, and Array of Arrays
let status = ["Guest", "Member", "Presenter", "Organizer"]
let swiftLevel = [ "Beginner", "Novice", "Experienced", "Expert", "Swift Guru"]
// Array consisting of two arrays representing choices for status and level of member
let memberInfo = [status, swiftLevel]
//*/

