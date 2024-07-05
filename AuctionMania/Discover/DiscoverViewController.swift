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
        searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.sizeToFit()
        navigationItem.hidesSearchBarWhenScrolling = false
        let nib = UINib(nibName: "SmallTableCell", bundle: nil)
        discoverTable.register(nib, forCellReuseIdentifier: "SmallTableCell")
        discoverTable.allowsSelection = false
        discoverTable.showsVerticalScrollIndicator = false
        discoverTable.delegate = self
        discoverTable.dataSource = self
        discoverTable.tableHeaderView = DiscoverTableHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 140))
        showHUD()
        DiscoverViewModel.shared.fetchAllProducts()
        InterestsViewModel.shared.getAllTitlesFromCoreData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        discoverTable.isHidden = false
        discoverTable.reloadData()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .systemBackground
    
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
        
        let p1RandomPrice = Constants.mergedPrices.randomElement()
        let p1Rating = p1.rating.rate ?? 0
        let p2RandomPrice = Constants.mergedPrices.randomElement()
        let p2Rating = p2.rating.rate ?? 0
        
        let tapFirstCell = MyTapGesture(target: self, action: #selector(handleTap(_:)))
        let tapSecondCell = MyTapGesture(target: self, action: #selector(handleTap(_:)))
        cell.firstCell.addGestureRecognizer(tapFirstCell)
        cell.secondCell.addGestureRecognizer(tapSecondCell)
        
        tapFirstCell.detail = ProductDetailViewModel(categoryName: p1.category?.capitalized ?? "", productName: p1.title, productImage: p1.image ?? "", topBidName: Constants.randomFullNames.randomElement() ?? "", topBidLocation: Constants.moreAsianPlaces.randomElement() ?? "", topBidTime: Constants.randomDatesAndTimes.randomElement() ?? "" , topBidPrice: p1RandomPrice?.originalPrice ?? "", prRate: String(p1Rating), prVote: String(p1.rating.count ?? 0), prDesc: Constants.description(for: p1Rating), cpBackgroundClr: Constants.getColourOnRating(rating: p1Rating).withAlphaComponent(0.5).cgColor, cpPrimaryClr: Constants.getColourOnRating(rating: p1Rating).cgColor, cpPercentClr: Constants.getColourOnRating(rating: p1Rating), cpPercentage: Int((p1Rating/5.0))*100, cpStrokeEnd: p1Rating/5.0, sName: Constants.sellerNames.randomElement() ?? "", sPrice: p1RandomPrice?.price100Less ?? "", sLoc: Constants.moreAsianPlaces.randomElement() ?? "", description: p1.description ?? "")
        
        tapSecondCell.detail = ProductDetailViewModel(categoryName: p2.category?.capitalized ?? "", productName: p2.title, productImage: p2.image ?? "", topBidName: Constants.randomFullNames.randomElement() ?? "", topBidLocation: Constants.moreAsianPlaces.randomElement() ?? "", topBidTime: Constants.randomDatesAndTimes.randomElement() ?? "" , topBidPrice: p2RandomPrice?.originalPrice ?? "", prRate: String(p2Rating), prVote: String(p2.rating.count ?? 0), prDesc: Constants.description(for: p2Rating), cpBackgroundClr: Constants.getColourOnRating(rating: p2Rating).withAlphaComponent(0.5).cgColor, cpPrimaryClr: Constants.getColourOnRating(rating: p2Rating).cgColor, cpPercentClr: Constants.getColourOnRating(rating: p2Rating), cpPercentage: Int((p2Rating/5.0))*100, cpStrokeEnd: p2Rating/5.0, sName: Constants.sellerNames.randomElement() ?? "", sPrice: p2RandomPrice?.price100Less ?? "", sLoc: Constants.moreAsianPlaces.randomElement() ?? "", description: p2.description ?? "")
        
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
        
        
        
        if InterestsViewModel.shared.InterestsCore.contains(where: { interest in
            interest.name == p1.title
        }){
            cell.firstCell.buttonSelected = true
            cell.firstCell.InterestButton.tintColor = .systemYellow
        }else{
            cell.firstCell.buttonSelected = false
            cell.firstCell.InterestButton.tintColor = .label
        }
        if InterestsViewModel.shared.InterestsCore.contains(where: { interest in
            interest.name == p2.title
        }){
            cell.secondCell.buttonSelected = true
            cell.secondCell.InterestButton.tintColor = .systemYellow
        }else{
            cell.secondCell.buttonSelected = false
            cell.secondCell.InterestButton.tintColor = .label
        }
        
        
        return cell
    }
    
    
    
}

extension DiscoverViewController: UISearchResultsUpdating, UISearchControllerDelegate{
    func willPresentSearchController(_ searchController: UISearchController) {
        discoverTable.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        discoverTable.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else {return}
        
        DiscoverViewModel.shared.getResultsProduct(from: text)
    }
}

extension DiscoverViewController{
    func showHUD(){
        DispatchQueue.main.async{
            DiscoverViewModel.shared.hud.show(in: self.view)
        }
    }
    
    func bindViewModel(){
        DiscoverViewModel.shared.APISuccessDidChange = { [weak self] success in
           if success {
//               print("fetch success")
               DiscoverViewModel.shared.categoriesSelected = false
               DispatchQueue.main.async {
                   DiscoverViewModel.shared.hud.dismiss(afterDelay: 0.5)
                   self?.discoverTable.reloadData()
               }
           }else{
//               print("fetch failure")
           }
       }
        DiscoverViewModel.shared.categorySuccessDidChange = { [weak self] success in
            if success {
//                print("fetch success")
                DiscoverViewModel.shared.categoriesSelected = true
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                    DiscoverViewModel.shared.hud.dismiss(afterDelay: 0.5)
                }
            }else{
//                print("fetch failure")
            }
            
        }
    
    }
    @objc func handleTap(_ sender: MyTapGesture? = nil) {
        let vc = ProductDetailViewController(nibName: "ProductDetailViewController", bundle: nil)
        let product = sender?.detail
        
        vc.configureItems(categoryName: product!.categoryName,
                          productName: product!.productName,
                          productImage: product!.productImage,
                          topBidName: product!.topBidName,
                          topBidLocation: product!.topBidLocation,
                          topBidTime: product!.topBidTime,
                          topBidPrice: product!.topBidPrice,
                          prRate: product!.prRate,
                          prVote: product!.prVote,
                          prDesc: product!.prDesc,
                          cpBackgroundClr: product!.cpBackgroundClr,
                          cpPrimaryClr: product!.cpPrimaryClr,
                          cpPercentClr: product!.cpPercentClr,
                          cpPercentage: product!.cpPercentage,
                          cpStrokeEnd: product!.cpStrokeEnd,
                          sName: product!.sName,
                          sPrice: product!.sPrice,
                          sLoc: product!.sLoc,
                          description: product!.description)
        navigationController?.pushViewController(vc, animated: true)
    }

}


