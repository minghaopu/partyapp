//
//  EditViewController.swift
//  PartyApp
//
//  Created by roneil on 12/11/16.
//  Copyright © 2016 CSCI-6907-Minghao Pu. All rights reserved.
//

import Foundation
import UIKit

class EditViewController: UIViewController {
    
    var index : Int?
    
    let persistance = Persistance()
    
    var party : Party?
    
    
    @IBOutlet weak var nameInput: UITextField!
        
    @IBOutlet weak var addressInput: UITextField!
    
    @IBOutlet weak var dateInpute: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        party = persistance.fetchParties()[index!]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameInput.text = party?.name
        addressInput.text = party?.address
//        dateInpute.text = party?.startDate
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
        party?.name = nameInput.text!;
        party?.address = addressInput.text!
//        party?.startDate = dateInpute.text
        persistance.saveParties(party: party!, index: index!)
    }
    
}
