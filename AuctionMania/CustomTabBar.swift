//
//  CustomTabBar.swift
//  AuctionMania
//
//  Created by usear on 7/8/24.
//

import UIKit

class CustomTabBar: UITabBar {

    @IBInspectable var height: CGFloat = 0.0

        override func sizeThatFits(_ size: CGSize) -> CGSize {
            var sizeThatFits = super.sizeThatFits(size)
            if height > 0.0 {
                sizeThatFits.height = height
            }
            return sizeThatFits
        }
}
