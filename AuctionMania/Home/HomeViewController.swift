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
        let hud = JGProgressHUD(style: .extraLight)
        hud.hudView.layer.borderWidth = 1
        hud.hudView.layer.borderColor = UIColor.systemYellow.cgColor
        hud.textLabel.text = "Loading"
        hud.textLabel.textColor = .label
        return hud
    }()
    
    let successHud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .extraLight)
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.hudView.layer.borderWidth = 1
        hud.hudView.layer.borderColor = UIColor.systemGreen.cgColor
        hud.textLabel.text = 
"""
Login
Successful
"""
        return hud
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
        let headerView = HomeTableHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 330))
        let footer = HomeTableFooter(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 150))
        headerView.isHidden = true
        footer.isHidden = true
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footer
        
       
        hud.show(in: self.view)
        

        viewModel.fetchAllProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    func bindViewModel(){
        viewModel.APISuccessDidChange = { [weak self] success in
           if success {
//               print("fetch success")
               DispatchQueue.main.async {
                   self?.hud.dismiss(afterDelay: 0.3)
                   self?.successHud.show(in: (self?.view)!)
                   self?.successHud.dismiss(afterDelay: 1)
                   self?.tableView.tableHeaderView?.isHidden = false
                   self?.tableView.tableFooterView?.isHidden = false
                   self?.tableView.reloadData()
               }
           }else{
//               print("fetch failure")
           }
       }
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
        //        switch indexPath.row{
        //        case 0:
        //            cell.CarImage.image =  UIImage(named: "images-2")
        //            cell.CarType.text = "Sport"
        //        case 1:
        //            cell.CarImage.image =  UIImage(named: "images-3")
        //            cell.CarType.text = "Hypercar"
        //        case 2:
        //            cell.CarImage.image =  UIImage(named: "images-4")
        //            cell.CarType.text = "Sedan"
        //
        //        case 3:
        //            cell.CarImage.image =  UIImage(named: "images")
        //            cell.CarType.text = "SUV"
        //        default:
        //            break
        //        }
        
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
        
        let randomTime = Constants.timeLeft.randomElement()
        cell.TimeLeft.text = randomTime
        let anotheranotherlabel = UILabel()
        anotheranotherlabel.text =  randomTime
        anotheranotherlabel.font = .systemFont(ofSize: 14, weight: .regular)
        cell.TimeLeftBackgroundWidth.constant = 5+20+5+anotheranotherlabel.intrinsicContentSize.width+5
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            tableView.deselectRow(at: indexPath, animated: true)
            
            let randomPrice = Constants.mergedPrices.randomElement() ?? Constants.PriceInfo(originalPrice: "$0", price100Less: "$0")

            // Instantiate ProductDetailViewController from .xib
            
            let vc = ProductDetailViewController(nibName: "ProductDetailViewController", bundle: nil)

            // Configure ProductDetailViewController with data
            guard let product = self?.viewModel.Products[indexPath.row] else { return }
            vc.configureItems(categoryName: product.category?.capitalized ?? "No Category",
                              productName: product.title,
                              productImage: product.image ?? "",
                              topBidName: Constants.randomFullNames.randomElement() ?? "",
                              topBidLocation: Constants.moreAsianPlaces.randomElement() ?? "",
                              topBidTime: Constants.randomDatesAndTimes.randomElement() ?? "No Date",
                              topBidPrice: randomPrice.originalPrice,
                              prRate: String(product.rating.rate ?? 0.0),
                              prVote: String(product.rating.count ?? 0),
                              prDesc: Constants.description(for: product.rating.rate ?? 6.0),
                              cpBackgroundClr: Constants.getColourOnRating(rating: product.rating.rate ?? 0.0).withAlphaComponent(0.5).cgColor,
                              cpPrimaryClr: Constants.getColourOnRating(rating: product.rating.rate ?? 0.0).cgColor,
                              cpPercentClr: Constants.getColourOnRating(rating: product.rating.rate ?? 0.0),
                              cpPercentage: Int((product.rating.rate ?? 0.0) / 5.0) * 100,
                              cpStrokeEnd: (product.rating.rate ?? 0.0) / 5.0,
                              sName: Constants.sellerNames.randomElement() ?? "No Name",
                              sPrice: randomPrice.price100Less,
                              sLoc: Constants.moreAsianPlaces.randomElement() ?? "No Location",
                              description: product.description ?? "")

            // Push ProductDetailViewController onto navigation stack
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        tableView.deselectRow(at: indexPath, animated: true)
//        let randomPrice = Constants.mergedPrices.randomElement() ?? Constants.PriceInfo(originalPrice: "$0", price100Less: "$0")
//        let product = viewModel.Products[indexPath.row]
//            
//
//        DispatchQueue.main.async { [weak self] in
////            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController else {
////                return
////            }
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
//            self?.navigationController?.pushViewController(vc, animated: false)
////            let vc = ProductDetailViewController()
////
////            self?.navigationController?.pushViewController(vc, animated: true)
//            
////            performSegue(withIdentifier: "showDetail", sender: self)
//            
//            vc.configureItems(productName: product.title, productImage: product.image ?? "" , topBidName: Constants.randomFullNames.randomElement() ?? "", topBidLocation: Constants.moreAsianPlaces.randomElement() ?? "", topBidTime: Constants.randomDatesAndTimes.randomElement() ?? "No Date", topBidPrice: randomPrice.originalPrice, prRate: String(product.rating.rate ?? 0.0), prVote: String(product.rating.count ?? 0), prDesc: Constants.description(for: product.rating.rate ?? 6.0), cpBackgroundClr: UIColor.orange.withAlphaComponent(0.5).cgColor, cpPrimaryClr: UIColor.systemYellow.cgColor, cpPercentClr: .green, cpPercentage: Int((product.rating.rate ?? 0.0)/5.0)*100, cpStrokeEnd: (product.rating.rate ?? 0.0)/5.0, sName: Constants.sellerNames.randomElement() ?? "No Name", sPrice: randomPrice.price100Less, sLoc: Constants.moreAsianPlaces.randomElement() ?? "No Location", description: product.description ?? "")
//            
//            
//        }
//        
//    }
}

