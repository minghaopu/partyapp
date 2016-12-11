//
//  PartiesTableViewCell.swift
//  PartyApp
//
//  Created by XYZ on 2016/12/11.
//  Copyright © 2016年 CSCI-6907-Minghao Pu. All rights reserved.
//

import UIKit

class PartiesTableViewCell: UITableViewCell {

    @IBOutlet weak var partyNameLb: UILabel!
    @IBOutlet weak var partyDateLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
