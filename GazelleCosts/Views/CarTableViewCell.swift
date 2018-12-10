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
    
//    var cardView: UIView!

//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.setupCardView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    fileprivate func setupCardView() {
//        self.backgroundColor = UIColor.orange
//        self.selectionStyle = .none
//        self.layer.cornerRadius = 12.0
    

//        let newCardView = UIView()
//        newCardView.backgroundColor = UIColor.orange
//        newCardView.layer.cornerRadius = 12.0
//        newCardView.translatesAutoresizingMaskIntoConstraints = false
//        self.cardView = newCardView
//        self.addSubview(newCardView)
//
//        NSLayoutConstraint.activate([
//            newCardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
//            newCardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
//            newCardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
//            newCardView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//            ])
 //   }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.selectionStyle = .none
        self.layer.cornerRadius = 12.0

        // Configure the view for the selected state
    }

}
