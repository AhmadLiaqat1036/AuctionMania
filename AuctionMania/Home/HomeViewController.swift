//
//  HomeViewController.swift
//  AuctionMania
//
//  Created by usear on 6/12/24.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
     private var Products = [Product]()
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    //MARK: init

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "BigTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BigTableViewCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        let headerView = HomeTableHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 330))
        let footer = HomeTableFooter(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 150))
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footer
        fetchAllProducts()
    }
    
    func fetchAllProducts(){
        APICaller.shared.getAllProductsFromFakeStore { [weak self] results in
            switch results{
            case .success(let products):
                print("fetch success")
                self?.Products = products
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("fetch failure")
                print(error)
            }
        }
    }
}
//MARK: extensions

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Products.count
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
        
        let product = Products[indexPath.row]
        
        guard let urlImg = URL(string: product.image ?? "") else {return UITableViewCell()}
        cell.CarImage.sd_setImage(with: urlImg, completed: nil)
        cell.CarType.text = product.category
        cell.Bid.text = "$"+String(product.price)
        cell.CarComapanyName.text = product.title
        cell.CarName.text = product.description
        return cell
    }
}

