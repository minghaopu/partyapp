//
//  AddViewController.swift
//  PartyApp
//
//  Created by neal on 12/11/16.
//  Copyright © 2016 CSCI-6907-Minghao Pu. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class AddViewController: UIViewController {
    
    let index = -1
    
    let persistance = Persistance()
    
    var party = Party(name: "", startDate: Date(), address: "", willAttend: false)
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var dateInpute: UITextField!

    @IBOutlet weak var addressInput: UITextField!
    
    @IBOutlet weak var addressLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        party = persistance.fetchParties()[index!]
        addressLb.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameInput.text = party.name
        addressInput.text = party.address
        //        dateInpute.text = party?.startDate
    }

    @IBAction func saveBtnTapped(_ sender: AnyObject) {
        party.name = nameInput.text!;
        party.address = addressInput.text!
        party.willAttend = false;
        //        party?.startDate = dateInpute.text
        persistance.saveParties(party: party, index: index)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onback(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
