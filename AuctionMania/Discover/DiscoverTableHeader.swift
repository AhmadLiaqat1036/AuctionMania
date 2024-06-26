//
//  DiscoverTableHeader.swift
//  AuctionMania
//
//  Created by usear on 6/26/24.
//

import UIKit

class DiscoverTableHeader: UIView {

    var viewModel = DiscoverViewModel()
    @IBOutlet var DiscoverTableHeaderView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeNib()
        let nib = UINib(nibName: "DiscoverTableHeaderCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: DiscoverTableHeaderCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeNib()
    }
    func makeNib(){
        Bundle.main.loadNibNamed("DiscoverTableHeader", owner: self, options: nil)
        addSubview(DiscoverTableHeaderView)
        DiscoverTableHeaderView.frame = self.bounds
    }
}

extension DiscoverTableHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5 // Adjust this value to reduce the horizontal spacing between cells
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Constants.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverTableHeaderCell.identifier, for: indexPath) as? DiscoverTableHeaderCell else {return UICollectionViewCell()}
        cell.Label.text = Constants.categories[indexPath.row]
        cell.Image.image = UIImage(named: Constants.categories[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collection view cell pressed...")
        viewModel.fetchAllProductsFromCategory(category: Constants.categories[indexPath.row].lowercased())
        print(viewModel.categories)
        
        
        
    }
    
    
    
}
