//
//  ProfileTableHeader.swift
//  AuctionMania
//
//  Created by usear on 7/7/24.
//

import UIKit

class ProfileTableHeader: UIView {

   
    @IBOutlet weak var Background: UIView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var ProfilePic: UIImageView!
    
    @IBOutlet var HeaderView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeNib()
        setupView()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeNib()
        setupView()
    }
    
    func makeNib(){
        Bundle.main.loadNibNamed("ProfileTableHeader", owner: self, options: nil)
        addSubview(HeaderView)
        HeaderView.frame = self.bounds
    }
    func setupView(){
        guard let url = URL(string: Constants.randomProfilesMen) else {return}
        ProfilePic.sd_setImage(with: url)
        ProfilePic.layer.cornerRadius = 75/2
        ProfilePic.contentMode = .scaleToFill
        Background.layer.borderWidth = 1
        Background.layer.borderColor = UIColor.opaqueSeparator.cgColor
        Background.layer.cornerRadius = 10
    }
}
