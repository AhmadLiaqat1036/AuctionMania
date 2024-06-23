//
//  HomeTableHeader.swift
//  AuctionMania
//
//  Created by usear on 6/14/24.
//

import UIKit

class HomeTableHeader: UIView {
    
    //i apologise for not adding comments as i was stuck on shadows for far too long

    private let backgroundView: UIView = {
       let view = UIView()
       view.layer.masksToBounds = false
       view.backgroundColor = .white
       view.layer.cornerRadius = 10
       view.layer.shadowColor = UIColor.black.cgColor
       view.layer.shadowOpacity = 0.5
       view.layer.shadowOffset = CGSize(width: 0, height: 2)
       view.layer.shadowRadius = 5
       view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let carPicture:UIImageView={
       let pic = UIImageView()
        pic.image = UIImage(named: "Sedan")
        pic.layer.cornerRadius = 10
        pic.contentMode = .scaleAspectFill
        pic.clipsToBounds = true
        pic.translatesAutoresizingMaskIntoConstraints = false
        return pic
    }()
    
    private let price: UILabel = {
        let text = UILabel()
        text.text = "$25000"
        text.textColor = .label
        text.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    private let CarName: UILabel = {
        let text = UILabel()
        text.text = "Honda Accord 2020"
        text.textColor = .label

        text.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        text.numberOfLines = 1
        
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    private let TopBid: UILabel = {
        let text = UILabel()
        text.text = "Top Bid:"
        text.textColor = .label

        text.numberOfLines = 1
        text.font = UIFont.systemFont(ofSize: 12, weight: .light)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    private let timeLabel:UILabel={
        let text = UILabel()
        text.text = "00:00:00"
        text.textColor = .label
        text.textAlignment = .right
        text.numberOfLines = 1
        text.font =  UIFont.systemFont(ofSize: 30, weight: .light)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundView)
        backgroundView.addSubview(carPicture)
        backgroundView.addSubview(price)
        backgroundView.addSubview(CarName)
        backgroundView.addSubview(TopBid)
        backgroundView.addSubview(timeLabel)
        applyConstraints()
        addGradient()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func addGradient(){
        let gradient = CAGradientLayer()
        gradient.colors=[
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        
        gradient.frame = CGRect(x: 10, y: 10, width: bounds.width - 20 , height: 200 + 1)
        layer.addSublayer(gradient)
    }
    private func applyConstraints(){
        let backgroundViewConstraints = [
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ]
        let carPicConstraints = [
            carPicture.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 0),
            carPicture.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 0),
            carPicture.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 0),
            carPicture.heightAnchor.constraint(equalToConstant: 200)
        ]
       
        let carNameConstraints = [
            CarName.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 5),
            CarName.topAnchor.constraint(equalTo: carPicture.bottomAnchor, constant: 0),
            CarName.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -5)
        ]
        let topBidConstraints = [
            TopBid.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 5),
            TopBid.bottomAnchor.constraint(equalTo: price.topAnchor, constant: -5),
            TopBid.widthAnchor.constraint(equalToConstant: 100)
        ]
        let priceConstraints = [
            price.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 5),
            price.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            price.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -10)        ]
        let timeLabelConstraints = [
            timeLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -5),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            timeLabel.widthAnchor.constraint(equalToConstant: 200)
        ]
        let allConstraints = carPicConstraints + carNameConstraints + topBidConstraints + priceConstraints + timeLabelConstraints + backgroundViewConstraints
        NSLayoutConstraint.activate(allConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
