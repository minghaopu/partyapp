//
//  DetailViewController.swift
//  PartyApp
//
//  Created by roneil on 12/11/16.
//  Copyright © 2016 CSCI-6907-Minghao Pu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
 
    var party : Party?
    var name : String?
    var date : String?

    @IBOutlet weak var partyNameLb: UILabel!
    @IBOutlet weak var partyTimeLb: UILabel!
    @IBOutlet weak var partyAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partyAddress.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        partyNameLb.text = name
        partyTimeLb.text = date
        partyAddress.text = "测试地址"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue"{
//            let editParty = party
            
            
            
            let destinationViewController = segue.destination as! EditViewController
            
            destinationViewController.editParty = party
            destinationViewController.name = name
            destinationViewController.date = date
//            destinationViewController.dateTimePicker = date
            
        }
    }
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? EditViewController {
            partyNameLb.text = sourceViewController.name;
            partyAddress.text = sourceViewController.address;
            partyTimeLb.text = sourceViewController.date;
        }
    }

}
