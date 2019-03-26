//
//  MenuForPartsViewController.swift
//  GazelleCosts
//
//  Created by user on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class MenuForPartsViewController: UIViewController {
    
    @IBOutlet weak var menuForPartsTableView: UITableView!
    
    let menus = ["Spare parts", "Selected Parts", "Spare parts reports", "Last price"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuForPartsTableView.isScrollEnabled = false
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "gray-background")!, for: .default)
        
        menuForPartsTableView.dataSource = self
        menuForPartsTableView.delegate = self
        
        HelperMethods.shared.setBackGround(view: self.view, tableView: self.menuForPartsTableView)
        
    }
    
}

extension MenuForPartsViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UICollectionViewDataSourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuForPartsCell") as! MenuForPartsCell
        
        cell.nameLabel.text = menus[indexPath.row]
        let image = UIImage(named: menus[indexPath.row])
        if image != nil {
            cell.nameImage.image = image
        }
        cell.layer.cornerRadius = 15.0
        cell.backgroundColor = indexPath.row%2 == 0 ? #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1) : #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selected = menus[indexPath.row]
        performSegue(withIdentifier: selected, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


