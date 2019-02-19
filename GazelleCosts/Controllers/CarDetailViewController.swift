//
//  CarDetailViewController.swift
//  GazelleCosts
//
//  Created by user on 22.11.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Parse

class CarDetailViewController: UIViewController {
    
    @IBOutlet weak var detailCar: UITableView!
    
    var titleCar = ""
    var curentCar = Car()
    var masivCarStr = [CarDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "gray-background"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        self.masivCarStr = curentCar.carDetail?.allObjects as! [CarDetail]
        
        detailCar.dataSource = self
        detailCar.delegate = self
        
        title = titleCar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"book"), style: .plain, target: self, action: #selector(setupBarButton))
        navigationItem.rightBarButtonItem?.tintColor = .black
        HelperMethods.shared.setBackGround(view: self.view, tableView: self.detailCar)
        
        let strKey = (self.curentCar.number ?? "name") + (self.curentCar.subName ?? "subName") + (self.curentCar.number ?? "number")
        
        if UserDefaults.standard.value(forKey: strKey) == nil {
            if let masiv = HelperMetodsPars.shared.fetchDetailCar(car: self.curentCar, tableView: self.detailCar) {
                self.masivCarStr = masiv
                self.detailCar.reloadData()
            }
            let number = 1
            UserDefaults.standard.set(number, forKey: strKey)
        } else {
            print("start with mobile DB")
        }
    }
    
    //MARK: Func for left barbutton
    
    @objc func setupBarButton() {
        
        let alert = UIAlertController(title: "Свойство", message: "Введите свойство", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "name"
            
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default) { (action) in
            if let propertyTextFild = alert.textFields?[0].text {
                CoreDataManager.sharedManager.updateCar(property: propertyTextFild, car: self.curentCar)
                
                if let detailCarFetches = self.curentCar.carDetail?.allObjects {
                    self.masivCarStr = detailCarFetches as! [CarDetail]
                }
                self.detailCar.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension CarDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.detailCar.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return masivCarStr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarDetailCell") as! CarDetailCell
        
        cell.nameProperty.text = masivCarStr[indexPath.row].propertyCar
        cell.dateFounding.text = masivCarStr[indexPath.row].dateOfBirth
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        CoreDataManager.sharedManager.deleteCarDetail(self.masivCarStr[indexPath.row])
        self.masivCarStr = curentCar.carDetail?.allObjects as! [CarDetail]
        self.detailCar.reloadData()
    }
    
    
    
    
    
}

    


