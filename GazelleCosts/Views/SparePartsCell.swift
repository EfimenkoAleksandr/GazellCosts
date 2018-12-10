//
//  SparePartsCell.swift
//  GazelleCosts
//
//  Created by mac on 09.10.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SparePartsCell: UICollectionViewCell {
    
    @IBOutlet weak var partImageView: UIImageView!
    
    func configureCell(_ string: String) {
      
        let imagePhoto = UIImage(named: string)
        if imagePhoto != nil {
        partImageView.image = imagePhoto
        self.partImageView.layer.cornerRadius = 12.0
            self.partImageView.layer.masksToBounds = true
        }
    }
    
        
    
}
