//
//  SmallTableCellView.swift
//  AuctionMania
//
//  Created by usear on 6/24/24.
//

import UIKit

class SmallTableCellView: UIView {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var upDownTag: UILabel!
    @IBOutlet weak var upDownTagBackground: UIView!
    @IBOutlet weak var addToInterestButton: UIButton!
    @IBOutlet weak var upDownTagBackgroundWidth: NSLayoutConstraint!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productBid: UILabel!
    @IBOutlet weak var rating: FiveStarRatingView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor.label.cgColor
        upDownTag.layer.cornerRadius = 10
        upDownTag.clipsToBounds = true
        if upDownTag.text?.count ?? 0 > 4 {
            upDownTag.text = "9K+"
        }
        upDownTagBackground.layer.cornerRadius = 10
        upDownTagBackground.layer.masksToBounds = true
       
    }
    func viewInit(){
        let xibView = Bundle.main.loadNibNamed("SmallTableCellView", owner: self, options: nil)![0] as! UIView
        addSubview(xibView)
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
