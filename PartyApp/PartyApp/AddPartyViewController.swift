//
//  AddPartyViewController.swift
//  PartyApp
//
//  Created by XYZ on 2016/12/12.
//  Copyright © 2016年 CSCI-6907-Minghao Pu. All rights reserved.
//

import UIKit

class AddPartyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onBack(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
