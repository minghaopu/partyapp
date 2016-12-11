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
    let futureDateList:[String] = ["2016/2/2","2016/2/3"];
    let planList:[String] = ["plan item 1", "plan item 2", "plan item 3"];
    let planDateList:[String] = ["2016/2/2","2016/2/3","2016/2/4"];
    let attendList:[String] = ["attend item 1", "attend item 2", "attend item 3", "attend item 4"];
    let attendDateList:[String] = ["2016/2/2","2016/2/3","2016/2/4","2016/2/5"];
    
    var totalParties:[Party]?
    var futureParties:[Party]?
    var planParties:[Party]?
    var attendParties:[Party]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //create three list;
//        let currentDateTime = Date()
//        for party in totalParties! {
//            if party.willAttend == true {
//                planParties?.append(party)
//                if party.startDate < currentDateTime {
//                    attendParties?.append(party)
//                }
//            }
//        }
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
        
        let partyCell = tableView.dequeueReusableCell(withIdentifier: "partyCell", for: indexPath) as! PartiesTableViewCell
        switch partySegementedControl.selectedSegmentIndex {
        case 0:
            partyCell.partyNameLb.text = futureList[indexPath.row];
            partyCell.partyDateLb.text = futureDateList[indexPath.row];
            break;
        case 1:
            partyCell.partyNameLb.text = planList[indexPath.row];
            partyCell.partyDateLb.text = planDateList[indexPath.row];
            break;
        case 2:
            partyCell.partyNameLb.text = attendList[indexPath.row];
            partyCell.partyDateLb.text = attendDateList[indexPath.row];
            break;
        default:
            break;
        }
        return partyCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath : NSIndexPath = self.partyTableView.indexPathForSelectedRow
        
        
        let detailController = segue.destination as! DetailViewController
        
        switch partySegementedControl.selectedSegmentIndex {
        case 0:
            detailController.name = futureList[indexPath.row];
            detailController.date = futureDateList[indexPath.row];
            break;
        case 1:
            detailController.name = planList[indexPath.row];
            detailController.date = planDateList[indexPath.row];
            break;
        case 2:
            detailController.name = attendList[indexPath.row];
            detailController.date = attendDateList[indexPath.row];
            break;
        default:
            break;
        }
    }

    @IBAction func addBtnTapped(_ sender: Any) {
    }

    @IBAction func segmentedControlActionChanged(_ sender: Any) {
        partyTableView.reloadData()
    }
    
    @IBAction func refreshBtnTapped(_ sender: Any) {
        partyTableView.reloadData()
    }

}

