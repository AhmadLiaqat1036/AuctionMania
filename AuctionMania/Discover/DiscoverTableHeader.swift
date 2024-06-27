//
//  DiscoverTableHeader.swift
//  AuctionMania
//
//  Created by usear on 6/26/24.
//

import UIKit

class DiscoverTableHeader: UIView {

    @IBOutlet var DiscoverTableHeaderView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var smallCollectionView: UICollectionView!
    
    @IBOutlet weak var smallCollectionViewHeight: NSLayoutConstraint!
    var selectedIndexPaths: [IndexPath] = []
    var selectedCategories: [String] = []
        
        
       
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeNib()
        let nib = UINib(nibName: "DiscoverTableHeaderCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: DiscoverTableHeaderCell.identifier)
       
        collectionView.dataSource = self
        collectionView.delegate = self
        let smallNib = UINib(nibName: "DiscoverTableHeaderSmallCell", bundle: nil)
        smallCollectionView.register(smallNib, forCellWithReuseIdentifier: "DiscoverTableHeaderSmallCell")
        smallCollectionView.delegate = self
        smallCollectionView.dataSource = self
        
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeNib()
    }
    func deselectAllItems() {
        for indexPath in selectedIndexPaths {
            if let cell = collectionView.cellForItem(at: indexPath) as? DiscoverTableHeaderCell{
                cell.deselected()
                DiscoverViewModel.shared.deleteProducts(inCategory: Constants.categories[indexPath.row])
            }
        }
        DiscoverViewModel.shared.categories.removeAll()
        selectedIndexPaths.removeAll()
        selectedCategories.removeAll()
        smallCollectionView.reloadData()
    }
    
    func makeNib(){
        Bundle.main.loadNibNamed("DiscoverTableHeader", owner: self, options: nil)
        addSubview(DiscoverTableHeaderView)
        DiscoverTableHeaderView.frame = self.bounds
    }
}

extension DiscoverTableHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: 150, height: 80)
        } else if collectionView == self.smallCollectionView {
            if indexPath.row == 0{
                return CGSize(width: 40, height: 40)
            }else{
                return CGSize(width: 130, height: 40)
            }
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionView {
            return 5
        } else if collectionView == self.smallCollectionView {
            return 1
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return Constants.categories.count
        } else if collectionView == self.smallCollectionView {
            return selectedIndexPaths.count + 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverTableHeaderCell.identifier, for: indexPath) as? DiscoverTableHeaderCell else {return UICollectionViewCell()}
            cell.Label.text = Constants.categories[indexPath.row]
            cell.Image.image = UIImage(named: Constants.categories[indexPath.row])
            
            return cell
        }else if collectionView == self.smallCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverTableHeaderSmallCell", for: indexPath) as? DiscoverTableHeaderSmallCell else {return UICollectionViewCell()}
            if(indexPath.row == 0){
                if(selectedCategories.isEmpty){
                    smallCollectionView.isHidden = true
                    
                }else{
                    smallCollectionView.isHidden = false
                    
                }
                cell.Background.layer.cornerRadius = 10
                cell.Background.layer.borderWidth = 0
                cell.Background.backgroundColor = .black
                cell.Label.text = "X"
                cell.Label.textColor = .systemYellow
            }else{
                cell.Background.layer.cornerRadius = 7
                cell.Background.layer.borderWidth = 1
                cell.Background.layer.borderColor = UIColor.systemGray3.cgColor
                cell.Background.backgroundColor = .systemGray5
                cell.Label.text = selectedCategories[indexPath.row - 1]
                cell.Label.textColor = .darkGray
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            smallCollectionView.reloadData()
            if let cell = collectionView.cellForItem(at: indexPath) as? DiscoverTableHeaderCell{
                if cell.Background.layer.borderWidth == 3 {
                    cell.deselected()
                    DiscoverViewModel.shared.hud.show(in: self.DiscoverTableHeaderView.superview?.superview ?? self.DiscoverTableHeaderView)
                    DiscoverViewModel.shared.deleteProducts(inCategory: Constants.categories[indexPath.row])
                    selectedIndexPaths.removeAll {
                        $0 == indexPath
                    }
                    selectedCategories.removeAll {
                        $0 == cell.Label.text
                    }
                }else{
                    cell.selected()
                    selectedIndexPaths.append(indexPath)
                    selectedCategories.append(cell.Label.text ?? "")
                    DiscoverViewModel.shared.hud.show(in: self.DiscoverTableHeaderView.superview?.superview ?? self.DiscoverTableHeaderView)
                    print("collection view cell pressed...")
                    DiscoverViewModel.shared.fetchAllProductsFromCategory(category: Constants.categories[indexPath.row].lowercased())
                }
            }
        }else if collectionView == self.smallCollectionView {
            if(indexPath.row == 0){
                print(selectedIndexPaths)
               deselectAllItems()
                DiscoverViewModel.shared.hud.show(in: self.DiscoverTableHeaderView.superview?.superview ?? self.DiscoverTableHeaderView)
                DiscoverViewModel.shared.fetchAllProducts()
            }
        }
    }
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? DiscoverTableHeaderCell{
//            cell.deselected()
//            
//        }
//    }
}


