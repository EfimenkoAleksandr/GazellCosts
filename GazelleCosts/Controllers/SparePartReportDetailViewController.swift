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

    override func viewDidLoad() {
        super.viewDidLoad()
        reportDetail.dataSource = self
        reportDetail.delegate = self
        
        if let masivCP = CoreDataManager.sharedManager.fetchAllMasivChoiseParts() {
            self.masivChoisePart = masivCP
        }
        
       HelperMethods.shared.setBackGround(view: self.view, tableView: self.reportDetail)
    }
    
    private func calck(_ number: Int) -> String {
        
        var rezult = ""
        switch number {
        case 0:
            rezult = HelperMethods.shared.countTheSellerForTheMonth(masiv: self.masivChoisePart, seller: "l")
            break
        case 1:
            rezult = HelperMethods.shared.countTheSellerForTheMonth(masiv: self.masivChoisePart, seller: "v")
            break
        case 2:
            rezult = HelperMethods.shared.allMasivChoisePart(masiv: self.masivChoisePart)
            break
        case 3:
            if let selerL = UserDefaults.standard.object(forKey: "lastMonthForSellerL") {
                rezult = selerL as! String
            } else { rezult = "0" }
            break
        case 4:
            if let selerv = UserDefaults.standard.object(forKey: "lastMonthForSellerv") {
                rezult = selerv as! String
            } else { rezult = "0"}
            break
        case 5:
            if let seler = UserDefaults.standard.object(forKey: "lastMonth") {
                rezult = seler as! String
            } else { rezult = "0"}
            break
        default:
            print("error")
        }
       // print("Func Calk")
        return rezult
    }
}
    
extension SparePartReportDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.masivStrName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportDetail", for: indexPath)
        
        cell.textLabel?.text = self.masivStrName[indexPath.row]
        cell.imageView?.image = UIImage(named: "part")
        cell.layer.cornerRadius = 12.0
        cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        var rezultCalk = ""
        
        DispatchQueue.global(qos: .utility).async {
            rezultCalk = self.calck(indexPath.row)
            
            DispatchQueue.main.async {
                cell.detailTextLabel?.text = rezultCalk
                //print("main.detail")
            }
        }
       //print("cell \(indexPath.row)")
        return cell
    }
}
