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
    
    

    var viewModel = DiscoverViewModel()
    
    @IBOutlet weak var discoverTable: UITableView!
    
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.hudView.layer.borderWidth = 1
        hud.hudView.layer.borderColor = UIColor.systemYellow.cgColor
        hud.textLabel.text = "Loading"
        hud.textLabel.textColor = .label
        return hud
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        title = "Discover"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        let nib = UINib(nibName: "SmallTableCell", bundle: nil)
        discoverTable.register(nib, forCellReuseIdentifier: "SmallTableCell")
        discoverTable.allowsSelection = false
        discoverTable.showsVerticalScrollIndicator = false
        discoverTable.delegate = self
        discoverTable.dataSource = self
        discoverTable.tableHeaderView = DiscoverTableHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
        hud.show(in: self.view)
        viewModel.fetchAllProducts()
        
    }
    func bindViewModel(){
        viewModel.APISuccessDidChange = { [weak self] success in
           if success {
               print("fetch success")
               self?.viewModel.categoriesSelected = false
               DispatchQueue.main.async {
                   self?.hud.dismiss(afterDelay: 0.5)
                  
                   self?.discoverTable.reloadData()
               }
           }else{
               print("fetch failure")
           }
       }
        viewModel.categorySuccessDidChange = { [weak self] success in
            if success {
                print("fetch success")
                DispatchQueue.main.async {
                    self?.viewModel.categoriesSelected = true
//                    self?.hud.dismiss(afterDelay: 0.5)
                    self?.discoverTable.reloadData()
                }
            }else{
                print("fetch failure")
            }
            
        }
    
    }
     
    
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !viewModel.categoriesSelected{
            viewModel.Products.count / 2
        }else{
            viewModel.categories.count / 2
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        350
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = discoverTable.dequeueReusableCell(withIdentifier: "SmallTableCell", for: indexPath) as? SmallTableCell else {return UITableViewCell()}
        let p1:Product
        let p2:Product
        if !viewModel.categoriesSelected{
             p1 = viewModel.Products[indexPath.row * 2]
             p2 = viewModel.Products[(indexPath.row * 2) + 1]
        }else{
             p1 = viewModel.categories[indexPath.row * 2]
             p2 = viewModel.categories[(indexPath.row * 2) + 1]
        }
            cell.firstCell.productName.text = p1.title
            cell.secondCell.productName.text = p2 .title
            
            cell.firstCell.productBid.text = String(p1.price).formatToDollar
            cell.secondCell.productBid.text = String(p2.price).formatToDollar
            
            cell.firstCell.rating.rate = p1.rating.rate ?? 0
            cell.secondCell.rating.rate = p2.rating.rate ?? 0
            
            cell.firstCell.upDownTag.text = String(p1.rating.count ?? 0)
            cell.secondCell.upDownTag.text = String(p2.rating.count ?? 0)
            
            cell.firstCell.upDownTagBackgroundWidth.constant = viewModel.findUpDownTagBackgroundWidth(p1.rating.count ?? 0)
            cell.secondCell.upDownTagBackgroundWidth.constant = viewModel.findUpDownTagBackgroundWidth(p2.rating.count ?? 0)
            
            guard let url1 = URL(string: p1.image ?? "") else {return UITableViewCell()}
            cell.firstCell.image.sd_setImage(with: url1, completed: nil)
            guard let url2 = URL(string: p2.image ?? "") else {return UITableViewCell()}
            cell.secondCell.image.sd_setImage(with: url2, completed: nil)
        
        cell.firstCell.InterestButton.tintColor = [.systemYellow, .label].randomElement()
        cell.secondCell.InterestButton.tintColor = [.systemYellow, .label].randomElement()
        
        
        
        return cell
    }
    
    
    
}
