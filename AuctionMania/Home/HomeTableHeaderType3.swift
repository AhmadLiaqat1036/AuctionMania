//
//  HomeTableHeaderType3.swift
//  AuctionMania
//
//  Created by usear on 7/8/24.
//

import UIKit

class HomeTableHeaderType3: UIView {


    var stackLabel = "Electronics"{
        didSet{
            labetStack.text = stackLabel
            labelStack2.text = stackLabel
            labelStack3.text = stackLabel
            labelStack4.text = stackLabel
            labelStack5.text = stackLabel
        }
    }
     @IBOutlet var Main: UIView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelDown: UILabel!
    @IBOutlet weak var labetStack: UILabel!
    @IBOutlet weak var labelStack2: UILabel!
    @IBOutlet weak var labelStack3: UILabel!
    @IBOutlet weak var labelStack4: UILabel!
    @IBOutlet weak var labelStack5: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeNib()
        adjustSubviews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeNib()
        adjustSubviews()
    }
    func makeNib(){
        Bundle.main.loadNibNamed("HomeTableHeaderType3", owner: self, options: nil)
        addSubview(Main)
        Main.frame = self.bounds
    }
    func adjustSubviews(){
        background.layer.masksToBounds = false
        background.layer.cornerRadius = 10
    
        background.layer.shadowColor = UIColor.black.cgColor
        background.layer.shadowOpacity = 0.5
        background.layer.shadowOffset = CGSize(width: 0, height: 2)
        background.layer.shadowRadius = 5
    }
}

