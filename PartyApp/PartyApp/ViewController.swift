//
//  ViewController.swift
//  PartyApp
//
//  Created by roneil on 12/5/16.
//  Copyright © 2016 CSCI-6907-Minghao Pu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var partySegementedControl: UISegmentedControl!
    @IBOutlet weak var partyTableView: UITableView!
    
    let futureList:[String] = ["future item 1", "future item 2"];
    let planList:[String] = ["plan item 1", "plan item 2", "plan item 3"];
    let attendList:[String] = ["attend item 1", "attend item 2", "attend item 3", "attend item 4"];
    
    var totalParties:[Party]?
    var futureParties:[Party]?
    var planParties:[Party]?
    var attendParties:[Party]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //create three list;
        let currentDateTime = Date()
        for party in totalParties! {
            if party.willAttend == true {
                planParties?.append(party)
                if party.startDate < currentDateTime {
                    attendParties?.append(party)
                }
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnVal = 0
        switch partySegementedControl.selectedSegmentIndex {
        case 0:
            returnVal = futureList.count;
            break
        case 1:
            returnVal = planList.count;
            break
        case 2:
            returnVal = attendList.count;
            break
        default:
            break
        }
        return returnVal
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let partyCell = tableView.dequeueReusableCell(withIdentifier: "partyCell", for: indexPath)
        switch partySegementedControl.selectedSegmentIndex {
        case 0:
            partyCell.textLabel?.text = futureList[indexPath.row];
            break;
        case 1:
            partyCell.textLabel?.text = planList[indexPath.row];
            break;
        case 2:
            partyCell.textLabel?.text = attendList[indexPath.row];
            break;
        default:
            break;
        }
        return partyCell
    }

    @IBAction func segmentedControlActionChanged(_ sender: Any) {
        partyTableView.reloadData()
    }
    
    @IBAction func refreshBtnTapped(_ sender: Any) {
        partyTableView.reloadData()
    }

}

