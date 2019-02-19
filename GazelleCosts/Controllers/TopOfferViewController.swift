//
//  TopOfferViewController.swift
//  GazelleCosts
//
//  Created by user on 12/27/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class TopOfferViewController: UIViewController {
    
    @IBOutlet weak var topOfferTable: UITableView!
    
    let masivCategory = categoriParts
    let masivPart = categoriPartsName
    var masivExtendedCurent = masivExtended
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topOfferTable.dataSource = self
        topOfferTable.delegate = self
        
        var i = self.masivCategory.count
        while i >= 0 {
            i = i - 1
            self.masivExtendedCurent.append(false)
        }
        HelperMethods.shared.setBackGround(view: self.view, tableView: self.topOfferTable)
    }
    
}

extension TopOfferViewController: UITableViewDataSource, UITableViewDelegate, ExpandebleHeaderViewDelegate {
    
    //MARK: UICollectionViewDataSourse
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.masivCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.masivPart[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopOfferCell", for: indexPath) as! TopCell
        
        let masivPart = self.masivPart[indexPath.section]
        cell.nameLabel.text = masivPart[indexPath.row]
        
        if let part = HelperMethods.shared.findLastPrice(part: masivPart[indexPath.row]) {
            cell.sellerLabel.text = part.seller
            cell.manufakturerLabel.text = part.manufacturer
            cell.priceLabel.text = part.price
        } else {
            cell.sellerLabel.text = ""
            cell.manufakturerLabel.text = ""
            cell.priceLabel.text = ""
        }
        cell.layer.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.masivExtendedCurent[indexPath.section] {
            return 44
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandebleHeaderView()
        header.setup(withTitle: self.masivCategory[section], section: section, delegate: self)
        return header
    }
    
    //MARK: toggleSection
    
    func toggleSection(header: ExpandebleHeaderView, section: Int) {
        self.masivExtendedCurent[section] = !self.masivExtendedCurent[section]
        
        topOfferTable.beginUpdates()
        for row in 0..<self.masivPart[section].count {
            topOfferTable.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        topOfferTable.endUpdates()
        
    }
    
}
