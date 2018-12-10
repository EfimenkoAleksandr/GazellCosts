//
//  CoreDataManager.swift
//  GazelleCosts
//
//  Created by mac on 11.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
   
    static let sharedManager = CoreDataManager()
 
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "GazelleCosts")
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: Car
    
    func saveCar(name: String, subName: String, number : String) {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Car", in: managedContext)!
        
        let car = NSManagedObject(entity: entity, insertInto: managedContext)
        
        car.setValue(name, forKeyPath: "name")
        car.setValue(subName, forKeyPath: "subName")
        car.setValue(number, forKey: "number")
       
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func insertCar(name: String, subName: String, number : String)->Car? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Car", in: managedContext)!
        
        let car = NSManagedObject(entity: entity, insertInto: managedContext)
        
        car.setValue(name, forKeyPath: "name")
        car.setValue(number, forKeyPath: "number")
        car.setValue(subName, forKey: "subName")
        
        do {
            try managedContext.save()
            return car as? Car
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func updateCar(name: String, subName: String, number : String, car : Car) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
       
            car.setValue(name, forKey: "name")
            car.setValue(number, forKey: "number")
            car.setValue(subName, forKey: "subName")
            
//            print("\(String(describing: car.value(forKey: "name")))")
//            print("\(String(describing: car.value(forKey: "ssn")))")
        
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
        
    }
    
    func updateCar(property: String, car : Car) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        //let carDetail = self.saveCarDetail(property)
        
        let entity = NSEntityDescription.entity(forEntityName: "CarDetail", in: context)!
        
        let carDetail = NSManagedObject(entity: entity, insertInto: context)
        
        carDetail.setValue(property, forKeyPath: "propertyCar")
        carDetail.setValue(HelperMethods.shared.curentDate(), forKeyPath: "dateOfBirth")
        
        car.addToCarDetail(carDetail as! CarDetail)
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    
    func delete( _ car : Car){
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
            managedContext.delete(car)
        
        do {
            try managedContext.save()
        } catch {
        }
    }
    
    func fetchAllCars() -> [Car]?{
 
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Car")
        
        do {
            let car = try managedContext.fetch(fetchRequest)
            return car as? [Car]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }
    
    func delete(number: String) -> [Car]? {
       
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
      
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Car")
        
        fetchRequest.predicate = NSPredicate(format: "name == %i" ,number)
        do {
           
            let item = try managedContext.fetch(fetchRequest)
            var removedCar = [Car]()
            for i in item {
                managedContext.delete(i)
                try managedContext.save()
                removedCar.append(i as! Car)
            }
            return removedCar
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }
    
    //-------------------------------------------------------------------------------------------
    //MARK: ChoicePart
    
    func fetchAllChoisePart() -> [ChoicePart]?{
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ChoicePart")
        
        do {
            let part = try managedContext.fetch(fetchRequest)
            return part as? [ChoicePart]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
    }
    
    func saveChoicePart(name: String, count: String, price: String, seller: String) {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ChoicePart", in: managedContext)!
        
        let choicePart = NSManagedObject(entity: entity, insertInto: managedContext)
        
        choicePart.setValue(name, forKeyPath: "name")
        choicePart.setValue(count, forKeyPath: "count")
        choicePart.setValue(price, forKey: "price")
        choicePart.setValue(seller, forKey: "seller")
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateChoisePart(count: String, price : String, seller: String, choisePart : ChoicePart) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        choisePart.setValue(count, forKey: "count")
        choisePart.setValue(price, forKey: "price")
        choisePart.setValue(seller, forKey: "seller")
        
//        print("\(String(describing: choisePart.value(forKey: "name")))")
//        print("\(String(describing: choisePart.value(forKey: "price")))")
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    
    func deleteChoisePart( _ choisePart : ChoicePart) {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        managedContext.delete(choisePart)
        
        do {
            try managedContext.save()
        } catch {
        }
    }
    
    func deleteAllChoisePart() {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ChoicePart")
        
        do {
            let parts = try managedContext.fetch(fetchRequest)
            for part in parts {
                managedContext.delete(part)
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")

        }
    }
    
    //------------------------------------------------------------------------------------
    //MARK: MasivChoiceParts
    
    func insertMasivChoiseParts() -> MasivChoiceParts? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "MasivChoiceParts", in: managedContext)!
        
        let masivChoiceParts = NSManagedObject(entity: entity, insertInto: managedContext)
        
        let curentDate = HelperMethods.shared.curentDate()
//        print(HelperMethods.shared.dateFirstDay())
        masivChoiceParts.setValue(curentDate, forKeyPath: "dateCreation")
        masivChoiceParts.setValue(false, forKey: "expanded")
        
        do {
            try managedContext.save()
            return masivChoiceParts as? MasivChoiceParts
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func saveMasivChoiseParts(masiv: [ChoicePart]) {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let masivCP = CoreDataManager.sharedManager.insertMasivChoiseParts()
        
        for choicePart in masiv {
            
            let entity = NSEntityDescription.entity(forEntityName: "ForSaveChoisePart", in: managedContext)!
            let forChoicePart = NSManagedObject(entity: entity, insertInto: managedContext)

            forChoicePart.setValue(choicePart.name!, forKeyPath: "name")
            forChoicePart.setValue(choicePart.count!, forKeyPath: "count")
            forChoicePart.setValue(choicePart.price!, forKey: "price")
            forChoicePart.setValue(choicePart.seller, forKey: "seller")

            masivCP?.addToForSaveCP(forChoicePart as! ForSaveChoisePart)
            
        }
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchAllMasivChoiseParts() -> [MasivChoiceParts]? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MasivChoiceParts")
        
        do {
            let allMasivChoiseParts = try managedContext.fetch(fetchRequest)
            return allMasivChoiseParts as? [MasivChoiceParts]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func deleteMasivChoiseParts( _ masivChoisePart : MasivChoiceParts) {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        managedContext.delete(masivChoisePart)
        
        do {
            try managedContext.save()
        } catch {
        }
    }
    
    func deleteAllMasivChoiseParts() {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MasivChoiceParts")
        
        do {
            let masivChoiceParts = try managedContext.fetch(fetchRequest)
            for part in masivChoiceParts {
                managedContext.delete(part)
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
    }
    
    //-----------------------------------------------------------------------------------
    //MARK: CarDetail
    
    func saveCarDetail(_ name: String) -> CarDetail {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CarDetail", in: managedContext)!
        
        let carDetail = NSManagedObject(entity: entity, insertInto: managedContext)
        
        carDetail.setValue(name, forKeyPath: "propertyCar")
        carDetail.setValue(HelperMethods.shared.curentDate(), forKeyPath: "dateOfBirth")
        print(HelperMethods.shared.dateFirstDay())
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return carDetail as! CarDetail
    }

    func deleteCarDetail( _ carDetail : CarDetail) {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        managedContext.delete(carDetail)
        
        do {
            try managedContext.save()
        } catch {
        }
    }
    
}
