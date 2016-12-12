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
    

    
    var totalParties:[Party]?
    var planParties:[Party]?
    var attendParties:[Party]?
    
    let persistance = Persistance()
    
    var planMap = [Int: Int]()
    var attendMap = [Int: Int]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        totalParties = persistance.fetchParties()
        let currentDateTime = Date()
        var planIndex = 0
        var attendedIndex = 0
        
        planParties = [] // for parties which users decide to go
        attendParties = [] // for parties which users have already been to
        
        // create dictionay for mapping view index to actual index;
        for i in 0 ..< (totalParties?.count)! {
            let party = totalParties?[i]
            if party?.willAttend == true {
                planParties?.append(party!)
                planMap[planIndex] = i
                planIndex += 1

                if  (party?.startDate)! < currentDateTime {
                    attendParties?.append(party!)
                    attendMap[attendedIndex] = i
                    attendedIndex += 1
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
            returnVal = (totalParties?.count)!;
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
            party = (totalParties?[indexPath.row])!
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
        
        // create date formater to transform date to string
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd"
        let datestr = dformatter.string(from: (party?.startDate)!)
        
        partyCell.partyDateLb.text = datestr
        return partyCell
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // delete row;
        var index = -1
        // map index in view to actual data index;
        switch partySegementedControl.selectedSegmentIndex {
        case 0:
            index = indexPath.row
            break;
        case 1:
            index = planMap[indexPath.row]!
            break;
        case 2:
            index = attendMap[indexPath.row]!
            break;
        default:
            break;
        }
        if editingStyle == .delete {
            persistance.deleteParty(index: index)
            self.viewDidLoad()
            partyTableView.reloadData()
        }
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
            detailController.index = indexPath.row
            break;
        case 1:
            detailController.index = planMap[indexPath.row]
            break;
        case 2:
            detailController.index = attendMap[indexPath.row]
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
        self.viewDidLoad()
        partyTableView.reloadData()
    }

}

