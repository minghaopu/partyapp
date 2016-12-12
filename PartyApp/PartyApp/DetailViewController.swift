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

    @IBOutlet weak var partyNameLb: UILabel!
    @IBOutlet weak var partyTimeLb: UILabel!
    @IBOutlet weak var partyAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partyAddress.isUserInteractionEnabled = true
        
        party = persistance.fetchParties()[index!]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        partyNameLb.text = party?.name
//        partyTimeLb.text = party?.startDate
        partyAddress.text = party?.address
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
            
        }
    }
    
//    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.source as? EditViewController {
//            name = sourceViewController.nameInput.text;
//            address = sourceViewController.addressInput.text;
//            date = sourceViewController.dateInpute.text;
//        }
//    }

}
