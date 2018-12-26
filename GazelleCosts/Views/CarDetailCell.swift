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
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 2
            super.frame = frame
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
        self.layer.cornerRadius = 10.0
        self.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        // Configure the view for the selected state
    }

}
