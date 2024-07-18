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
    

    @IBOutlet weak var PlaceBidButton: UIButton!
    var product = ProductDetailViewModel(categoryName: "No Category", productName: "No Name", productImage: "", topBidName: "No Name", topBidLocation: "No Location", topBidTime: "", topBidPrice: "$0",topBidImage: "", prRate: "0.0", prVote: "0", prDesc: "", cpBackgroundClr: UIColor.gray.cgColor, cpPrimaryClr: UIColor.tertiarySystemBackground.cgColor, cpPercentClr: .gray, cpPercentage: 100, cpStrokeEnd: 1.0, sName: "No Name", sPrice: "$0", sLoc: "No Location",sImage: "", description: "", timeLeft: 0)
    
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
        
        TopBidImage.layer.cornerRadius = TopBidImage.frame.height/2
        SellerImage.layer.cornerRadius = SellerImage.frame.height/2
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
        guard let urlT = URL(string: product.topBidImage) else{
            return
        }
        TopBidImage.sd_setImage(with: urlT)
        
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
        guard let urlS = URL(string: product.sImage) else{
            return
        }
        SellerImage.sd_setImage(with: urlS)
        RatingView.rate = [0.1, 1.1, 2.1, 3.1, 4.1, 5.0].randomElement() ?? 0.0
        
        Description.text = product.description
        
        
        PlaceBidButton.layer.shadowRadius = 5
        PlaceBidButton.layer.shadowOpacity = 0.3
        PlaceBidButton.layer.shadowOffset = CGSize(width: 0, height: 8)
    }


    private func configureBack(_ back: UIView){
        back.layer.cornerRadius = 15
        back.layer.borderWidth = 1
        back.layer.borderColor = UIColor.darkGray.cgColor
    }

    public func configureItems(categoryName: String, productName: String, productImage:String, topBidName: String, topBidLocation: String, topBidTime: String, topBidPrice: String, topBidImg:String, prRate:String, prVote:String, prDesc:String, cpBackgroundClr: CGColor, cpPrimaryClr: CGColor, cpPercentClr: UIColor, cpPercentage: Int, cpStrokeEnd: Double, sName: String, sPrice: String, sLoc: String, sImg:String, description: String, tLeft: Int){
        
        product = ProductDetailViewModel(categoryName: categoryName, productName: productName, productImage: productImage, topBidName: topBidName, topBidLocation: topBidLocation, topBidTime: topBidTime, topBidPrice: topBidPrice,topBidImage: topBidImg, prRate: prRate, prVote: prVote, prDesc: prDesc, cpBackgroundClr: cpBackgroundClr, cpPrimaryClr: cpPrimaryClr, cpPercentClr: cpPercentClr, cpPercentage: cpPercentage, cpStrokeEnd: cpStrokeEnd, sName: sName, sPrice: sPrice, sLoc: sLoc,sImage: sImg, description: description, timeLeft: tLeft)
    }
   
    @IBAction func BidTapped(_ sender: Any) {
        let bidView = PlaceBidController()
       
        bidView.configure(minA: TopBidPrice.text ?? "" , sellN: SellerName.text ?? "", sellL: SellerLocation.text ?? "", topN: TopBidName.text ?? "", sellImg: product.sImage, topBidImg: product.topBidImage, tLeft: product.timeLeft)
        let nav = UINavigationController(rootViewController: bidView)
        nav.modalPresentationStyle = .pageSheet
        nav.isModalInPresentation = true
        nav.presentingViewController?.view.isUserInteractionEnabled = true
        
        if let sheet = nav.sheetPresentationController{
            sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        
        let cancel = UIBarButtonItem(title: "Cancel", primaryAction: UIAction(handler: { _ in
            bidView.dismissPresentedView(nil)
            
        }))
        let done = UIBarButtonItem(title: "00:00:00", primaryAction: nil)
        bidView.navigationItem.leftBarButtonItem = cancel
        bidView.navigationItem.rightBarButtonItem = done
        bidView.navigationController?.navigationBar.tintColor = .systemGray5
        present(nav, animated: true, completion: nil)
    }
    
   
    
}
