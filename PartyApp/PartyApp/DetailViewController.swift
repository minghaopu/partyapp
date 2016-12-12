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
    
    var party : Party?


    @IBOutlet weak var partyAttendSwitch: UISwitch!
    @IBOutlet weak var partyNameLb: UILabel!
    @IBOutlet weak var partyTimeLb: UILabel!
    @IBOutlet weak var partyAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partyAddress.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        party = persistance.fetchParties()[index!]
        
        // create date formater to transform date to string
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd HH:mm"
        let datestr = dformatter.string(from: (party?.startDate)!)
        
        partyNameLb.text = party?.name
        partyTimeLb.text = datestr
        partyAddress.text = party?.address
        partyAttendSwitch.isOn = (party?.willAttend)!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue"{
            let destinationViewController = segue.destination as! EditViewController
            
            destinationViewController.index = index

        }else if segue.identifier == "mapSegue"{
            let mapViewController = segue.destination as! MapViewController
            
            mapViewController.longitude = (party?.longitude)!
            mapViewController.latitude = (party?.latitude)!
            mapViewController.location = (party?.address)!
        }
    }
    

    @IBAction func attendSwitchTapped(_ sender: Any) {
        // modify party status 
        if partyAttendSwitch.isOn {
            party?.willAttend = true
        } else {
            party?.willAttend = false;
        }
        persistance.saveParties(party: party!, index: index!)
    }

}
