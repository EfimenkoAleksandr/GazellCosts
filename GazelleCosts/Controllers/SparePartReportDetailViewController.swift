//
//  SparePartReportDetailViewController.swift
//  GazelleCosts
//
//  Created by user on 12/14/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SparePartReportDetailViewController: UIViewController {
    
    @IBOutlet weak var reportDetail: UITableView!
    
    var masivChoisePart = [MasivChoiceParts]()
    var masivStrPrice: [String] = []
    var masivStrName = ["Лена", "Вася", "Текущий месяц", "Прошлый месяц Лена", "Прошлый месяц Вася", "Прошлый месяц"]
    var firstSeller = ""
    var secondSeller = ""
    var curentMonth = ""
    var lastMonthFirstSeller = ""
    var lastMonthSecondSeller = ""
    var lastMonth = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        reportDetail.dataSource = self
        reportDetail.delegate = self
        
        if let masivCP = CoreDataManager.sharedManager.fetchAllMasivChoiseParts() {
            self.masivChoisePart = masivCP
        }
        
        DispatchQueue.global(qos: .utility).async {
            self.calck()
    
            self.masivStrPrice = [self.firstSeller, self.secondSeller, self.curentMonth, self.lastMonthFirstSeller, self.lastMonthSecondSeller, self.lastMonth]
        }
        
       HelperMethods.shared.setBackGround(view: self.view, tableView: self.reportDetail)
    }
    
    private func calck() {
        self.firstSeller = HelperMethods.shared.countTheSellerForTheMonth(masiv: self.masivChoisePart, seller: "l")
        self.secondSeller = HelperMethods.shared.countTheSellerForTheMonth(masiv: self.masivChoisePart, seller: "v")
        self.curentMonth = HelperMethods.shared.allMasivChoisePart(masiv: self.masivChoisePart)
        
        if let selerL = UserDefaults.standard.object(forKey: "lastMonthForSellerL") {
        self.lastMonthFirstSeller = selerL as! String
        } else { self.lastMonthFirstSeller = "0" }
        
        if let selerv = UserDefaults.standard.object(forKey: "lastMonthForSellerv") {
            self.lastMonthSecondSeller = selerv as! String
        } else { self.lastMonthSecondSeller = "0"}
        
        if let seler = UserDefaults.standard.object(forKey: "lastMonth") {
            self.lastMonth = seler as! String
        } else { self.lastMonth = "0"}
    }
}
    
extension SparePartReportDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.masivStrName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportDetail", for: indexPath)
        
        
        cell.textLabel?.text = self.masivStrName[indexPath.row]
        cell.detailTextLabel?.text = self.masivStrPrice[indexPath.row]
        cell.imageView?.image = UIImage(named: "part")
        cell.layer.cornerRadius = 12.0
        cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        return cell
    }
}
