//
//  HomeTableFooter.swift
//  AuctionMania
//
//  Created by usear on 6/20/24.
//

import UIKit

class HomeTableFooter: UIView {

    
   
    @IBOutlet var footerview: UIView!
    @IBOutlet weak var backgroundView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeNib()
        setupTapGestureRecognizer()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeNib()
        }
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.layer.cornerRadius = 10
        //backgroundView.layer.masksToBounds = true
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOpacity = 0.5
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 2)
        backgroundView.layer.shadowRadius = 5
    }
    
    func makeNib(){
        Bundle.main.loadNibNamed("HomeTableFooter", owner: self, options: nil)
        addSubview(footerview)
        footerview.frame = self.bounds
    }
    func setupTapGestureRecognizer() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            footerview.addGestureRecognizer(tapGesture)
            footerview.isUserInteractionEnabled = true // Enable user interaction for gestures
        }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let indexData = ["index": 1]
        NotificationCenter.default.post(name: NSNotification.Name("GoToDiscover"), object: nil, userInfo: indexData)
        print("Footer tapped...")
    }
}


