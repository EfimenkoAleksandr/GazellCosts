//
//  SelectedItemsTableViewCell.swift
//  GazelleCosts
//
//  Created by mac on 24.10.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SelectedItemsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var selectedNameLabel: UILabel!
    @IBOutlet weak var selectedCountLabel: UILabel!
    @IBOutlet weak var selectedPriceLabel: UILabel!

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
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        //self.backgroundColor = UIColor.orange
        self.selectionStyle = .none
        self.layer.cornerRadius = 12.0
        self.selectedImageView.layer.cornerRadius = 12.0
        
        // Configure the view for the selected state
    }

}
