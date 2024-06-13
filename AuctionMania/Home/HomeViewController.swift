//
//  HomeViewController.swift
//  AuctionMania
//
//  Created by usear on 6/12/24.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "BigTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BigTableViewCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
    }
}

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
