//
//  HelperMetodsPars.swift
//  GazelleCosts
//
//  Created by mac on 31.01.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import Parse

class HelperMetodsPars {
    
    static let shared = HelperMetodsPars()
    
    func saveMyCar() {
        if let masivCars = CoreDataManager.sharedManager.fetchAllCars() {
            let cars = masivCars
            
            for curentCar in cars {
                if curentCar.keySave == true {
                    let car = PFObject(className: "MyCar")
                    car["name"] = curentCar.name
                    car["subName"] = curentCar.subName
                    car["number"] = curentCar.number
                    
                    let masivCarDetail = curentCar.carDetail?.allObjects as! [CarDetail]
                    var mas = [[String]]()
                    for masiv in masivCarDetail {
                        mas.append([masiv.propertyCar!, masiv.dateOfBirth!])
                    }
                    car["masiv"] = mas
                    
                    // Saves the new object.
                    car.saveInBackground {
                        (success: Bool, error: Error?) in
                        if (success) {
                            // The object has been saved.
                            print("Pars saved")
                        } else {
                            print("no saved")
                            // There was a problem, check error.description
                        }
                    }
                    CoreDataManager.sharedManager.updateCar(name: nil, subName: nil, number: nil, bool: false, car: curentCar)
                }
            }
        }
    }
    
    
    func fetchCar() {
        
        var masivCars = [Car]()
        if let masCars = CoreDataManager.sharedManager.fetchAllCars() {
            masivCars = masCars
        }
        
        let query = PFQuery(className: "MyCar")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                // There was no error in the fetch
                if let returnedobjects = objects {
                    
                    for object in returnedobjects {
                        var carBool = true
                        if masivCars.count > 0 {
                            for car in masivCars {
                                if car.name == (object.value(forKey: "name") as! String) && car.subName == (object.value(forKey: "subName") as! String) && car.number == (object.value(forKey: "number") as! String) {
                                    carBool = false
                                    break
                                }
                            }
                        }
                        if carBool {
                            CoreDataManager.sharedManager.saveCar(name: object.value(forKey: "name") as! String, subName: object.value(forKey: "subName") as! String, number: object.value(forKey: "number") as! String)
                        }
                    }
                }
            }
        }
    }
    
    func deleteCar() {
        let query = PFQuery(className: "MyCar")
        
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                if let returnedobjects = objects {
                    for object in returnedobjects {
                        object.deleteInBackground()
                        print("object delete")
                    }
                }
            }
        }
    }
    
    func fetchDetailCar(car: Car, tableView: UITableView) -> [CarDetail]? {
        
        var masivCarStr = [CarDetail]()
        let query = PFQuery(className: "MyCar")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                // There was no error in the fetch
                if let returnedobjects = objects {
                    for object in returnedobjects {
                        if object.value(forKey: "name") as? String == car.name && object.value(forKey: "subName") as? String == car.subName && object.value(forKey: "number") as? String == car.number {
                            if (object.value(forKey: "masiv") != nil) {
                                let masiv = object.value(forKey: "masiv") as! [[String]]
                                for carDetail in masiv {
                                    CoreDataManager.sharedManager.updateCar(property: carDetail[0], date: carDetail[1], car: car)
                                }
                                if let detailCarFetches = car.carDetail?.allObjects {
                                    masivCarStr = detailCarFetches as! [CarDetail]
                                    tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        }
        return masivCarStr
    }
    
}
