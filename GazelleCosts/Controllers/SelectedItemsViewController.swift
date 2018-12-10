//
//  SelectedItemsViewController.swift
//  GazelleCosts
//
//  Created by mac on 24.10.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SelectedItemsViewController: UIViewController {
    
    @IBOutlet weak var selectedItemsTableView: UITableView!
    @IBOutlet weak var saveChoiceOutlet: UIButton!
    @IBOutlet weak var clearChoiceOutlet: UIButton!
    
    var choiceParts: [ChoicePart]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearChoiceOutlet.isEnabled = false
        self.saveChoiceOutlet.isEnabled = false
    
        if let coicePartNoNill = CoreDataManager.sharedManager.fetchAllChoisePart() {
            self.choiceParts = coicePartNoNill
        }
        if self.choiceParts.count > 0 {
            self.saveChoiceOutlet.isEnabled = true
            self.clearChoiceOutlet.isEnabled = true
        }
        selectedItemsTableView.dataSource = self
        selectedItemsTableView.delegate = self
        
        title = "Choice parts"
        self.selectedItemsTableView.backgroundView = UIImageView(image: UIImage(named: "gray-background"))
        self.selectedItemsTableView.separatorStyle = .none
    }
    
    @IBAction func saveChoise(_ sender: UIButton) {
            
        CoreDataManager.sharedManager.saveMasivChoiseParts(masiv: self.choiceParts)
        
    }
    
    @IBAction func clearChoise(_ sender: UIButton) {
        CoreDataManager.sharedManager.deleteAllChoisePart()
        self.choiceParts = CoreDataManager.sharedManager.fetchAllChoisePart()
        self.saveChoiceOutlet.isEnabled = false
        self.clearChoiceOutlet.isEnabled = false
        self.selectedItemsTableView.reloadData()
        
    }
}

extension SelectedItemsViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choiceParts.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedItemsCell") as! SelectedItemsTableViewCell
        
        
        cell.selectedNameLabel.text = choiceParts[indexPath.row].name
        cell.selectedCountLabel.text = choiceParts[indexPath.row].count
        cell.selectedPriceLabel.text = choiceParts[indexPath.row].price
        if let image = choiceParts[indexPath.row].name {
        cell.selectedImageView.image = UIImage(named: image + ".jpg")
        }
        //cell.selectedImageView.layer.cornerRadius = 12.0
        
        cell.backgroundColor = indexPath.row%2 == 0 ? #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1) : #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        CoreDataManager.sharedManager.deleteChoisePart(choiceParts[indexPath.row])
        self.choiceParts = CoreDataManager.sharedManager.fetchAllChoisePart()
        self.selectedItemsTableView.reloadData()
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.changePart(indexPath.row)
    }
    
    func changePart( _ indexPasrt: Int) {

        let alert1 = UIAlertController(title: "Part", message: self.choiceParts[indexPasrt].name, preferredStyle: UIAlertControllerStyle.alert)

        alert1.addTextField { (textField) in
            textField.placeholder = "count"
        }
        alert1.addTextField { (textField) in
            textField.placeholder = "price"
        }
        alert1.addTextField { (textField) in
            textField.placeholder = "seller"
        }

        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default) { (action) in
            if let countTextFild = alert1.textFields?[0].text, let priceTextFild = alert1.textFields?[1].text, let sellerTextFild = alert1.textFields?[2].text {
                CoreDataManager.sharedManager.updateChoisePart(count: countTextFild, price: priceTextFild, seller: sellerTextFild, choisePart: self.choiceParts[indexPasrt])
                }
                self.selectedItemsTableView.reloadData()
            }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)

        alert1.addAction(saveAction)
        alert1.addAction(cancelAction)
        present(alert1, animated: true, completion: nil)
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 5
//    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 5
//    }
    
}

    


