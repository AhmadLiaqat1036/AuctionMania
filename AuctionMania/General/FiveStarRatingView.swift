//
//  5StarRatingView.swift
//  AuctionMania
//
//  Created by usear on 6/24/24.
//

import UIKit

class FiveStarRatingView: UIView {
    
    var Colour = UIColor.systemYellow{
        didSet{
            star5.textColor = Colour
            star4.textColor = Colour
            star3.textColor = Colour
            star2.textColor = Colour
            star1.textColor = Colour
        }
    }

    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var star1: UILabel!
    @IBOutlet weak var star2: UILabel!
    @IBOutlet weak var star3: UILabel!
    @IBOutlet weak var star4: UILabel!
    @IBOutlet weak var star5: UILabel!
    var rate: Double = 0{
        didSet{
            configureStars(rating: Int(rate))
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
        configureStars(rating: Int(rate))
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    func viewInit(){
        let xibView = Bundle.main.loadNibNamed("FiveStarRatingView", owner: self, options: nil)![0] as! UIView
        addSubview(xibView)
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    private func configureStars(rating: Int){
        if rating == 4{
            star5.text = "☆"
            star4.text = "★"
            star3.text = "★"
            star2.text = "★"
            star1.text = "★"
        }else if rating == 3{
            star5.text = "☆"
            star4.text = "☆"
            star3.text = "★"
            star2.text = "★"
            star1.text = "★"
        }else if rating == 2{
            star5.text = "☆"
            star4.text = "☆"
            star3.text = "☆"
            star2.text = "★"
            star1.text = "★"
        }else if rating == 1{
            star5.text = "☆"
            star4.text = "☆"
            star3.text = "☆"
            star2.text = "☆"
            star1.text = "★"
        }else if rating == 0{
            star5.text = "☆"
            star4.text = "☆"
            star3.text = "☆"
            star2.text = "☆"
            star1.text = "☆"
        }else{
            star5.text = "★"
            star4.text = "★"
            star3.text = "★"
            star2.text = "★"
            star1.text = "★"
        }
        
    }
}
