//
//  DetailViewController.swift
//  PartyApp
//
//  Created by roneil on 12/11/16.
//  Copyright © 2016 CSCI-6907-Minghao Pu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
 
    var party : Party? = nil
    var name : String = ""
    var date : String = ""

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
    

}
