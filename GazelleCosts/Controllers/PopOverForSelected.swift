//
//  PopOverForSelected.swift
//  GazelleCosts
//
//  Created by user on 1/6/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class PopOverForSelected: UITableViewController {
    
    let masivSeler = ["v", "l", "other"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.isScrollEnabled = false
        
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 200, height: self.tableView.contentSize.height)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.masivSeler.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = masivSeler[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let strName = self.masivSeler[indexPath.row]
        UserDefaults.standard.set(strName , forKey: "kstrName")
        let stName = UserDefaults.standard.value(forKey: "kstrName")
        print(stName as! String)
    
    }

}
