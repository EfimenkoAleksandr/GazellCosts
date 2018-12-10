//
//  CarDetailCell.swift
//  GazelleCosts
//
//  Created by user on 26.11.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class CarDetailCell: UITableViewCell {

    @IBOutlet weak var nameProperty: UILabel!
    @IBOutlet weak var dateFounding: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
        self.layer.cornerRadius = 12.0
        // Configure the view for the selected state
    }

}
