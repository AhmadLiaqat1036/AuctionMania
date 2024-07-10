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
    @IBOutlet weak var InterestButton: UIButton!
    var buttonSelected = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        upDownTag.layer.cornerRadius = 10
        upDownTag.clipsToBounds = true
        if upDownTag.text?.count ?? 0 > 4 {
            upDownTag.text = "9K+"
        }
        upDownTagBackground.layer.cornerRadius = 10
        upDownTagBackground.layer.masksToBounds = true
        
        InterestButton.isSelected = false
        InterestButton.tintColor = .label

    }
    func viewInit(){
        let xibView = Bundle.main.loadNibNamed("SmallTableCellView", owner: self, options: nil)![0] as! UIView
        addSubview(xibView)
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
//    @objc private func interestButtonTapped(sender: UIButton, title: String){
//        sender.isSelected = !sender.isSelected
//            if sender.isSelected {
//                print("Switch is ON")
//                InterestButton.tintColor = .systemYellow
////                NotificationCenter.default.post(name: NSNotification.Name("InterestIsOn"), object: nil, userInfo: ["name": title])
//            } else {
//                print("Switch is OFF")
//                InterestButton.tintColor = .label
////                NotificationCenter.default.post(name: NSNotification.Name("InterestIsOff"), object: nil, userInfo: ["name": title])
//            }
//       
//    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if buttonSelected{
            buttonSelected = false
            InterestButton.tintColor = .darkGray
            InterestsViewModel.shared.interestsNames.removeAll { name in
                name == productName.text ?? ""
            }
            if(InterestsViewModel.shared.APISuccess){
                InterestsViewModel.shared.deleteAllInterests()
            }else{
                InterestsViewModel.shared.fetchAllProducts()
            }
            print("Button clicked!")
            print(InterestsViewModel.shared.interestsNames)
        }else{
            buttonSelected = true
            InterestButton.tintColor = .systemYellow
            InterestsViewModel.shared.interestsNames.append(productName.text ?? "")
            if(InterestsViewModel.shared.APISuccess){
                InterestsViewModel.shared.deleteAllInterests()
            }else{
                InterestsViewModel.shared.fetchAllProducts()
            }
            print("Button clicked!")
            print(InterestsViewModel.shared.interestsNames)
        }
    }
}
