//
//  PartInCategoriViewController.swift
//  GazelleCosts
//
//  Created by mac on 12.10.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class PartInCategoriViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var partCategoriCollectionView: UICollectionView!
    
    var partCategoriesMasiv = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Parts"
        partCategoriCollectionView.delegate = self
        partCategoriCollectionView.dataSource = self
        self.partCategoriCollectionView.backgroundView = UIImageView(image: UIImage(named: "gray-background"))
        
        self.setButton()
    }
    
    //MARK: Ser button for right bar button
    
    private func setButton() {
        let button =  UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_right"), for: .normal)
        button.addTarget(self, action: #selector(buttonCreate), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 31)
        button.imageEdgeInsets = UIEdgeInsets.init(top: -1, left: 32, bottom: 1, right: -32)
        let label = UILabel(frame: CGRect(x: 0, y: 5, width: 80, height: 20))
        label.font = UIFont(name: "Arial-BoldMT", size: 16)
        label.text = "Selected"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        button.addSubview(label)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func buttonCreate() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SelectedItems") as! SelectedItemsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: UICollectionViewDataSourse
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.partCategoriesMasiv.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartCategori", for: indexPath) as? PartCategoriCell {
            
            let partCategories = self.partCategoriesMasiv[indexPath.row] + ".jpg"
            cell.configureCell(partCategories)
            
            let label = HelperMethods.shared.createLabel(text: self.partCategoriesMasiv[indexPath.row], cellWidth: cell.frame.width)
            cell.addSubview(label)
            
            return cell
        } else {
            return SparePartsCell()
        }
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = self.partCategoriesMasiv[indexPath.row]
        let saver = CoreDataManager.sharedManager.fetchAllChoisePart()
        for nameSaver in saver! {
            if nameSaver.name == name {
                return
            }
        }
        CoreDataManager.sharedManager.saveChoicePart(name: name, count: "1", price: "0", seller: "UncnownSeller", manufacturer: "Other")
        
        guard let cell = partCategoriCollectionView.cellForItem(at: indexPath) as? PartCategoriCell else { return }
        
        let cardViewFrame = cell.partCategoriImageView.superview?.convert(cell.partCategoriImageView.frame, to: nil)
        let copiOfCardView = UIView(frame: cardViewFrame!)
        copiOfCardView.layer.cornerRadius = 12.0
        view.addSubview(copiOfCardView)
        copiOfCardView.backgroundColor = UIColor(patternImage: UIImage(named: name + ".jpg")!)
        
        UIView.animate(withDuration: 1.0, animations: {
            copiOfCardView.transform = CGAffineTransform(scaleX: 2, y: 2)
            copiOfCardView.transform = CGAffineTransform(scaleX: -2, y: -2)
            copiOfCardView.frame = CGRect(x: 0, y: 0, width: cell.partCategoriImageView.frame.width / 5, height: cell.partCategoriImageView.frame.height / 5)
        }) { (extended) in
            copiOfCardView.removeFromSuperview()
        }
        
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.partCategoriCollectionView.bounds.width / 2) - 15
        let height = width * (4 / 3)
        
        return CGSize(width: width, height: height)
    }
    
}
