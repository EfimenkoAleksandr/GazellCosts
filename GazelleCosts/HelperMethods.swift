//
//  HelperMethods.swift
//  GazelleCosts
//
//  Created by mac on 09.11.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit

class HelperMethods {
    
    static let shared = HelperMethods()
    
    //    -------------------------------------------------------------------------------------
    //MARK: CoreDataManager

func curentDate() -> String {
    
    let date = Date()
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "yyyy/MM/dd HH:mm"
    let dateString = dateFormater.string(from: date)
    
    return dateString
}
  
//    -------------------------------------------------------------------------------------
    //MARK: SparePartsReportViewController
    
    func calkulateCurentParts(parts: MasivChoiceParts) -> String {
        var price = 0
        if let partCalk = parts.forSaveCP?.allObjects {
            for part in partCalk {
                price += (Int((part as! ForSaveChoisePart).price!)! * Int((part as! ForSaveChoisePart).count!)!)
            }
        }
        return price.description
    }

    func allMasivChoisePart(masiv: [MasivChoiceParts]) -> String {
        var priceAllParts = 0
        for part in masiv {
            priceAllParts += Int(self.calkulateCurentParts(parts: part))!
        }
        
        return priceAllParts.description
    }
    
    func calkulateSeller(part: MasivChoiceParts, seller: String) -> String {
        var price = 0
        if let partCalk = part.forSaveCP?.allObjects {
            for part in partCalk {
                if (part as! ForSaveChoisePart).seller == seller {
                    price += (Int((part as! ForSaveChoisePart).price!)! * Int((part as! ForSaveChoisePart).count!)!)
                }
            }
        }
        
        return price.description
    }
    
    func countTheSellerForTheMonth(masiv: [MasivChoiceParts], seller: String) -> String {
        var priceAllSeller = 0
        for masivCP in masiv {
            priceAllSeller += Int(self.calkulateSeller(part: masivCP, seller: seller))!
        }
        return priceAllSeller.description
    }
    
    //    -------------------------------------------------------------------------------------
    //MARK: CarViewController
    
    func saveFirstEnter() {
        
    }
    
    func curentMonthAndYear() -> (String, String) {
        let date = Date()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM"
        let dateStringMonth = dateFormater.string(from: date)
        let dateFormater2 = DateFormatter()
        dateFormater2.dateFormat = "yyyy"
        let dateStringYear = dateFormater2.string(from: date)
        return (dateStringMonth, dateStringYear)
    }
    
    func newMonth(){
        if self.curentMonthAndYear() == ("01", "2018") {
            let lastMonth = self.allMasivChoisePart(masiv: CoreDataManager.sharedManager.fetchAllMasivChoiseParts()!)
            UserDefaults.standard.set(lastMonth, forKey: "lastMonth")
            
            let lastMonthForSellerL = self.countTheSellerForTheMonth(masiv: CoreDataManager.sharedManager.fetchAllMasivChoiseParts()!, seller: "l")
            UserDefaults.standard.set(lastMonthForSellerL, forKey: "lastMonthForSellerL")
            
            let lastMonthForSellerV = self.countTheSellerForTheMonth(masiv: CoreDataManager.sharedManager.fetchAllMasivChoiseParts()!, seller: "v")
            UserDefaults.standard.set(lastMonthForSellerV, forKey: "lastMonthForSellerV")
            
            CoreDataManager.sharedManager.deleteAllMasivChoiseParts()
        }
    }
    
    func findLastPrice(part: String) -> ForSaveChoisePart? {
        
        var masivSave = [ForSaveChoisePart]()
        
        let masivCP = CoreDataManager.sharedManager.fetchAllMasivChoiseParts()
        for masiv in masivCP! {
            let mas = (masiv.forSaveCP?.allObjects)! as! [ForSaveChoisePart]
            for choiceP in mas {
                if choiceP.name == part {
                    
                    masivSave.append(choiceP)
                }
            }
        }
        return masivSave.last
    }
    
    //MARK: PopOverForCar
    
    func createAlert(title: String, message: String, number: Int, controller: UIViewController) -> UIAlertController {
        
        let alert1 = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) { (action) in
            switch number {
            case 0:
                HelperMetodsPars.shared.fetchCar()
                break
            case 1:
                HelperMetodsPars.shared.saveMyCar()
                break
            case 2:
                HelperMetodsPars.shared.deleteCar()
                break
            default:
                print("error")
            }
            
            controller.dismiss(animated: true, completion: nil)
            
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel) { (cancel) in
            controller.dismiss(animated: true, completion: nil)
        }

        alert1.addAction(okAction)
        alert1.addAction(cancelAction)
//        present(alert1, animated: true, completion: nil)

        return alert1
    }
    
    //MARK: SetBackGround
    
    func setBackGround(view: UIView, tableView: UITableView) {
        
        let fon = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        print("with -----------------------\(view.frame.width)")
        print("height -----------------------\(view.frame.height)")
        fon.image = UIImage(named: "gazelBackground")
        fon.contentMode = .scaleAspectFit
        tableView.backgroundView = fon
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        
        let color1 = UIColor.init(red: 0.333, green: 0.333, blue: 0.333, alpha: 1).cgColor
        let color2 = UIColor.init(red: 0.803, green: 0.803, blue: 0.803, alpha: 1).cgColor
        let color3 = UIColor.init(red: 0.333, green: 0.333, blue: 0.333, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [color1, color2, color3]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func createLabel(text: String, cellWidth: CGFloat) -> UILabel {
    
    let label = UILabel()
    label.font = UIFont(name: "Arial-BoldMT", size: 16)
    label.text = text
    label.textAlignment = .center
    label.numberOfLines = 0
    label.textColor = UIColor.black
    label.backgroundColor = UIColor.white
    //cell.addSubview(label)
    
    let maxSize = CGSize(width: cellWidth, height: 20)
    var size = label.sizeThatFits(maxSize)
    if size.width > cellWidth || size.width > cellWidth - 20 {
    size.width = cellWidth - 20
    }
    
    label.frame = CGRect(origin: CGPoint(x: 10, y: 0), size: size)
     
        return label
    }
}
