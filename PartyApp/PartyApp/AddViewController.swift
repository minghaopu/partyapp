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
import MapKit

class AddViewController: UIViewController {
    
    let index = -1
    
    let persistance = Persistance()
    var latitude: Double = 0.0
    var longitude: Double = 0.0

    // 使用日期格式器格式化日期、时间
    var party = Party(name: "", startDate: "", address: "", willAttend: false, coordinate: CLLocationCoordinate2D())
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var dateInpute: UILabel!

    @IBOutlet weak var addressInput: UILabel!
    
    @IBOutlet weak var addressLb: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var datePickerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        party = persistance.fetchParties()[index!]
        addressInput.isUserInteractionEnabled = true
        addressInput.layer.borderWidth = 1.0;
        addressInput.layer.borderColor = UIColor.gray.cgColor;
        addressInput.layer.cornerRadius = 3.0;
        addressInput.layer.masksToBounds = true
        
        dateInpute.isUserInteractionEnabled = true
        dateInpute.layer.borderWidth = 1.0;
        dateInpute.layer.borderColor = UIColor.gray.cgColor;
        dateInpute.layer.cornerRadius = 3.0;
        dateInpute.layer.masksToBounds = true
        
        datePickerView.isHidden = true
        
        let tapGesture = UITapGestureRecognizer();
        tapGesture.addTarget(self, action: Selector(("showDatePikerView")))
        dateInpute.addGestureRecognizer(tapGesture)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        addressInput.text = party.address
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addAddressViewController =  segue.destination as! AddAddressViewController
        addAddressViewController.addViewController = self;
    }

    @IBAction func saveBtnTapped(_ sender: AnyObject) {
        if nameInput.text != "" && addressInput.text != "" && dateInpute.text != ""{
            party.name = nameInput.text!;
            party.address = addressInput.text!
            party.willAttend = false;
            party.longitude = self.longitude;
            party.latitude = self.latitude;
            party.startDate = self.dateInpute.text!;
            persistance.saveParties(party: party, index: index)
            
            self.dismiss(animated: true, completion: nil)
        }
        
        let message =  "some Message missing"
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
        self.datePickerView.isHidden = false;
    }
    
    @IBAction func CancelSetTime(_ sender: AnyObject) {
        self.datePickerView.isHidden = true;
    }
    
    @IBAction func changeDate(_ sender: AnyObject) {
        let date = datePicker.date
        
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        // 为日期格式器设置格式字符串
        dformatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        // 使用日期格式器格式化日期、时间
        let datestr = dformatter.string(from: date)
        
        self.dateInpute.text = datestr;
        
        self.datePickerView.isHidden = true;
    }
}
