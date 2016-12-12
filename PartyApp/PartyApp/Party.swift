//
//  Party.swift
//  PartyApp
//
//  Created by roneil on 12/10/16.
//  Copyright © 2016 CSCI-6907-Minghao Pu. All rights reserved.
//

import Foundation
import MapKit

class Party: NSObject, NSCoding {
    
    var name: String
    var startDate: String
    var address: String
    var willAttend: Bool
    var latitude: Double
    var longitude: Double
    
    let nameKey = "name"
    let startDateKey = "startDate"
    let addressKey = "address"
    let willAttendKey = "willAttend"
    let latitudeKey = "latitude"
    let longitudeKey = "longitude"
    
    init(name: String, startDate: String, address: String, willAttend: Bool, coordinate:CLLocationCoordinate2D) {
        self.name = name
        self.startDate = startDate
        self.address = address
        self.willAttend = willAttend
        self.latitude = coordinate.latitude;
        self.longitude = coordinate.longitude;
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: nameKey) as! String
        startDate = aDecoder.decodeObject(forKey: startDateKey) as! String
        address = aDecoder.decodeObject(forKey: addressKey) as! String
        willAttend = aDecoder.decodeBool(forKey: willAttendKey)
        latitude = aDecoder.decodeDouble(forKey: latitudeKey)
        longitude = aDecoder.decodeDouble(forKey: longitudeKey)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(startDate, forKey: startDateKey)
        aCoder.encode(address, forKey: addressKey)
        aCoder.encode(willAttend, forKey: willAttendKey)
        aCoder.encode(latitude, forKey: latitudeKey)
        aCoder.encode(longitude, forKey: longitudeKey)
    }
    
}
