//
//  DiscoverViewController.swift
//  AuctionMania
//
//  Created by usear on 6/12/24.
//

import UIKit
import SDWebImage
import JGProgressHUD

class DiscoverViewController: UIViewController {
    
    @IBOutlet weak var discoverTable: UITableView!
    
    
   let searchBar = UISearchController(searchResultsController: ResultsViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        title = "Discover"
        navigationItem.searchController = searchBar
        navigationItem.searchController?.showsSearchResultsController = true
        searchBar.searchResultsUpdater = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.sizeToFit()
        navigationItem.hidesSearchBarWhenScrolling = false
        //navigationController?.navigationBar.prefersLargeTitles = true
        let nib = UINib(nibName: "SmallTableCell", bundle: nil)
        discoverTable.register(nib, forCellReuseIdentifier: "SmallTableCell")
        discoverTable.allowsSelection = false
        discoverTable.showsVerticalScrollIndicator = false
        discoverTable.delegate = self
        discoverTable.dataSource = self
        discoverTable.tableHeaderView = DiscoverTableHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 130))
        showHUD()
        DiscoverViewModel.shared.fetchAllProducts()
        
    }
    func showHUD(){
        DispatchQueue.main.async{
            DiscoverViewModel.shared.hud.show(in: self.view)
        }
    }
    
    func bindViewModel(){
        DiscoverViewModel.shared.APISuccessDidChange = { [weak self] success in
           if success {
               print("fetch success")
               DiscoverViewModel.shared.categoriesSelected = false
               DispatchQueue.main.async {
                   DiscoverViewModel.shared.hud.dismiss(afterDelay: 0.5)
                   self?.discoverTable.reloadData()
               }
           }else{
               print("fetch failure")
           }
       }
        DiscoverViewModel.shared.categorySuccessDidChange = { [weak self] success in
            if success {
                print("fetch success")
                DiscoverViewModel.shared.categoriesSelected = true
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                    DiscoverViewModel.shared.hud.dismiss(afterDelay: 0.5)
                }
            }else{
                print("fetch failure")
            }
            
        }
    
    }
     
    
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !DiscoverViewModel.shared.categoriesSelected{
            DiscoverViewModel.shared.Products.count / 2
        }else{
            DiscoverViewModel.shared.categories.count / 2
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        350
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = discoverTable.dequeueReusableCell(withIdentifier: "SmallTableCell", for: indexPath) as? SmallTableCell else {return UITableViewCell()}
        let p1:Product
        let p2:Product
        cell.secondCell.isHidden = false
        if !DiscoverViewModel.shared.categoriesSelected{
            if(DiscoverViewModel.shared.Products.count.isEven){
                p1 = DiscoverViewModel.shared.Products[indexPath.row * 2]
                p2 = DiscoverViewModel.shared.Products[(indexPath.row * 2) + 1]
            }else{
                p1 = DiscoverViewModel.shared.Products[indexPath.row * 2]
                if (indexPath.row * 2) + 1 == DiscoverViewModel.shared.Products.count{
                    p2 = Product(id: 0, title: "", price: 0, description: "", category: "", image: "jkgjgj", rating: Rating(rate: 0.0, count: 0))
                    cell.secondCell.isHidden = true
                }else{
                    p2 = DiscoverViewModel.shared.Products[(indexPath.row * 2) + 1]
                }
            }
        }else{
            if(DiscoverViewModel.shared.categories.count.isEven){
                p1 = DiscoverViewModel.shared.categories[indexPath.row * 2]
                p2 = DiscoverViewModel.shared.categories[(indexPath.row * 2) + 1]
            }else{
                p1 = DiscoverViewModel.shared.categories[indexPath.row * 2]
                if (indexPath.row * 2) + 1 == DiscoverViewModel.shared.categories.count{
                    p2 = Product(id: 0, title: "", price: 0, description: "", category: "", image: "jkgjgj", rating: Rating(rate: 0.0, count: 0))
                    cell.secondCell.isHidden = true
                }else{
                    p2 = DiscoverViewModel.shared.categories[(indexPath.row * 2) + 1]
                }
            }
        }
            cell.firstCell.productName.text = p1.title
            cell.secondCell.productName.text = p2 .title
            
            cell.firstCell.productBid.text = String(p1.price).formatToDollar
            cell.secondCell.productBid.text = String(p2.price).formatToDollar
            
            cell.firstCell.rating.rate = p1.rating.rate ?? 0
            cell.secondCell.rating.rate = p2.rating.rate ?? 0
            
            cell.firstCell.upDownTag.text = String(p1.rating.count ?? 0)
            cell.secondCell.upDownTag.text = String(p2.rating.count ?? 0)
            
        cell.firstCell.upDownTagBackgroundWidth.constant = DiscoverViewModel.shared.findUpDownTagBackgroundWidth(p1.rating.count ?? 0)
        cell.secondCell.upDownTagBackgroundWidth.constant = DiscoverViewModel.shared.findUpDownTagBackgroundWidth(p2.rating.count ?? 0)
            
            guard let url1 = URL(string: p1.image ?? "") else {return UITableViewCell()}
            cell.firstCell.image.sd_setImage(with: url1, completed: nil)
            guard let url2 = URL(string: p2.image ?? "") else {return UITableViewCell()}
            cell.secondCell.image.sd_setImage(with: url2, completed: nil)
        
        cell.firstCell.InterestButton.tintColor = [.systemYellow, .label].randomElement()
        cell.secondCell.InterestButton.tintColor = [.systemYellow, .label].randomElement()
        
        
        
        return cell
    }
    
    
    
}

extension DiscoverViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        //guard let vc = searchController.searchResultsController as? ResultsViewController else {return}
        DiscoverViewModel.shared.getResultsProduct(from: text)
    }
}
