//
//  HomeViewController.swift
//  AuctionMania
//
//  Created by usear on 6/12/24.
//

import UIKit
import SDWebImage
import JGProgressHUD


class HomeViewController: UIViewController {
    let viewModel = HomeViewModel()
   
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: huds
    var hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.layer.backgroundColor = UIColor.black.withAlphaComponent(0.3).cgColor
        hud.hudView.layer.borderWidth = 1
        hud.hudView.layer.borderColor = UIColor.darkGray.cgColor
        hud.textLabel.text = "Loading"
             
        return hud
    }()
    
    let successHud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .extraLight)
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.hudView.layer.borderWidth = 1
        hud.hudView.layer.borderColor = UIColor.darkGray.cgColor
        hud.textLabel.text =
"""
Login
Successful
"""
        hud.textLabel.textColor = .black
        return hud
    }()
    
    //MARK: pageControl
    var pageControl:UIPageControl={
        let control = UIPageControl()
        control.currentPageIndicatorTintColor = .orange
        control.pageIndicatorTintColor = .systemYellow.withAlphaComponent(0.5)
        control.numberOfPages = 5
        control.currentPage = 0
        control.isUserInteractionEnabled = false
        return control
    }()
    
    //MARK: headers
    var currentHeader = 0
    let headerView = HomeTableHeader()
    let headerView2 :HomeTableHeaderType2={
        let view = HomeTableHeaderType2()
       
        view.Image.image = UIImage(named: Constants.pics[0])
        view.Label.text = Constants.labels[0]
        return view
    }()
    let headerView3 = HomeTableHeaderType3()
    let headerView4:HomeTableHeaderType2={ 
        let view = HomeTableHeaderType2()
        view.Image.image = UIImage(named: Constants.pics[1])
        view.Label.text = Constants.labels[1]
        return view
    }()
    let headerView5 : HomeTableHeaderType3 = {
        let view = HomeTableHeaderType3()
        view.stackLabel = "Fast Shipping"
        view.background.backgroundColor = .systemIndigo
        view.labelDown.text = "Shippings arrive withing a week"
        view.labelDown.textColor = .orange
        view.image.image = UIImage(named: "Paper map-cuate")
        return view
    }()
   
    //MARK: init

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        let nib = UINib(nibName: "BigTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BigTableViewCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.gestureL = UISwipeGestureRecognizer(target: self, action: #selector(gesture(_:)))
        viewModel.gestureL.direction = .left
        viewModel.gestureL.numberOfTouchesRequired = 1
        viewModel.gestureR = UISwipeGestureRecognizer(target: self, action: #selector(gesture(_:)))
        viewModel.gestureR.direction = .right
        viewModel.gestureR.numberOfTouchesRequired = 1
        
        let footer = HomeTableFooter(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 160))
        headerView.isHidden = true
        footer.isHidden = true
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footer
        tableView.tableHeaderView?.addSubview(pageControl)
        
        tableView.tableHeaderView?.addGestureRecognizer(viewModel.gestureL)
        tableView.tableHeaderView?.addGestureRecognizer(viewModel.gestureR)
        tableView.tableHeaderView?.isUserInteractionEnabled = true
        hud.show(in: self.view)
        viewModel.fetchAllProducts()
        viewModel.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(stepTime), userInfo: nil, repeats: true)
        viewModel.headerTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(stepTimeHeader), userInfo: nil, repeats: true)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 330)
        headerView2.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 330)
        headerView3.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 330)
        headerView4.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 330)
        headerView5.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 330)
        
        headerView.gradient.frame = CGRect(x: 10, y: 10, width: headerView.bounds.width - 20 , height: 200 + 1)
        headerView2.gradient.frame = CGRect(x: 0, y: 0, width: headerView.bounds.width - 20, height: 330 - 20)
        headerView4.gradient.frame = CGRect(x: 0, y: 0, width: headerView.bounds.width - 20, height: 330 - 20)
        
        pageControl.frame = CGRect(x: headerView.bounds.midX - 75, y: headerView.bounds.height - 45, width: 150, height: 30)
    }
    
    
}
//MARK: extensions

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.Products.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BigTableViewCell", for: indexPath) as? BigTableViewCell else {return UITableViewCell()}
        let product = viewModel.Products[indexPath.row]
        
        guard let urlImg = URL(string: product.image ?? "") else {return UITableViewCell()}
        cell.CarImage.sd_setImage(with: urlImg, completed: nil)
        
        cell.BigPriceLabel.text = String(product.price).formatToDollar
        cell.CarComapanyName.text = product.title
       
        
        cell.CarCompanyImageLabel.text = String(Int((product.rating.rate ?? 0) / 5.0 * 100)) + "%"
        
        
        cell.CarCompanyImage.tintColor = Constants.getColourOnRating(rating: product.rating.rate ?? 0.0)
        cell.CarCompanyImageLabel.textColor = Constants.getColourOnRating(rating: product.rating.rate ?? 0.0)
        
        let randomSeller = Constants.sellerNames.randomElement()
        cell.Seller.text = randomSeller
        let label = UILabel()
        label.text = randomSeller
        label.font = .systemFont(ofSize: 14, weight: .regular)
        cell.SellerBackgroundWidth.constant = 5+20+5+label.intrinsicContentSize.width+5
        
        
        
        cell.CarType.text = product.category?.capitalized
        let anotherlabel = UILabel()
        anotherlabel.text =  product.category?.capitalized
        anotherlabel.font = .systemFont(ofSize: 14, weight: .regular)
        cell.CategoryBackgroundWidth.constant =
        5+20+5+anotherlabel.intrinsicContentSize.width+5
        
        cell.TimeLeft.text = viewModel.counterLabels[indexPath.row]
        

        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            tableView.deselectRow(at: indexPath, animated: true)
            
            let randomPrice = Constants.mergedPrices.randomElement() ?? Constants.PriceInfo(originalPrice: "$0", price100Less: "$0")
            let randomName = Constants.fullNames.randomElement() ?? "Zayn Malik"
            let randomImage = Constants.menNames.contains { name in
                name == randomName
            } ? Constants.randomProfilesMen : Constants.randomProfilesWomen
            let sellerName = Constants.fullNames.randomElement() ?? "Zayn Malik"
            let sellerImage = Constants.menNames.contains { name in
                name == sellerName } ? Constants.randomProfilesMen : Constants.randomProfilesWomen
            

            // Instantiate ProductDetailViewController from .xib
            
            let vc = ProductDetailViewController(nibName: "ProductDetailViewController", bundle: nil)

            // Configure ProductDetailViewController with data
            guard let product = self?.viewModel.Products[indexPath.row] else { return }
            vc.configureItems(categoryName: product.category?.capitalized ?? "No Category",
                              productName: product.title,
                              productImage: product.image ?? "",
                              topBidName: randomName,
                              topBidLocation: Constants.moreAsianPlaces.randomElement() ?? "",
                              topBidTime: Constants.randomDatesAndTimes.randomElement() ?? "No Date",
                              topBidPrice: randomPrice.originalPrice,
                              topBidImg: randomImage,
                              prRate: String(product.rating.rate ?? 0.0),
                              prVote: String(product.rating.count ?? 0),
                              prDesc: Constants.description(for: product.rating.rate ?? 6.0),
                              cpBackgroundClr: Constants.getColourOnRating(rating: product.rating.rate ?? 0.0).withAlphaComponent(0.5).cgColor,
                              cpPrimaryClr: Constants.getColourOnRating(rating: product.rating.rate ?? 0.0).cgColor,
                              cpPercentClr: Constants.getColourOnRating(rating: product.rating.rate ?? 0.0),
                              cpPercentage: Int((product.rating.rate ?? 0.0) / 5.0) * 100,
                              cpStrokeEnd: (product.rating.rate ?? 0.0) / 5.0,
                              sName: sellerName,
                              sPrice: randomPrice.price100Less,
                              sLoc: Constants.moreAsianPlaces.randomElement() ?? "No Location",
                              sImg: sellerImage,
                              description: product.description ?? "", tLeft: self!.viewModel.counters[indexPath.row])

            // Push ProductDetailViewController onto navigation stack
            let backItem = UIBarButtonItem()
            backItem.title = "Go Back"
            self?.navigationItem.backBarButtonItem = backItem
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController{
    @objc func stepTime(){
        if(viewModel.count>0){
            viewModel.count -= 1
            let time = Constants.secondsToHourMinutesSeconds(viewModel.count)
            let label = Constants.hourMinutesSecondsIntoString(hour: time.0, min: time.1, sec: time.2)
            headerView.timeLabel.text = label
            
        }else{
            headerView.timeLabel.text = "00:00:00"
        }
        
        if(viewModel.counters.contains(where: { count in
            count != 0
        })){
            for i in 0..<viewModel.counters.count{
                if(viewModel.counters[i]>0){
                    viewModel.counters[i] -= 1
                    let time = Constants.secondsToHourMinutesSeconds(viewModel.counters[i])
                    let label = Constants.hourMinutesSecondsIntoString(hour: time.0, min: time.1, sec: time.2)
                    viewModel.counterLabels[i] = label
                }
            }
        }else{
            viewModel.timer.invalidate()
        }
        

    }
    @objc func stepTimeHeader(){
        let headers = [headerView, headerView2, headerView3, headerView4, headerView5]
        if(viewModel.headerCounter>0){
            viewModel.headerCounter -= 1
        }else{
//            viewModel.gestureL.state = .began
//            viewModel.gestureL.state = .changed
//            viewModel.gestureL.state = .ended
            if(currentHeader < headers.count - 1){
                currentHeader += 1
                pageControl.currentPage += 1
            }else{
                currentHeader = 0
                pageControl.currentPage = 0
            }
            
            let nextHeaderView = headers[currentHeader]
            
            UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.tableView.tableHeaderView = nextHeaderView
            }, completion: { [weak self] _ in
                nextHeaderView.addGestureRecognizer(self!.viewModel.gestureL)
                nextHeaderView.addGestureRecognizer(self!.viewModel.gestureR)
                nextHeaderView.isUserInteractionEnabled = true
                self?.tableView.tableHeaderView?.addSubview(self!.pageControl)
            })
            viewModel.headerCounter = 7
        }
    }
    
    func bindViewModel(){
        viewModel.APISuccessDidChange = { [weak self] success in
           if success {
               DispatchQueue.main.async {
                   self?.hud.dismiss(afterDelay: 0.3)
                   self?.successHud.show(in: (self?.view)!)
                   self?.successHud.dismiss(afterDelay: 1)
                   self?.tableView.tableHeaderView?.isHidden = false
                   self?.tableView.tableFooterView?.isHidden = false
                   self?.tableView.reloadData()
               }
           }else{

           }
       }
    }
    
    @objc func gesture(_ gesture: UISwipeGestureRecognizer){
        let headers = [headerView, headerView2, headerView3, headerView4, headerView5]
        viewModel.headerCounter = 7
        if gesture.direction == .left{
            print("Gesture Left")
            if(currentHeader < headers.count - 1){
                currentHeader += 1
                pageControl.currentPage += 1
            }else{
                currentHeader = 0
                pageControl.currentPage = 0
            }
            
            let nextHeaderView = headers[currentHeader]
            
            UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.tableView.tableHeaderView = nextHeaderView
            }, completion: { [weak self] _ in
                // Add gesture recognizer to the new header view
                nextHeaderView.addGestureRecognizer(gesture)
                nextHeaderView.addGestureRecognizer(self!.viewModel.gestureR)
                nextHeaderView.isUserInteractionEnabled = true
                self?.tableView.tableHeaderView?.addSubview(self!.pageControl)
            })
        }else{
            print("Gesture Right")
            if(currentHeader > 0){
                currentHeader -= 1
                pageControl.currentPage -= 1
            }else{
                currentHeader = headers.count - 1
                pageControl.currentPage = headers.count - 1
            }
            
            let nextHeaderView = headers[currentHeader]
            
            UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.tableView.tableHeaderView = nextHeaderView
                }, completion: { [weak self] _ in
                    // Add gesture recognizer to the new header view
                    nextHeaderView.addGestureRecognizer(gesture)
                    nextHeaderView.addGestureRecognizer(self!.viewModel.gestureL)
                    nextHeaderView.isUserInteractionEnabled = true
                    self?.tableView.tableHeaderView?.addSubview(self!.pageControl)
                })
        }
        
    }
    
}
