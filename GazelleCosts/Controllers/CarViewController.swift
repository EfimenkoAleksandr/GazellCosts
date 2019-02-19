//
//  CarViewController.swift
//  GazelleCosts
//
//  Created by mac on 20.09.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Parse

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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"carForBar"), style: .plain, target: self, action: #selector(setupBarButton))
        
        self.setButton()
        
        DispatchQueue.global(qos: .utility).async {
            HelperMethods.shared.newMonth()
        }
        
    }
    
    //MARK: SetapButton for left button
    
    private func setButton() {
        let button =  UIButton(type: .custom)
        button.setImage(UIImage(named: "internet"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 31)
        button.addTarget(self, action: #selector(self.tapped), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func setupBarButton(){
        let alert1 = UIAlertController(title: "Name", message: "Enter name", preferredStyle: UIAlertController.Style.alert)
        
        alert1.addTextField { (textField) in
            textField.placeholder = "name"
        }
        alert1.addTextField { (textField) in
            textField.placeholder = "subname"
        }
        alert1.addTextField { (textField) in
            textField.placeholder = "number"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default) { (action) in
            if let nameTextFild = alert1.textFields?[0].text, let subNameTextFild = alert1.textFields?[1].text, let numderTextFild = alert1.textFields?[2].text {
                CoreDataManager.sharedManager.saveCar(name: nameTextFild, subName: subNameTextFild, number: numderTextFild)
                
                self.reloadMyTable()
            }
        }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert1.addAction(saveAction)
        alert1.addAction(cancelAction)
        present(alert1, animated: true, completion: nil)
    }
    
    //MARK: Set background for ViewController
    
    override func viewWillLayoutSubviews() {
        HelperMethods.shared.setBackGround(view: self.view, tableView: self.carsTableView)
    }
    
    //MARK: PopOverViewController for left button
    
    @objc private func tapped() {
        
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopOverForCar") else { return }
        popVC.modalPresentationStyle = .popover
        let popOverVC  = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.navigationItem.rightBarButtonItem?.customView
        popOverVC?.sourceRect = CGRect(x: (navigationItem.rightBarButtonItem?.customView?.bounds.midX)!, y: (self.navigationItem.rightBarButtonItem?.customView?.bounds.minY)!, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 200, height: 200)
        
        self.present(popVC, animated: true)
        
    }
    
}

extension CarViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UICollectionViewDataSourse
    
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
    
    //MARK: UICollectionViewDelegate
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        CoreDataManager.sharedManager.delete(cars[indexPath.row])
        self.cars = CoreDataManager.sharedManager.fetchAllCars()!
        self.carsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.reloadMyTable()
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.reloadMyTable()
    }
    
    func reloadMyTable() {
        if let carFetches = CoreDataManager.sharedManager.fetchAllCars() {
            if carFetches.count > 0 {
                self.cars = carFetches
                self.carsTableView.reloadData()
            }
        }
    }
    
}

extension CarViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
