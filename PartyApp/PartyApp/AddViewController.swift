//
//  AddViewController.swift
//  PartyApp
//
//  Created by roneil on 12/11/16.
//  Copyright © 2016 CSCI-6907-Minghao Pu. All rights reserved.
//


import Foundation
import Foundation
import UIKit
import MapKit

class AddViewController: UIViewController {
    
    let index = -1
    
    let persistance = Persistance()
    var latitude: Double = 0.0
    var longitude: Double = 0.0

    // create an empty party
    var party = Party(name: "", startDate: Date(), address: "", willAttend: false, coordinate: CLLocationCoordinate2D())
    
    @IBOutlet weak var nameInput: UITextField!
    

    @IBOutlet weak var addressInput: UILabel!
    
    @IBOutlet weak var dateInput: UILabel!
    
    @IBOutlet weak var addressLb: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var datePickerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressInput.isUserInteractionEnabled = true
        addressInput.layer.masksToBounds = true
        addressInput.text = "..."
        
        dateInput.isUserInteractionEnabled = true
        dateInput.layer.masksToBounds = true
        dateInput.text = "..."
        
        datePickerView.isHidden = true
        
        let tapGesture = UITapGestureRecognizer();
        tapGesture.addTarget(self, action: #selector(AddViewController.showDatePikerView))
        dateInput.addGestureRecognizer(tapGesture)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addAddressViewController =  segue.destination as! AddAddressViewController
        addAddressViewController.addViewController = self;
    }

    @IBAction func saveBtnTapped(_ sender: AnyObject) {
        // save data to variable party then save to userDefault
        if nameInput.text != "" && addressInput.text != "..." && dateInput.text != "..."{
            
            party.name = nameInput.text!
            party.address = addressInput.text!
            party.willAttend = false
            party.longitude = self.longitude
            party.latitude = self.latitude
            party.startDate = datePicker.date
            persistance.saveParties(party: party, index: index)
            
            self.dismiss(animated: true, completion: nil)
        }
        
        let message = "some Message missing"
        let alertController = UIAlertController(title: "Error!",
                                                message: message,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Comfirm", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onback(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showDatePikerView(){
        dismissKeyboard()
        self.datePickerView.isHidden = false
    }
    
    @IBAction func CancelSetTime(_ sender: AnyObject) {
        self.datePickerView.isHidden = true
    }
    
    @IBAction func changeDate(_ sender: AnyObject) {
        let date = datePicker.date
        
        // create date formater to transform date to string
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd HH:mm"
        let datestr = dformatter.string(from: date)
        
        self.dateInput.text = datestr
        
        self.datePickerView.isHidden = true
    }
    
    
    //hide keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }

}
