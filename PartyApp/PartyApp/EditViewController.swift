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
    
    @IBOutlet weak var dateInpute: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var datePickerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        party = persistance.fetchParties()[index!]
        
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
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: Selector(("showDatePikerView")))
        dateInpute.addGestureRecognizer(tapGesture)
        
        nameInput.text = party?.name
        addressInput.text = party?.address
        dateInpute.text = party?.startDate
        
        datePickerView.isHidden = true
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        party?.name = nameInput.text!;
        party?.address = addressInput.text!
        party?.longitude = self.longitude;
        party?.latitude = self.latitude;
        party?.startDate = dateInpute.text!
        
        persistance.saveParties(party: party!, index: index!)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addAddressViewController =  segue.destination as! AddAddressViewController
        addAddressViewController.editViewController = self;
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
