//
//  PartCategoriCell.swift
//  GazelleCosts
//
//  Created by mac on 12.10.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class PartCategoriCell: UICollectionViewCell {
    
    @IBOutlet weak var partCategoriImageView: UIImageView!
    
    func configureCell(_ string: String) {
        
        let imagePhoto = UIImage(named: string)
        if imagePhoto != nil {
            partCategoriImageView.image = imagePhoto
            self.partCategoriImageView.layer.cornerRadius = 10.0
            self.partCategoriImageView.layer.masksToBounds = true
        }
    }
    
}
