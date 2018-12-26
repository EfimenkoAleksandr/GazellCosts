//
//  CarViewController.swift
//  GazelleCosts
//
//  Created by mac on 20.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {
    
    @IBOutlet weak var carsTableView: UITableView!
    
    var cars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
               
        carsTableView.dataSource = self
        carsTableView.delegate = self
        
        title = "Cars"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"carForBar"), style: .plain, target: self, action: #selector(setupBarButton))
        
        DispatchQueue.global(qos: .utility).async {
            HelperMethods.shared.newMonth()
        }
        HelperMethods.shared.setBackGround(view: self.view, tableView: self.carsTableView)
        
//        carsTableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        
    }
    
    @objc func setupBarButton(){
        let alert1 = UIAlertController(title: "Name", message: "Enter name", preferredStyle: UIAlertControllerStyle.alert)
        
        alert1.addTextField { (textField) in
            textField.placeholder = "name"
        }
        alert1.addTextField { (textField) in
            textField.placeholder = "subname"
        }
        alert1.addTextField { (textField) in
            textField.placeholder = "number"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default) { (action) in
            if let nameTextFild = alert1.textFields?[0].text, let subNameTextFild = alert1.textFields?[1].text, let numderTextFild = alert1.textFields?[2].text {
                CoreDataManager.sharedManager.saveCar(name: nameTextFild, subName: subNameTextFild, number: numderTextFild)
                
                if let carFetches = CoreDataManager.sharedManager.fetchAllCars() {
                    self.cars = carFetches
                }
                self.carsTableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert1.addAction(saveAction)
        alert1.addAction(cancelAction)
        present(alert1, animated: true, completion: nil)
    }
    
}

extension CarViewController: UITableViewDataSource, UITableViewDelegate {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell") as! CarTableViewCell
        cell.name.text = cars[indexPath.row].name
        cell.subname.text = cars[indexPath.row].subName
        cell.number.text = cars[indexPath.row].number
        
        cell.backgroundColor = indexPath.row%2 == 0 ? #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1) : #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        CoreDataManager.sharedManager.delete(cars[indexPath.row])
        self.cars = CoreDataManager.sharedManager.fetchAllCars()!
        self.carsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let carFetches = CoreDataManager.sharedManager.fetchAllCars() {
            self.cars = carFetches
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = self.cars[indexPath.row]
        performSegue(withIdentifier: "CarDetail", sender: car)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CarDetail" {
            if let carDetail = segue.destination as? CarDetailViewController {
                if let car = sender as? Car {
                    carDetail.titleCar = car.number!
                    carDetail.curentCar = car
                }
            }
        }
        
    }
    
}
