//
//  CarTableViewCell.swift
//  GazelleCosts
//
//  Created by mac on 20.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var subname: UILabel!
    
    @IBOutlet weak var number: UILabel!
    
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
        
        self.selectionStyle = .none
        self.layer.cornerRadius = 12.0
        
    }
    
}
