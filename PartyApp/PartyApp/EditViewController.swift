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
    
    var name : String?
    var address : String?
    var startDate : Date?
    var editParty : Party?
    var date : String?
    
    @IBOutlet weak var nameInput: UITextField!
        
    @IBOutlet weak var addressInput: UITextField!
    
    @IBOutlet weak var dateInpute: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameInput.text = name
        addressInput.text = address
        dateInpute.text = date
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
        name = nameInput.text
        address = addressInput.text
        date = dateInpute.text
    }
    
}
