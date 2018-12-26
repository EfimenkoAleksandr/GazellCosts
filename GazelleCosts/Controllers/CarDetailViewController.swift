//
//  CarDetailViewController.swift
//  GazelleCosts
//
//  Created by user on 22.11.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class CarDetailViewController: UIViewController {
    
    @IBOutlet weak var detailCar: UITableView!
    
    var titleCar = ""
    var curentCar = Car()
    var masivCarStr = [CarDetail]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "gray-background"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        //navigationController?.navigationBar.tintColor = .black
  
        self.masivCarStr = curentCar.carDetail?.allObjects as! [CarDetail]

        detailCar.dataSource = self
        detailCar.delegate = self
        
        title = titleCar
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"book"), style: .plain, target: self, action: #selector(setupBarButton))
        navigationItem.rightBarButtonItem?.tintColor = .black
        HelperMethods.shared.setBackGround(view: self.view, tableView: self.detailCar)
        
    }
    
    @objc func setupBarButton() {

//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "book")?.withRenderingMode(.alwaysOriginal), for: .normal)
//        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        button.contentMode = .scaleAspectFit
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        let alert = UIAlertController(title: "Свойство", message: "Введите свойство", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "name"
            
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default) { (action) in
            if let propertyTextFild = alert.textFields?[0].text {
                CoreDataManager.sharedManager.updateCar(property: propertyTextFild, car: self.curentCar)
                
                if let detailCarFetches = self.curentCar.carDetail?.allObjects {
                    self.masivCarStr = detailCarFetches as! [CarDetail]
                }
                self.detailCar.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
        
    }

extension CarDetailViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        CoreDataManager.sharedManager.deleteCarDetail(self.masivCarStr[indexPath.row])
        self.masivCarStr = curentCar.carDetail?.allObjects as! [CarDetail]
        self.detailCar.reloadData()
    }
        
        
        
        
        
    }

    


