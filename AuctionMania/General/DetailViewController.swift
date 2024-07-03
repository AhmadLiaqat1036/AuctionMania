//
//  DetailViewController.swift
//  AuctionMania
//
//  Created by usear on 7/3/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var CategoryBack: UIView!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var SellerViewBack: UIView!
    @IBOutlet weak var SellerImage: UIImageView!
    @IBOutlet weak var SellerName: UILabel!
    @IBOutlet weak var SellerLocation: UILabel!
    @IBOutlet weak var InitialPrice: UILabel!
    @IBOutlet weak var Rating: UILabel!
    @IBOutlet weak var RatingView: FiveStarRatingView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
