//
//  SparePartsReportViewController.swift
//  GazelleCosts
//
//  Created by mac on 09.11.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SparePartsReportViewController: UIViewController, ExpandebleHeaderViewDelegate {

    @IBOutlet weak var reportTableView: UITableView!
    @IBOutlet weak var curentLabel: UILabel!
    @IBOutlet weak var perMonthLabel: UILabel!
    @IBOutlet weak var lastMonthLabel: UILabel!
    
    var masivChoiceParts = [MasivChoiceParts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Report"
      
        if let masivCP = CoreDataManager.sharedManager.fetchAllMasivChoiseParts() {
            self.masivChoiceParts = masivCP
            self.perMonthLabel.text = HelperMethods.shared.allMasivChoisePart(masiv: self.masivChoiceParts)
            if let curLastMonth = UserDefaults.standard.value(forKey: "LastMonth") {
                self.lastMonthLabel.text = curLastMonth as? String
            }
        }
        reportTableView.dataSource = self
        reportTableView.delegate = self
        self.reportTableView.backgroundView = UIImageView(image: UIImage(named: "gray-background"))
        self.reportTableView.separatorStyle = .none
        self.setunNavBar()
        
    }

    func setunNavBar() {
      //  navigationController?.navigationBar.setBackgroundImage(UIImage(named: "gray-background"), for: .default)
       // navigationController?.navigationBar.prefersLargeTitles = true
        let sc = UISearchController(searchResultsController: nil)
        navigationItem.searchController = sc
       // navigationItem.hidesSearchBarWhenScrolling = false
    }

}

extension SparePartsReportViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.masivChoiceParts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let masivCP = self.masivChoiceParts[section].forSaveCP?.count {
            return masivCP
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SparePartReport") as! SparePartReportCell
        
        let masivMCP = self.masivChoiceParts[indexPath.section]
        let masiv = masivMCP.forSaveCP?.allObjects as! [ForSaveChoisePart]
        let choisePart = masiv[indexPath.row]
        
        cell.nameLabel.text = choisePart.name
        cell.countLabel.text = choisePart.count
        cell.priceLabel.text = choisePart.price
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.masivChoiceParts[indexPath.section].expanded {
            return 44
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandebleHeaderView()
        header.setup(withTitle: self.masivChoiceParts[section].dateCreation!, section: section, delegate: self)
        return header
    }
    
    func toggleSection(header: ExpandebleHeaderView, section: Int) {
        self.masivChoiceParts[section].expanded = !self.masivChoiceParts[section].expanded
        self.curentLabel.text = HelperMethods.shared.calkulateCurentParts(parts: self.masivChoiceParts[section])
        
        reportTableView.beginUpdates()
        for row in 0..<(self.masivChoiceParts[section].forSaveCP?.count)! {
            reportTableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        reportTableView.endUpdates()
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        CoreDataManager.sharedManager.deleteMasivChoiseParts(self.masivChoiceParts[indexPath.section])
        self.masivChoiceParts = CoreDataManager.sharedManager.fetchAllMasivChoiseParts()!
        reportTableView.reloadData()
    }
    
    

    
}
