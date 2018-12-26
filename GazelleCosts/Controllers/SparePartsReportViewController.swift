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
    @IBOutlet weak var vasiaLabel: UILabel!
    @IBOutlet weak var lenaLabel: UILabel!
    
    var masivChoiceParts = [MasivChoiceParts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Report"
      
        if let masivCP = CoreDataManager.sharedManager.fetchAllMasivChoiseParts() {
            self.masivChoiceParts = masivCP
        }
        reportTableView.dataSource = self
        reportTableView.delegate = self
        self.reportTableView.backgroundView = UIImageView(image: UIImage(named: "gray-background"))
        self.reportTableView.separatorStyle = .none
        self.setunNavBar()
        
        self.addRightButtonItem()
        HelperMethods.shared.setBackGround(view: self.view, tableView: self.reportTableView)
        self.curentLabel.textColor = .white
        self.vasiaLabel.textColor = .white
        self.lenaLabel.textColor = .white
        
    }
    
    func addRightButtonItem() {
        let button =  UIButton(type: .custom)
        button.setImage(UIImage(named: "statistika"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        //button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonCreate), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 30)//CGRectMake(0, 0, 53, 31)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
}

@objc func buttonCreate() {
    let vc = storyboard?.instantiateViewController(withIdentifier: "SparePartReportDetail") as! SparePartReportDetailViewController
    self.navigationController?.pushViewController(vc, animated: true)
    
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
        cell.sellerLabel.text = choisePart.seller

        if masiv[indexPath.row].seller == "v" {
           cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else if masiv[indexPath.row].seller == "l" {
            cell.backgroundColor = #colorLiteral(red: 0.9091644832, green: 1, blue: 0.5699023115, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        
        
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
        DispatchQueue.global(qos: .utility).async {
        let curentPartInGlobalQueue = HelperMethods.shared.calkulateCurentParts(parts: self.masivChoiceParts[section])
            DispatchQueue.main.async {
                self.curentLabel.text = curentPartInGlobalQueue
            }
        }
        DispatchQueue.global(qos: .utility).async {
            let calkSellerL = HelperMethods.shared.calkulateSeller(part: self.masivChoiceParts[section], seller: "l")
            DispatchQueue.main.async {
                self.lenaLabel.text = calkSellerL
            }
        }
        DispatchQueue.global(qos: .utility).async {
            let calkSellerV = HelperMethods.shared.calkulateSeller(part: self.masivChoiceParts[section], seller: "v")
            DispatchQueue.main.async {
                self.vasiaLabel.text = calkSellerV
            }
        }
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
