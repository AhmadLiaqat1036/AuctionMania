//
//  InterestsViewController.swift
//  AuctionMania
//
//  Created by usear on 6/12/24.
//

import UIKit

class InterestsViewController: UIViewController {

    @IBOutlet weak var InterestsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        let nib = UINib(nibName: "BigTableViewCell", bundle: nil)
        InterestsTable.register(nib, forCellReuseIdentifier: "BigTableViewCell")
        InterestsTable.showsVerticalScrollIndicator = false
        InterestsTable.delegate = self
        InterestsTable.dataSource = self
        InterestsViewModel.shared.getAllTitlesFromCoreData()
    }
    
    func bindViewModel(){
        InterestsViewModel.shared.APISuccessDidChange = {success in
           if success {
               print("API fetch success")
               InterestsViewModel.shared.deleteAllInterests()
           }else{
               print("API fetch failure")
           }
       }
        InterestsViewModel.shared.deleteAllSuccessDidChange = {
            success in
               if success {
                   print("delete all success")
                   InterestsViewModel.shared.putInterestsInCoreData()
               }else{
                   print("delete all failure")
               }
        }
        InterestsViewModel.shared.puttingCoreDataSuccessDidChange = {success in
            if success{
                print("putting in COREDATA success")
                InterestsViewModel.shared.getAllTitlesFromCoreData()
            }else{
                print("putting in COREDATA failure")
            }
            
        }
        InterestsViewModel.shared.fetchingCoreDataSuccessDidChange = {success in
            if success{
                print("fetching from COREDATA success")
                DispatchQueue.main.async {
                    self.InterestsTable.reloadData()
                }
            }else{
                print("fetching from COREDATA failure")
            }
            
        }
    }
    @objc func handleInterestIsOffNotification(_ notification: Notification) {
        print("reached viewmodel off")
        if let userInfo = notification.userInfo {
            if let productName = userInfo["name"] as? String {
                print("Received InterestIsOff notification for product: \(productName)")
                // Handle the notification as needed
            }
        }
    }
    @objc func handleInterestIsOnNotification(_ notification: Notification) {
        print("reached viewmodel on")
        if let userInfo = notification.userInfo {
            if let productName = userInfo["name"] as? String {
                print("Received InterestIsOff notification for product: \(productName)")
                // Handle the notification as needed
            }
        }
    }

}

extension InterestsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        InterestsViewModel.shared.InterestsCore.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = InterestsTable.dequeueReusableCell(withIdentifier: "BigTableViewCell", for: indexPath) as? BigTableViewCell else {return UITableViewCell()}
        let product = InterestsViewModel.shared.InterestsCore[indexPath.row]
        guard let urlImg = URL(string: product.image ?? "") else {return UITableViewCell()}
        cell.CarImage.sd_setImage(with: urlImg, completed: nil)
        
        cell.BigPriceLabel.text = String(product.price).formatToDollar
        cell.CarComapanyName.text = product.name
       
        
        cell.CarCompanyImageLabel.text = String(Int((product.rate) / 5.0 * 100)) + "%"
        
        switch product.rate {
        case 0.0...0.9:
            cell.CarCompanyImage.tintColor = .systemRed
            cell.CarCompanyImageLabel.textColor = .systemRed
        case 1.0...1.9:
            cell.CarCompanyImage.tintColor = .systemPink.withAlphaComponent(0.8)
            cell.CarCompanyImageLabel.textColor = .systemPink.withAlphaComponent(0.8)
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.InterestsTable.deselectRow(at: indexPath, animated: true)
                // Handle delete action
            InterestsViewModel.shared.deleteCell(at: indexPath)
                completionHandler(true)
            }
            
            // Customize the delete action
            deleteAction.backgroundColor = .red
            
            // Return swipe actions configuration
            return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
