//
//  Party.swift
//  PartyApp
//
//  Created by roneil on 12/10/16.
//  Copyright © 2016 CSCI-6907-Minghao Pu. All rights reserved.
//

import Foundation
class Party: NSObject, NSCoding {
    
    let name: String
    let startDate: Date
    let address: String
    let willAttend: Bool
    
    let nameKey = "name"
    let startDateKey = "startDate"
    let addressKey = "address"
    let willAttendKey = "willAttend"
    
    init(name: String, startDate: Date, address: String, willAttend: Bool) {
        self.name = name
        self.startDate = startDate
        self.address = address
        self.willAttend = willAttend
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: nameKey) as! String
        startDate = aDecoder.decodeObject(forKey: startDateKey) as! Date
        address = aDecoder.decodeObject(forKey: addressKey) as! String
        willAttend = aDecoder.decodeObject(forKey: willAttendKey) as! Bool
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(startDate, forKey: startDateKey)
        aCoder.encode(address, forKey: addressKey)
        aCoder.encode(willAttendKey, forKey: willAttendKey)
    }
    
}
