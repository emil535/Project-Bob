//
//  Member.swift
//  Project Bob
//
//  Created by Emil Safier on 1/20/17.
//  Copyright © 2017 Emil Safier. All rights reserved.
//

import Foundation



class Member {
    var imageName: String!       // image name of member
    var name: String          // name of Member
    var city: String?         // city of member
    var status: Int           // 0, 1, 2, 3   correxponding to Guest Member Presenter Organizer
    var eMail: String?         // e-Mail address
    var level: String?          // swift level  Beginner, Novice, Qualified, Expert
    var dateJoined: String?
    
    init(
        name: String,
        status: Int
        )
    {
        //   self.imageName = imageName
        self.name = name
        //    self.city = city
        self.status = status
        //   self.eMail = eMail
    }
    
    let typeOfStatus = ["Guest", "Member", "Presenter", "Organizer"]
    let swiftLevel = [ "Beginner", "Novice", "Experienced", "Expert", "Swift Guru"]
    
    func statusDescription (status: Float) -> String {
        var des: String
        switch status {
        case 0.0..<0.5:
            des = "SWIFT Beginner"
            print ("new   \(des)")
        case 0.5..<2.0:
            des = "SWIFT Novice"
            print ("novice   \(des)")
        case 2.0..<3.5:
            des = "SWIFT Qualified"
            print ("experienced   \(des)")
        case 3.5..<4.0:
            des = "SWIFT Expert"
            print ("expert   \(des)")
        default:
            des = "Clueless"
            print ("default       \(des)"   )
        }
        print ("VALUE of des:  \(des)")
        return des
    }
}

let status = ["Guest", "Member", "Presenter", "Organizer"]


