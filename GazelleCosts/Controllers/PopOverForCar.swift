//
//  PopOverForCar.swift
//  GazelleCosts
//
//  Created by user on 2/5/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class PopOverForCar: UITableViewController {
    
    let masivImages = ["download", "upload", "trash"]
    let masivStr = ["download from", "upload to", "delete all in server"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isScrollEnabled = false
        
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 250, height: self.tableView.contentSize.height)
    }
    
    //MARK: UICollectionViewDataSourse
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.masivImages.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopCarCell", for: indexPath)
        
        let image = UIImage(named: self.masivImages[indexPath.row])
        if image != nil {
            cell.imageView?.image = image
        }
        cell.textLabel?.text = masivStr[indexPath.row]
        
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var alert = UIAlertController()
        switch indexPath.row {
        case 0:
            alert = HelperMethods.shared.createAlert(title: "Загрузка", message: "Скачать с сервера?", number: indexPath.row, controller: self)
            break
        case 1:
            alert = HelperMethods.shared.createAlert(title: "Выгрузка", message: "Загрузить на сервер?", number: indexPath.row, controller: self)
            break
        case 2:
            alert = HelperMethods.shared.createAlert(title: "Удаление", message: "Удалить данные с сервера?", number: indexPath.row, controller: self)
            break
        default:
            print("error")
        }
        present(alert, animated: true, completion: nil)
    }
    
}


