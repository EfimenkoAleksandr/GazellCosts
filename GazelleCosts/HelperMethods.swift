//
//  HelperMethods.swift
//  GazelleCosts
//
//  Created by mac on 09.11.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

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
    
    func dateFirstDay() -> String {
        let date = Date()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd"
        let dateString = dateFormater.string(from: date)
        return dateString
    }
  
//    -------------------------------------------------------------------------------------
    //MARK: SparePartsReportViewController
    
    func calkulateCurentParts(parts: MasivChoiceParts) -> String {
        var price = 0
        if let partCalk = parts.forSaveCP?.allObjects {
            for part in partCalk {
                price += Int((part as! ForSaveChoisePart).price!)!
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
    
    
    
}
