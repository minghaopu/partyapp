//
//  DetailViewController.swift
//  PartyApp
//
//  Created by roneil on 12/11/16.
//  Copyright © 2016 CSCI-6907-Minghao Pu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    var index : Int?
    
    let persistance = Persistance()
    
//    
    var party : Party?
//    var name : String?
//    var date : String?
//    var address : String?

    @IBOutlet weak var partyAttendSwitch: UISwitch!
    @IBOutlet weak var partyNameLb: UILabel!
    @IBOutlet weak var partyTimeLb: UILabel!
    @IBOutlet weak var partyAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partyAddress.isUserInteractionEnabled = true
        
//        party = persistance.fetchParties()[index!]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        party = persistance.fetchParties()[index!]
        
        partyNameLb.text = party?.name
        partyTimeLb.text = party?.startDate
        partyAddress.text = party?.address
        partyAttendSwitch.isOn = (party?.willAttend)!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue"{
//            let editParty = party
            let destinationViewController = segue.destination as! EditViewController
            
            destinationViewController.index = index
            
//            destinationViewController.editParty = party
//            destinationViewController.name = name
//            destinationViewController.date = date
//            destinationViewController.address = address
//            destinationViewController.dateTimePicker = date
        }else if segue.identifier == "mapSegue"{
            let mapViewController = segue.destination as! MapViewController
            
            mapViewController.longitude = (party?.longitude)!
            mapViewController.latitude = (party?.latitude)!
            mapViewController.location = (party?.address)!
        }
    }
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
    }

    @IBAction func attendSwitchTapped(_ sender: Any) {
        if partyAttendSwitch.isOn {
            party?.willAttend = true
        } else {
            party?.willAttend = false;
        }
        persistance.saveParties(party: party!, index: index!)
    }

}
