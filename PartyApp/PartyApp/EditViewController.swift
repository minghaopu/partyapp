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
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var addressInput: UILabel!
    @IBOutlet weak var dateInput: UILabel!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var datePickerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        party = persistance.fetchParties()[index!]
        
        addressInput.isUserInteractionEnabled = true
        addressInput.layer.masksToBounds = true
        
        dateInput.isUserInteractionEnabled = true
        dateInput.layer.masksToBounds = true
        
        //bind tapcesture to dateInput label
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(EditViewController.showDatePikerView))
        dateInput.addGestureRecognizer(tapGesture)
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd HH:mm"
        let datestr = dformatter.string(from: (party?.startDate)!)
        
        nameInput.text = party?.name
        addressInput.text = party?.address
        dateInput.text = datestr
        
        datePickerView.isHidden = true
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        if nameInput.text != "" && addressInput.text != "" && dateInput.text != "" {
            party?.name = nameInput.text!;
            party?.address = addressInput.text!
            party?.longitude = self.longitude;
            party?.latitude = self.latitude;
            party?.startDate = datePicker.date
            
            persistance.saveParties(party: party!, index: index!)
            
            self.navigationController?.popViewController(animated: true)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addAddressViewController =  segue.destination as! AddAddressViewController
        addAddressViewController.editViewController = self;
    }
    
    func showDatePikerView(){
        dismissKeyboard()
        self.datePickerView.isHidden = false;
    }
    
    @IBAction func CancelSetTime(_ sender: AnyObject) {
        self.datePickerView.isHidden = true;
    }
    
    @IBAction func changeDate(_ sender: AnyObject) {
        let date = datePicker.date
        
        // create date formater to transform date to string
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd HH:mm"
        let datestr = dformatter.string(from: date)
        
        self.dateInput.text = datestr;
        
        self.datePickerView.isHidden = true;
    }
    
    //hide keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
