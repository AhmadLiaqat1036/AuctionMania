//
//  ResultsViewController.swift
//  AuctionMania
//
//  Created by usear on 6/28/24.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        let nib = UINib(nibName: "SmallTableCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "SmallTableCell")
        table.allowsSelection = false
        table.showsVerticalScrollIndicator = false
        table.delegate = self
        table.dataSource = self
    }
    
    func bindViewModel(){
        DiscoverViewModel.shared.resultsDidChange = { [weak self] success in
            if(success){
                DispatchQueue.main.async{
                    self?.table.reloadData()
                }
            }else{
                print("result failure")
            }
            
        }
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        350
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount: Double = Double(DiscoverViewModel.shared.results.count) / 2.0
        return Int(ceil(Double(rowCount)))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: "SmallTableCell", for: indexPath) as? SmallTableCell else {return UITableViewCell()}
        let p1:Product
        let p2:Product
        cell.secondCell.isHidden = false
        if(DiscoverViewModel.shared.results.count.isEven){
            p1 = DiscoverViewModel.shared.results[indexPath.row * 2]
            p2 = DiscoverViewModel.shared.results[(indexPath.row * 2) + 1]
        }else{
            p1 = DiscoverViewModel.shared.results[indexPath.row * 2]
            if (indexPath.row * 2) + 1 == DiscoverViewModel.shared.results.count{
                p2 = Product(id: 0, title: "", price: 0, description: "", category: "", image: "jkgjgj", rating: Rating(rate: 0.0, count: 0))
                cell.secondCell.isHidden = true
            }else{
                p2 = DiscoverViewModel.shared.results[(indexPath.row * 2) + 1]
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
