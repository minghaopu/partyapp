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
    
    
    
    
//    let futureList:[String] = ["future item 1", "future item 2"];
//    let futureDateList:[String] = ["2016/2/2","2016/2/3"];
//    let planList:[String] = ["plan item 1", "plan item 2", "plan item 3"];
//    let planDateList:[String] = ["2016/2/2","2016/2/3","2016/2/4"];
//    let attendList:[String] = ["attend item 1", "attend item 2", "attend item 3", "attend item 4"];
//    let attendDateList:[String] = ["2016/2/2","2016/2/3","2016/2/4","2016/2/5"];
    
    var totalParties:[Party]?
    var futureParties:[Party]?
    var planParties:[Party]?
    var attendParties:[Party]?
    
    let persistance = Persistance()
    
    var futureMap = [Int: Int]()
    var planMap = [Int: Int]()
    var attendMap = [Int: Int]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        totalParties = persistance.fetchParties()
        //create three list;
        let currentDateTime = Date()
        var planIndex = 0
        var attendedIndex = 0
        var futureIndex = 0
        
        futureParties = []
        planParties = []
        attendParties = []
        
        for i in 0 ..< (totalParties?.count)! {
            let party = totalParties?[i]
            if party?.willAttend == true {
                planParties?.append(party!)
                planMap[planIndex] = i
                planIndex += 1
                if (party?.startDate)! < currentDateTime {
                    attendParties?.append(party!)
                    attendMap[attendedIndex] = i
                    attendedIndex += 1
                }
            } else {
                futureParties?.append(party!);
                futureMap[futureIndex] = i
                futureIndex += 1
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnVal = 0
        switch partySegementedControl.selectedSegmentIndex {
        case 0:
            returnVal = (futureParties?.count)!;
            break
        case 1:
            returnVal = (planParties?.count)!;
            break
        case 2:
            returnVal = (attendParties?.count)!;
            break
        default:
            break
        }
        return returnVal
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let partyCell = tableView.dequeueReusableCell(withIdentifier: "partyCell", for: indexPath) as! PartiesTableViewCell
        var party : Party?
        switch partySegementedControl.selectedSegmentIndex {
        case 0:
            party = (futureParties?[indexPath.row])!
            break;
        case 1:
            party = (planParties?[indexPath.row])!
            break;
        case 2:
            party = (attendParties?[indexPath.row])!

            break;
        default:
            break;
        }
        partyCell.partyNameLb.text = party?.name
//        partyCell.partyDateLb.text = party.date
        return partyCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddParty"
        {
            return;
        }
        let indexPath : IndexPath = self.partyTableView.indexPathForSelectedRow!
        
        let detailController = segue.destination as! DetailViewController
        
        switch partySegementedControl.selectedSegmentIndex {
        case 0:
            detailController.index = futureMap[indexPath.row]
//            detailController.name = futureList[indexPath.row];
//            detailController.date = futureDateList[indexPath.row];
            break;
        case 1:
            detailController.index = planMap[indexPath.row]
//            detailController.name = planList[indexPath.row];
//            detailController.date = planDateList[indexPath.row];
            break;
        case 2:
            detailController.index = attendMap[indexPath.row]
//            detailController.name = attendList[indexPath.row];
//            detailController.date = attendDateList[indexPath.row];
            break;
        default:
            break;
        }
    }

    @IBAction func addBtnTapped(_ sender: Any) {
    }

    @IBAction func segmentedControlActionChanged(_ sender: Any) {
//        self.viewDidLoad();
        partyTableView.reloadData()
    }
    
    @IBAction func refreshBtnTapped(_ sender: Any) {
        self.viewDidLoad()
        partyTableView.reloadData()
    }

}

