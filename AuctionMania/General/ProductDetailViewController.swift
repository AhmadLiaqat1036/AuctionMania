//
//  ProductDetailViewController.swift
//  AuctionMania
//
//  Created by usear on 7/3/24.
//

import UIKit

class ProductDetailViewController: UIViewController {

    
    
    @IBOutlet weak var CategoryBack: UIView!
    @IBOutlet weak var CategoryName: UILabel!
    
    @IBOutlet weak var ImageBack: UIView!
    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var TopBidBack: UIView!
    @IBOutlet weak var TopBidImage: UIImageView!
    @IBOutlet weak var TopBidName: UILabel!
    @IBOutlet weak var TopBidLocation: UILabel!
    @IBOutlet weak var TopBidPrice: UILabel!
    @IBOutlet weak var TopBidTime: UILabel!
    
    @IBOutlet weak var ProductRatingback: UIView!
    @IBOutlet weak var ProductRatingRate: UILabel!
    @IBOutlet weak var ProductRatingVotes: UILabel!
    @IBOutlet weak var CircleProgression: CircleProgressBar!
    @IBOutlet weak var ProductRatingDescription: UILabel!
    
    @IBOutlet weak var SellerBack: UIView!
    @IBOutlet weak var SellerImage: UIImageView!
    @IBOutlet weak var SellerName: UILabel!
    @IBOutlet weak var SellerLocation: UILabel!
    @IBOutlet weak var SellerPrice: UILabel!
    @IBOutlet weak var RatingView: FiveStarRatingView!
    
    @IBOutlet weak var DecriptionBack: UIView!
    @IBOutlet weak var Description: UILabel!
    

    var product = ProductDetailViewModel(categoryName: "No Category", productName: "No Name", productImage: "", topBidName: "No Name", topBidLocation: "No Location", topBidTime: "", topBidPrice: "$0", prRate: "0.0", prVote: "0", prDesc: "", cpBackgroundClr: UIColor.gray.cgColor, cpPrimaryClr: UIColor.tertiarySystemBackground.cgColor, cpPercentClr: .gray, cpPercentage: 100, cpStrokeEnd: 1.0, sName: "No Name", sPrice: "$0", sLoc: "No Location", description: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = product.categoryName
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .systemGray6
        configureBack(CategoryBack)
        configureBack(ImageBack)
        configureBack(TopBidBack)
        configureBack(ProductRatingback)
        configureBack(SellerBack)
        configureBack(DecriptionBack)
        
        RatingView.Colour = .systemYellow
        RatingView.StackView.alignment = .top
        
        CircleProgression.primaryColour = UIColor.systemYellow.cgColor
        CircleProgression.backgroundColour = UIColor.systemOrange.withAlphaComponent(0.4).cgColor
        CircleProgression.percentColour = .darkGray
        CircleProgression.percentage = product.cpPercentage
        CircleProgression.strokeDestination = product.cpStrokeEnd
        
        CategoryName.text = product.productName
        
        guard let url = URL(string: product.productImage) else{
            return
        }
        Image.sd_setImage(with: url)
        
        TopBidName.text = product.topBidName
        TopBidLocation.text = product.topBidLocation
        TopBidTime.text = product.topBidTime
        TopBidPrice.text = product.topBidPrice
//        TopBidImage
        
        ProductRatingRate.text = product.prRate
        ProductRatingVotes.text = product.prVote
        ProductRatingDescription.text=product.prDesc
        
        CircleProgression.backgroundColour = product.cpBackgroundClr
        CircleProgression.primaryColour = product.cpPrimaryClr
        CircleProgression.percentColour = product.cpPercentClr
        
        CircleProgression.percentage = product.cpPercentage
        CircleProgression.strokeDestination = product.cpStrokeEnd
        
        SellerName.text = product.sName
        SellerPrice.text = product.sPrice
        SellerLocation.text = product.sLoc
        
        RatingView.rate = [0.1, 1.1, 2.1, 3.1, 4.1, 5.0].randomElement() ?? 0.0
        
        Description.text = product.description
        
    }


    private func configureBack(_ back: UIView){
        back.layer.cornerRadius = 15
        back.layer.borderWidth = 1
        back.layer.borderColor = UIColor.darkGray.cgColor
    }

    public func configureItems(categoryName: String, productName: String, productImage:String, topBidName: String, topBidLocation: String, topBidTime: String, topBidPrice: String, prRate:String, prVote:String, prDesc:String, cpBackgroundClr: CGColor, cpPrimaryClr: CGColor, cpPercentClr: UIColor, cpPercentage: Int, cpStrokeEnd: Double, sName: String, sPrice: String, sLoc: String, description: String){
        
        product = ProductDetailViewModel(categoryName: categoryName, productName: productName, productImage: productImage, topBidName: topBidName, topBidLocation: topBidLocation, topBidTime: topBidTime, topBidPrice: topBidPrice, prRate: prRate, prVote: prVote, prDesc: prDesc, cpBackgroundClr: cpBackgroundClr, cpPrimaryClr: cpPrimaryClr, cpPercentClr: cpPercentClr, cpPercentage: cpPercentage, cpStrokeEnd: cpStrokeEnd, sName: sName, sPrice: sPrice, sLoc: sLoc, description: description)
    }
}
