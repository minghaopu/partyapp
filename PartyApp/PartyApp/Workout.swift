//
//  Workout.swift
//  PartyApp
//
//  Created by roneil on 12/10/16.
//  Copyright © 2016 CSCI-6907-Minghao Pu. All rights reserved.
//

import Foundation
class Workout: NSObject, NSCoding {
    
    let name: String
    let startDate: Date
    let pushupsCompleted: Int
    
    let nameKey = "name"
    let startDateKey = "startDate"
    let pushupsCompletedKey = "pushupsCompleted"
    
    init(name: String, startDate: Date, pushupsCompleted: Int) {
        self.name = name
        self.startDate = startDate
        self.pushupsCompleted = pushupsCompleted
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: nameKey) as! String
        startDate = aDecoder.decodeObject(forKey: startDateKey) as! Date
        pushupsCompleted = aDecoder.decodeInteger(forKey: pushupsCompletedKey)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(startDate, forKey: startDateKey)
        aCoder.encode(pushupsCompleted, forKey: pushupsCompletedKey)
    }
    
}
