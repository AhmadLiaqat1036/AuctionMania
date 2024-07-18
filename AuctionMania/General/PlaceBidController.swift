//
//  PlaceBidController.swift
//  AuctionMania
//
//  Created by usear on 7/8/24.
//

import UIKit

class PlaceBidController: UIViewController {
    
    var timer = Timer()

    @IBOutlet var BackgroundGradient: Gradient!
    @IBOutlet weak var FirstBackground: UIView!
    @IBOutlet weak var Secondbackground: UIView!
    @IBOutlet weak var PlusButton: UIButton!
    @IBOutlet weak var MinusButton: UIButton!
    @IBOutlet weak var BidAmount: UILabel!
    @IBOutlet weak var MinimumAmount: UILabel!
    @IBOutlet weak var SellerName: UILabel!
    @IBOutlet weak var SellerLocation: UILabel!
    @IBOutlet weak var TopName: UILabel!
    @IBOutlet weak var TopBid: UILabel!
    @IBOutlet weak var SellerImage: UIImageView!
    @IBOutlet weak var TopBidImgae: UIImageView!
    private var amount = 0
    private var minAmount: String = "$0"{
        didSet{
            amount = minAmount.extractNumber() ?? 0
        }
    }
    private var sellerName = "No Name"
    private var sellerLocation = "No Location"
    private var topName = "No Name"
    private var timeLeft = "00:00:00"
    private var sImage = ""
    private var tImage = ""
    private var counter = 0{
        didSet{
            let t = Constants.secondsToHourMinutesSeconds(counter)
            timeLeft = Constants.hourMinutesSecondsIntoString(hour: t.0, min: t.1, sec: t.2)
            
        }
    }
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPresentedView(_:)))
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:))))
        presentingViewController?.view.addGestureRecognizer(tapGesture)
        FirstBackground.layer.cornerRadius = 10
        FirstBackground.layer.borderWidth = 1
        FirstBackground.layer.borderColor = UIColor.darkGray.cgColor
        Secondbackground.layer.cornerRadius = 10
        Secondbackground.layer.masksToBounds = true
        Secondbackground.layer.borderWidth = 1
        Secondbackground.layer.borderColor = UIColor.darkGray.cgColor
        TopBidImgae.layer.cornerRadius = TopBidImgae.frame.height/2
        SellerImage.layer.cornerRadius = SellerImage.frame.height/2
        timer = Timer.scheduledTimer(timeInterval: 1, target: self , selector: #selector(stepTime), userInfo: nil, repeats: true)
        setupData()
    }
    @IBAction func MakeBid(_ sender: Any) {
        showAlert("Make Bid", message: "Place a Bid of \(BidAmount.text ?? "$0")?") {[weak self] yes in
            if yes{
                self?.dismissPresentedView(nil)
            }
        }
        
        
    }
    func setupData(){
        BidAmount.text = String(amount).addCommaAfterThree.formatToDollar
        MinimumAmount.text = "The minimum bid is "+minAmount
        SellerName.text = sellerName
        SellerLocation.text = sellerLocation
        TopName.text = topName
        TopBid.text = minAmount
        guard let urlS = URL(string: sImage) else {return}
        guard let urlt = URL(string: tImage) else {return}
        SellerImage.sd_setImage(with: urlS)
        TopBidImgae.sd_setImage(with: urlt)
        navigationItem.rightBarButtonItem?.title = timeLeft
    }
    func configure(minA:String, sellN:String, sellL:String, topN:String, sellImg:String, topBidImg:String, tLeft: Int){
        minAmount = minA
        sellerName = sellN
        sellerLocation = sellL
        topName = topN
        sImage = sellImg
        tImage = topBidImg
        counter = tLeft
    }
    @objc func stepTime(){
        if(counter>0){
            counter-=1
            let time = Constants.secondsToHourMinutesSeconds(counter)
            let label = Constants.hourMinutesSecondsIntoString(hour: time.0, min: time.1, sec: time.2)
            navigationItem.rightBarButtonItem?.title = label
        }else{
            timer.invalidate()
        }
    }
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    @objc func panGesture(_ sender: UIPanGestureRecognizer){
        
        let touchPoint = sender.location(in: self.view?.window)

        if sender.state == UIGestureRecognizer.State.began {
                initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            navigationController?.navigationBar.tintColor = .clear
                if touchPoint.y - initialTouchPoint.y > 0 {
                    self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
                }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            navigationController?.navigationBar.tintColor = .systemGray5
            if (touchPoint.y - initialTouchPoint.y > 150) && (self.sheetPresentationController?.selectedDetentIdentifier != .large) {
                print("dismiss wala")
                        dismissPresentedView(nil)
                        
                }else if (touchPoint.y - initialTouchPoint.y > 50) && (self.sheetPresentationController?.selectedDetentIdentifier == .large){
                    print("medium wala")
                        self.sheetPresentationController?.animateChanges {
                            self.sheetPresentationController?.selectedDetentIdentifier = .medium
                        
                    }
                }else if (touchPoint.y - initialTouchPoint.y < 0){
                    print("large wala")
                    self.sheetPresentationController?.animateChanges {
                        self.sheetPresentationController?.selectedDetentIdentifier = .large
                    }
                } else {
                    print("else wala")
                    UIView.animate(withDuration: 0.3, animations: {
                        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    })
                }
            }
    }

    @objc func dismissPresentedView(_ gesture: UITapGestureRecognizer?){
        print("tap made")
        presentingViewController?.view.removeGestureRecognizer(tapGesture)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func StepDown(_ sender: Any) {
        amount -= 1
        BidAmount.text = String(amount).addCommaAfterThree.formatToDollar
    }
    @IBAction func StepUp(_ sender: Any) {
        amount += 1
        BidAmount.text = String(amount).addCommaAfterThree.formatToDollar
    }
}
