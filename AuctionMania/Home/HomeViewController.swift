//
//  HomeViewController.swift
//  AuctionMania
//
//  Created by usear on 6/12/24.
//

import UIKit

class HomeViewController: UIViewController {
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
        let headerView = HomeTableHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 300))
//        headerView.backgroundColor = .blue
        
        tableView.tableHeaderView = headerView
    }
}
//MARK: extensions

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BigTableViewCell", for: indexPath) as? BigTableViewCell else {return UITableViewCell()}
        switch indexPath.row{
        case 0:
            cell.CarImage.image =  UIImage(named: "images-2")
            cell.CarType.text = "Sport"
        case 1:
            cell.CarImage.image =  UIImage(named: "images-3")
            cell.CarType.text = "Hypercar"
        case 2:
            cell.CarImage.image =  UIImage(named: "images-4")
            cell.CarType.text = "Sedan"
            
        case 3:
            cell.CarImage.image =  UIImage(named: "images")
            cell.CarType.text = "SUV"
        default:
            break
        }
                return cell
    }
}
