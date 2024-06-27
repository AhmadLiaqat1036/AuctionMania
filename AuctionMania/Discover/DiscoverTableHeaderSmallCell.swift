//
//  DiscoverTableHeaderSmallCell.swift
//  AuctionMania
//
//  Created by usear on 6/27/24.
//

import UIKit

class DiscoverTableHeaderSmallCell: UICollectionViewCell {

    @IBOutlet weak var Background: UIView!
    @IBOutlet weak var Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        Background.layer.cornerRadius = 7
        Background.layer.borderWidth = 1
        Background.layer.borderColor = UIColor.systemGray3.cgColor
        
    }

}
