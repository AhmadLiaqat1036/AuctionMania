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
    
    func bindViewModel(){
        viewModel.APISuccessDidChange = { [weak self] success in
           if success {
               print("fetch success")
               DispatchQueue.main.async {
                   self?.hud.dismiss(afterDelay: 0.3)
                   self?.successHud.show(in: (self?.view)!)
                   self?.successHud.dismiss(afterDelay: 1)
                   self?.tableView.tableHeaderView?.isHidden = false
                   self?.tableView.tableFooterView?.isHidden = false
                   self?.tableView.reloadData()
               }
           }else{
               print("fetch failure")
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
        return 220
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
        switch product.rating.rate ?? 0{
        case 0.0...0.9:
            cell.CarCompanyImage.tintColor = .systemRed
            cell.CarCompanyImageLabel.textColor = .systemRed
        case 1.0...1.9:
            cell.CarCompanyImage.tintColor = .systemRed.withAlphaComponent(0.5)
            cell.CarCompanyImageLabel.textColor = .systemRed.withAlphaComponent(0.5)
        case 2.0...2.9:
            cell.CarCompanyImage.tintColor = .systemOrange
            cell.CarCompanyImageLabel.textColor = .systemOrange
        case 3.0...3.9:
            cell.CarCompanyImage.tintColor = .systemYellow
            cell.CarCompanyImageLabel.textColor = .systemYellow
        default:
            cell.CarCompanyImage.tintColor = .systemGreen
            cell.CarCompanyImageLabel.textColor = .systemGreen
        }
        
        
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
}

