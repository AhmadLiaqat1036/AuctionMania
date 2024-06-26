//
//  BigTableViewCell.swift
//  AuctionMania
//
//  Created by usear on 6/13/24.
//

import UIKit

class BigTableViewCell: UITableViewCell {
    
//MARK: IBOutlets
   
    @IBOutlet weak var CarImage: UIImageView!
    @IBOutlet weak var BackgroundCellView: UIView!
    @IBOutlet weak var CarCompanyImage: UIImageView!
    @IBOutlet weak var CarCompanyImageLabel: UILabel!
    @IBOutlet weak var CarComapanyName: UILabel!
    @IBOutlet weak var CarName: UILabel!
    @IBOutlet weak var BigPriceLabel: UILabel!
    @IBOutlet weak var SellerBackground: UIView!
    @IBOutlet weak var Seller: UILabel!
    @IBOutlet weak var CarTypeBackground: UIView!
    @IBOutlet weak var CarType: UILabel!
    @IBOutlet weak var TimeLeftBackground: UIView!
    @IBOutlet weak var TimeLeft: UILabel!
    
    @IBOutlet weak var SellerBackgroundWidth: NSLayoutConstraint!
    @IBOutlet weak var CategoryBackgroundWidth: NSLayoutConstraint!
    @IBOutlet weak var TimeLeftBackgroundWidth: NSLayoutConstraint!
    //MARK: init

    override func awakeFromNib() {
        super.awakeFromNib()
        BackgroundCellView.layer.cornerRadius = 10
        BackgroundCellView.layer.borderWidth = 1
        BackgroundCellView.layer.borderColor = UIColor.label.cgColor
        SellerBackground.layer.cornerRadius=15
        CarTypeBackground.layer.cornerRadius=15
        TimeLeftBackground.layer.cornerRadius=15
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)
       
        
       
        
    }
    
}
