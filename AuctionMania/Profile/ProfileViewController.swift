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
        ProfileTable.tableHeaderView = ProfileTableHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 170))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
