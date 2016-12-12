//
//  Persistance.swift
//  PartyApp
//
//  Created by roneil on 12/11/16.
//  Copyright © 2016 CSCI-6907-Minghao Pu. All rights reserved.
//

import Foundation

class Persistance {
    
    let partiesKey = "parties"
    
    func saveParties(party: Party, index : Int) {
        let userDefaults = UserDefaults.standard
        
        var parties = fetchParties()
        
//        parties.append(party)
        if (index == -1) {
            parties.append(party)
        } else {
            parties[index] = party
        }
        
        let data = NSKeyedArchiver.archivedData(withRootObject: parties)
        userDefaults.set(data, forKey: partiesKey)
        userDefaults.synchronize()
    }
    
    func fetchParties() -> [Party] {
        let userDefaults = UserDefaults.standard
        
        let parties = userDefaults.object(forKey: partiesKey) as? Data
        
        if let parties = parties {
            return NSKeyedUnarchiver.unarchiveObject(with: parties) as! [Party]
        }
        else{
            return [Party]()
        }
    }
    
    func deleteParty(index : Int) {
        if index != -1 {
            let userDefaults = UserDefaults.standard
            
            var parties = fetchParties()
            
            parties.remove(at: index)
            
            let data = NSKeyedArchiver.archivedData(withRootObject: parties)
            userDefaults.set(data, forKey: partiesKey)
            userDefaults.synchronize()
        }
    }
}
