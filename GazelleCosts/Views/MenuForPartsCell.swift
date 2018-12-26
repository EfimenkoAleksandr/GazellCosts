//
//  MenuForPartsCell.swift
//  GazelleCosts
//
//  Created by user on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class MenuForPartsCell: UITableViewCell {

    @IBOutlet weak var nameImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
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
        
        
        // Configure the view for the selected state
    }

}
