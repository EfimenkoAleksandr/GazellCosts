//
//  SparePartsViewController.swift
//  GazelleCosts
//
//  Created by mac on 09.10.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SparePartsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var partsCollectionView: UICollectionView!
    
    var parts = categoriParts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CategoriParts"
        partsCollectionView.delegate = self
        partsCollectionView.dataSource = self
        
        self.partsCollectionView.backgroundView = UIImageView(image: UIImage(named: "gray-background"))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.parts.count
    }
    
    //MARK: UICollectionViewDataSourse
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpareParts", for: indexPath) as? SparePartsCell {
            
            let part = self.parts[indexPath.row] + ".jpg"
            cell.configureCell(part, self.parts[indexPath.row])
            
            let label = HelperMethods.shared.createLabel(text: self.parts[indexPath.row], cellWidth: cell.frame.width)
            cell.addSubview(label)
            
            return cell
        } else {
            return SparePartsCell()
        }
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let masiv = categoriPartsName[indexPath.row]
        performSegue(withIdentifier: "PartSegue", sender: masiv)
    }
    
    //MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PartSegue" {
            if let partCategori = segue.destination as? PartInCategoriViewController {
                if let masiv = sender as? [String] {
                    partCategori.partCategoriesMasiv = masiv
                }
            }
        }
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.partsCollectionView.bounds.width / 2) - 15
        let height = width * (4 / 3)
        
        return CGSize(width: width, height: height)
    }
    
}
