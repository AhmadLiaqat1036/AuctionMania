//
//  ProfileViewController.swift
//  AuctionMania
//
//  Created by usear on 6/12/24.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var ProfileTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        ProfileTable.delegate = self
        ProfileTable.dataSource = self
        ProfileTable.tableHeaderView = ProfileTableHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 150))
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProfileTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var configure = cell.defaultContentConfiguration()
        switch indexPath.row{
        case 0 :
            configure.text = "Auctions"
        case 1:
            configure.text = "Shipping Addresses"
        case 2:
            configure.text = "Payment Methods"
        case 3:
            configure.text = "Promocodes"
        case 4:
            configure.text = "My Reviews"
        case 5:
            configure.text = "Settings"
        default:
            configure.text = ""
        }
        configure.secondaryText = nil
        cell.contentConfiguration = configure
        
        return cell
    }
}
