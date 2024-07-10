//
//  DiscoverTableHeaderCell.swift
//  AuctionMania
//
//  Created by usear on 6/26/24.
//

import UIKit

class DiscoverTableHeaderCell: UICollectionViewCell {

    
    static let identifier = "DiscoverTableHeaderCell"
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Background: UIView!
    @IBOutlet weak var Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        Background.layer.cornerRadius = 10
    }
    func selected(){
        Background.layer.borderWidth = 3
        Background.layer.borderColor = UIColor.systemYellow.cgColor
    }
    func deselected(){
        Background.layer.borderWidth = 1
    }
   

}
