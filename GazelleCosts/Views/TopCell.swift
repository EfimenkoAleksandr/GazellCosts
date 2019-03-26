//
//  TopCell.swift
//  GazelleCosts
//
//  Created by user on 12/28/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class TopCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var manufakturerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sellerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.nameLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, width: nil, pading: .init(top: 0, left: 8, bottom: 0, right: contentView.frame.width / 2), size: .init(width: contentView.frame.width / 2 - 8, height: self.contentView.frame.height))
//
//        let stack = UIStackView(arrangedSubviews: [self.sellerLabel, self.manufakturerLabel, self.priceLabel])
//        stack.alignment = .fill
//        stack.distribution = .fillEqually
//        stack.spacing = 8
//        addSubview(stack)
//        stack.anchor(top: contentView.topAnchor, leading: self.nameLabel.trailingAnchor, bottom: self.nameLabel.bottomAnchor, trailing: contentView.trailingAnchor, pading: .init(top: 0, left: 8, bottom: 0, right: 8))
//
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //Configure the view for the selected state
        
        self.sellerLabel.textAlignment = .center
        self.manufakturerLabel.textAlignment = .center
        self.priceLabel.textAlignment = .center
        
    }
    
    
}

//extension UIStackView {
//
//    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, pading: UIEdgeInsets = .zero) {
//        translatesAutoresizingMaskIntoConstraints = false
//
//        if let top = top {
//            topAnchor.constraint(equalTo: top, constant: pading.top).isActive = true
//        }
//        if let leading = leading {
//            leadingAnchor.constraint(equalTo: leading, constant: pading.left).isActive = true
//        }
//        if let bottom = bottom {
//            bottomAnchor.constraint(equalTo: bottom, constant: pading.bottom).isActive = true
//        }
//        if let trailing = trailing {
//            trailingAnchor.constraint(equalTo: trailing, constant: pading.right).isActive = true
//        }
//    }
//
//}
//
//extension UILabel {
//    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, width: NSLayoutDimension?, pading: UIEdgeInsets = .zero, size: CGSize = .zero) {
//
//        translatesAutoresizingMaskIntoConstraints = false
//
//        if let top = top {
//            topAnchor.constraint(equalTo: top, constant: pading.top).isActive = true
//        }
//        if let leading = leading {
//            leadingAnchor.constraint(equalTo: leading, constant: pading.left).isActive = true
//        }
//        if let bottom = bottom {
//            bottomAnchor.constraint(equalTo: bottom, constant: pading.bottom).isActive = true
//        }
//        if let trailing = trailing {
//            trailingAnchor.constraint(equalTo: trailing, constant: pading.right).isActive = true
//        }
//
//        if let width = width {
//            widthAnchor.constraint(equalTo: width, multiplier: 1000, constant: size.width).isActive = true
//        }
//
//        if size.width != 0 {
//            widthAnchor.constraint(equalToConstant: size.width).isActive = true
//        }
//        if size.height != 0 {
//            heightAnchor.constraint(equalToConstant: size.height).isActive = true
//        }
//    }
//
//}

