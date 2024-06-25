//
//  BigTableViewCell.swift
//  AuctionMania
//
//  Created by usear on 6/13/24.
//

import UIKit

class BigTableViewCell: UITableViewCell {
    
//MARK: IBOutlets
    @IBOutlet weak var CarTypeConstraintBetweenLogoAndText: NSLayoutConstraint!
    @IBOutlet weak var CarImage: UIImageView!
    @IBOutlet weak var BackgroundCellView: UIView!
    @IBOutlet weak var CarCompanyImage: UIImageView!
    @IBOutlet weak var CarCompanyImageLabel: UILabel!
    @IBOutlet weak var CarComapanyName: UILabel!
    @IBOutlet weak var CarName: UILabel!
    @IBOutlet weak var BidBackground: UIView!
    @IBOutlet weak var Bid: UILabel!
    @IBOutlet weak var CarTypeBackground: UIView!
    @IBOutlet weak var CarType: UILabel!
    @IBOutlet weak var TimeLeftBackground: UIView!
    @IBOutlet weak var TimeLeft: UILabel!
    
    //MARK: init

    override func awakeFromNib() {
        super.awakeFromNib()
        BackgroundCellView.layer.cornerRadius = 10
        BackgroundCellView.layer.borderWidth = 1
        BackgroundCellView.layer.borderColor = UIColor.label.cgColor
        BidBackground.layer.cornerRadius=20
        CarTypeBackground.layer.cornerRadius=20
        TimeLeftBackground.layer.cornerRadius=20
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if CarType.text?.count ?? 0 < 7{
            CarTypeConstraintBetweenLogoAndText.constant = 12
        }else{
            CarTypeConstraintBetweenLogoAndText.constant = 5
        }
        if Bid.text?.count ?? 0 > 7{
            Bid.text? = (Bid.text?.prefix(7) ?? "")+"+"
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)
       
        
       
        
    }
    
}
