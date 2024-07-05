//
//  InterestsViewController.swift
//  AuctionMania
//
//  Created by usear on 6/12/24.
//

import UIKit



class InterestsViewController: UIViewController {

    @IBOutlet weak var InterestsTable: UITableView!
    
    var shouldDelete = false
    var deleteConfirmationAlert: UIAlertController{
        let alert = UIAlertController(title: "Delete from interests?", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive))
                        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
        return alert
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        navigationController?.modalPresentationStyle = .overCurrentContext
        
        navigationItem.rightBarButtonItem = editButtonItem
        navigationController?.navigationBar.backgroundColor = .systemBackground
        let nib = UINib(nibName: "BigTableViewCell", bundle: nil)
        InterestsTable.register(nib, forCellReuseIdentifier: "BigTableViewCell")
        InterestsTable.showsVerticalScrollIndicator = false
        InterestsTable.delegate = self
        InterestsTable.dataSource = self
        InterestsTable.isHidden = false
        InterestsTable.tableHeaderView = NoResultView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        InterestsTable.tableHeaderView?.isHidden = true
//        print("IVC-> \(InterestsViewModel.shared.interestsNames)")
        InterestsViewModel.shared.getAllTitlesFromCoreData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        InterestsTable.setEditing(editing, animated: animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .systemBackground
        self.isEditing = false
        if InterestsViewModel.shared.InterestsCore.isEmpty{
            navigationItem.rightBarButtonItem?.isHidden = true
            InterestsTable.tableHeaderView?.isHidden = false
        }else{
            navigationItem.rightBarButtonItem?.isHidden = false
            
            InterestsTable.tableHeaderView?.isHidden = true
        }
    }
    func bindViewModel(){
        InterestsViewModel.shared.APISuccessDidChange = {success in
           if success {
//               print("API fetch-> success")
               InterestsViewModel.shared.deleteAllInterests()
           }else{
//               print("API fetch-> failure")
           }
       }
        InterestsViewModel.shared.deleteAllSuccessDidChange = {
            success in
               if success {
//                   print("delete all-> success")
                   InterestsViewModel.shared.putInterestsInCoreData()
               }else{
//                   print("delete all-> failure")
               }
        }
        InterestsViewModel.shared.puttingCoreDataSuccessDidChange = {success in
            if success{
//                print("putting in COREDATA-> success")
                InterestsViewModel.shared.getAllTitlesFromCoreData()
            }else{
//                print("putting in COREDATA-> failure")
            }
            
        }
        InterestsViewModel.shared.fetchingCoreDataSuccessDidChange = {[weak self] success in
            if success{
//                print("fetching from COREDATA-> success")
                if InterestsViewModel.shared.InterestsCore.isEmpty{
//                    print("->Going to show No result")
                    DispatchQueue.main.async{
                        self?.InterestsTable.tableHeaderView?.isHidden = false
                        self?.InterestsTable.reloadData()
                    }
                }else{
                    InterestsViewModel.shared.fetchInterestNamesFromInterestsCore()
                    DispatchQueue.main.async {
                        self?.InterestsTable.tableHeaderView?.isHidden = true
                        self?.InterestsTable.reloadData()
                    }
                }
            }else{
//                print("fetching from COREDATA-> failure")
            }
            
        }
    }
    func showAlert(_ title: String? = "Message", message: String?, completion: @escaping (_ isYes: Bool) -> Void) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { alert in
          completion(true)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { alert in
          completion(false)
        })
        self.present(alert, animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            self?.InterestsTable.deselectRow(at: indexPath, animated: true)
            
            let randomPrice = Constants.mergedPrices.randomElement() ?? Constants.PriceInfo(originalPrice: "$0", price100Less: "$0")
            
            // Instantiate ProductDetailViewController from .xib
            
            let vc = ProductDetailViewController(nibName: "ProductDetailViewController", bundle: nil)
            
            // Configure ProductDetailViewController with data
            let product = InterestsViewModel.shared.InterestsCore[indexPath.row]
            vc.configureItems(categoryName: product.category?.capitalized ?? "No Category",
                              productName: product.name ?? "No Name",
                              productImage: product.image ?? "",
                              topBidName: Constants.randomFullNames.randomElement() ?? "",
                              topBidLocation: Constants.moreAsianPlaces.randomElement() ?? "",
                              topBidTime: Constants.randomDatesAndTimes.randomElement() ?? "No Date",
                              topBidPrice: randomPrice.originalPrice,
                              prRate: String(product.rate),
                              prVote: String(product.count),
                              prDesc: Constants.description(for: product.rate),
                              cpBackgroundClr: Constants.getColourOnRating(rating: product.rate).withAlphaComponent(0.5).cgColor,
                              cpPrimaryClr: Constants.getColourOnRating(rating: product.rate).cgColor,
                              cpPercentClr: Constants.getColourOnRating(rating: product.rate),
                              cpPercentage: Int((product.rate) / 5.0) * 100,
                              cpStrokeEnd: (product.rate) / 5.0,
                              sName: Constants.sellerNames.randomElement() ?? "No Name",
                              sPrice: randomPrice.price100Less,
                              sLoc: Constants.moreAsianPlaces.randomElement() ?? "No Location",
                              description: product.desc ?? "")
            
            // Push ProductDetailViewController onto navigation stack
            
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
        
        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            .delete
        }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete{
                showAlert("Delete product", message: "Are you sure you want to delete product from interests?", completion: {[weak self] yes in
                    if yes {
                        tableView.beginUpdates()
                        InterestsViewModel.shared.deleteCell(at: indexPath)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        tableView.endUpdates()
                        if InterestsViewModel.shared.InterestsCore.isEmpty{
                            self?.navigationItem.rightBarButtonItem?.isHidden = true
                            self?.InterestsTable.tableHeaderView?.isHidden = false
                        }
                    }
                })
            }
        }
    }
