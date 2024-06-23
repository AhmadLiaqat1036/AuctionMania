//
//  TabBarController.swift
//  AuctionMania
//
//  Created by usear on 6/20/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(changeIndex(notification:)), name: NSNotification.Name("GoToDiscover"), object: nil)
    }
    @objc func changeIndex(notification: NSNotification){
        let index = notification.userInfo?["index"] as! Int
        self.selectedIndex = index
    }

    
}
