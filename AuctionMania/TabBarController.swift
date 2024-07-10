//
//  TabBarController.swift
//  AuctionMania
//
//  Created by usear on 6/20/24.
//

import UIKit

class TabBarController: UITabBarController {
    let kBarHeight = CGFloat(80)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeIndex(notification:)), name: NSNotification.Name("GoToDiscover"), object: nil)
        
    }
    override func viewDidLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        //self.TabBar is IBOutlet of your TabBar
        tabFrame.size.height = kBarHeight
        tabFrame.origin.y = self.view.frame.size.height - kBarHeight
        self.tabBar.frame = tabFrame
    }
    @objc func changeIndex(notification: NSNotification){
        let index = notification.userInfo?["index"] as! Int
        self.selectedIndex = index
        
    }

    
}
