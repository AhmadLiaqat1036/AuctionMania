//
//  DiscoverViewController.swift
//  AuctionMania
//
//  Created by usear on 6/12/24.
//

import UIKit
import SDWebImage

class DiscoverViewController: UIViewController {

    private var Products = [Product]()
    @IBOutlet weak var discoverTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Discover"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        let nib = UINib(nibName: "SmallTableCell", bundle: nil)
        discoverTable.register(nib, forCellReuseIdentifier: "SmallTableCell")
        discoverTable.allowsSelection = false
        discoverTable.showsVerticalScrollIndicator = false
        discoverTable.delegate = self
        discoverTable.dataSource = self
        fetchAllProducts()
    }
    func fetchAllProducts(){
        APICaller.shared.getAllProductsFromFakeStore { [weak self] results in
            switch results{
            case .success(let products):
                print("fetch success")
                self?.Products = products
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
            case .failure(let error):
                print("fetch failure")
                print(error)
            }
        }
    }
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Products.count / 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        350
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = discoverTable.dequeueReusableCell(withIdentifier: "SmallTableCell", for: indexPath) as? SmallTableCell else {return UITableViewCell()}
        let p1 = Products[indexPath.row * 2]
        let p2 = Products[(indexPath.row * 2) + 1]
        cell.firstCell.productName.text = p1.title
        cell.secondCell.productName.text = p2 .title
        cell.firstCell.productBid.text = "$"+String(p1.price)
        cell.secondCell.productBid.text = "$"+String(p2.price)
        cell.firstCell.rating.rate = p1.rating.rate ?? 0
        cell.secondCell.rating.rate = p2.rating.rate ?? 0
        //cell.firstCell.upDownTag.text = String(p1.rating.count ?? 0)
        cell.secondCell.upDownTag.text = String(p2.rating.count ?? 0)
        if p1.rating.count ?? 0 <= 9 {
            cell.firstCell.upDownTagBackgroundWidth.constant = 45
        } else if (p1.rating.count ?? 0) > 9 && (p1.rating.count ?? 0) <= 999{
            cell.firstCell.upDownTagBackgroundWidth.constant = 66
        }
        if p2.rating.count ?? 0 <= 9 {
            cell.secondCell.upDownTagBackgroundWidth.constant = 45
        } else if (p2.rating.count ?? 0) > 9 && (p2.rating.count ?? 0) <= 999{
            cell.secondCell.upDownTagBackgroundWidth.constant = 66
        }
        guard let url1 = URL(string: p1.image ?? "") else {return UITableViewCell()}
        cell.firstCell.image.sd_setImage(with: url1, completed: nil)
        guard let url2 = URL(string: p2.image ?? "") else {return UITableViewCell()}
        cell.secondCell.image.sd_setImage(with: url2, completed: nil)
        
        
        
        return cell
    }
    
    
    
}
