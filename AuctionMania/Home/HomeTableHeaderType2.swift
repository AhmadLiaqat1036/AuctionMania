//
//  HomeTableHeaderType2.swift
//  AuctionMania
//
//  Created by usear on 7/8/24.
//

import UIKit

class HomeTableHeaderType2: UIView {

   
    let gradient: CAGradientLayer = {
        let g = CAGradientLayer()
        g.colors=[
            UIColor.black.withAlphaComponent(0.5).cgColor,
            UIColor.black.withAlphaComponent(0.25).cgColor,
            UIColor.black.withAlphaComponent(0.1).cgColor,
            UIColor.black.withAlphaComponent(0.25).cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor
        ]
        return g
    }()
    @IBOutlet var Main: UIView!
    @IBOutlet weak var BackGround: UIView!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var ImageLayer: UIView!
    @IBOutlet weak var Label: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeNib()
        ImageLayer.layer.insertSublayer(gradient, at: 0)
        adjustSubviews()
       
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeNib()
        ImageLayer.layer.insertSublayer(gradient, at: 0)
        adjustSubviews()
    }

    func makeNib(){
        Bundle.main.loadNibNamed("HomeTableHeaderType2", owner: self, options: nil)
        addSubview(Main)
        Main.frame = self.bounds
    }
    func adjustSubviews(){
        BackGround.layer.masksToBounds = false
        BackGround.backgroundColor = .white
        BackGround.layer.cornerRadius = 10
        Image.layer.cornerRadius = 10
        ImageLayer.layer.cornerRadius = 10
        ImageLayer.layer.masksToBounds = true
        BackGround.layer.shadowColor = UIColor.black.cgColor
        BackGround.layer.shadowOpacity = 0.5
        BackGround.layer.shadowOffset = CGSize(width: 0, height: 2)
        BackGround.layer.shadowRadius = 5
    }
    
}
