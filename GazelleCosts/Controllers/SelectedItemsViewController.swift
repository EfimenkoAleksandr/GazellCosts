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
        
        if let choicePartNoNill = CoreDataManager.sharedManager.fetchAllChoisePart() {
            self.choiceParts = choicePartNoNill
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
        
        self.saveChoiceOutlet.layer.cornerRadius = 10
        self.clearChoiceOutlet.layer.cornerRadius = 10
       
       HelperMethods.shared.setBackGround(view: self.view, tableView: self.selectedItemsTableView)
    }
    
    @IBAction func saveChoise(_ sender: UIButton) {
        DispatchQueue.global(qos: .utility).async {
        CoreDataManager.sharedManager.saveMasivChoiseParts(masiv: self.choiceParts)
        }
    }
    
    @IBAction func clearChoise(_ sender: UIButton) {
        DispatchQueue.main.async {
        CoreDataManager.sharedManager.deleteAllChoisePart()            
        self.choiceParts = CoreDataManager.sharedManager.fetchAllChoisePart()
        self.saveChoiceOutlet.isEnabled = false
        self.clearChoiceOutlet.isEnabled = false
        self.selectedItemsTableView.reloadData()
        }
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
    
    func changePart( _ indexPath: Int) {

        let alert1 = UIAlertController(title: "Part", message: self.choiceParts[indexPath].name, preferredStyle: UIAlertControllerStyle.alert)

        alert1.addTextField { (textField) in
            textField.placeholder = "count"
        }
        alert1.addTextField { (textField) in
            textField.placeholder = "price"
        }
        alert1.addTextField { (textField) in
            textField.placeholder = "seller"
        }
        alert1.addTextField { (textField) in
            textField.placeholder = "manufacturer"
        }

        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default) { (action) in
            if let countTextFild = alert1.textFields?[0].text, let priceTextFild = alert1.textFields?[1].text, let sellerTextFild = alert1.textFields?[2].text, let manufacturerTextFild = alert1.textFields?[3].text {
                CoreDataManager.sharedManager.updateChoisePart(count: countTextFild, price: priceTextFild, seller: sellerTextFild, manufacturer: manufacturerTextFild, choicePart: self.choiceParts[indexPath])
                }
                self.selectedItemsTableView.reloadData()
            }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)

        alert1.addAction(saveAction)
        alert1.addAction(cancelAction)
        present(alert1, animated: true, completion: nil)
    }
    
}

    


