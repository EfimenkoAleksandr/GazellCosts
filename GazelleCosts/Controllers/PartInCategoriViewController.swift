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
       

        // Do any additional setup after loading the view.
        
        title = "Parts"
        partCategoriCollectionView.delegate = self
        partCategoriCollectionView.dataSource = self
        self.partCategoriCollectionView.backgroundView = UIImageView(image: UIImage(named: "gray-background"))
        
        let button =  UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_right"), for: .normal)
        button.addTarget(self, action: #selector(buttonCreate), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)//CGRectMake(0, 0, 53, 31)
        button.imageEdgeInsets = UIEdgeInsetsMake(-1, 32, 1, -32)//move image to the right
        let label = UILabel(frame: CGRect(x: 3, y: 5, width: 50, height: 20))//CGRectMake(3, 5, 50, 20))
        label.font = UIFont(name: "Arial-BoldMT", size: 16)
        label.text = "Home"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        button.addSubview(label)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func buttonCreate() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Menu") as! MenuForPartsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: UICollectionViewDataSourse

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.partCategoriesMasiv.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartCategori", for: indexPath) as? PartCategoriCell {
            
            let partCategories = partCategoriesMasiv[indexPath.row] + ".jpg"
            cell.configureCell(partCategories)
            
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
        CoreDataManager.sharedManager.saveChoicePart(name: name, count: "1", price: "0", seller: "UncnownSeller")
        
        guard let cell = partCategoriCollectionView.cellForItem(at: indexPath) as? PartCategoriCell else { return }
        
        let cardViewFrame = cell.partCategoriImageView.superview?.convert(cell.partCategoriImageView.frame, to: nil)
        let copiOfCardView = UIView(frame: cardViewFrame!)
        copiOfCardView.layer.cornerRadius = 12.0
        //copiOfCardView.backgroundColor = UIColor.blue
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
