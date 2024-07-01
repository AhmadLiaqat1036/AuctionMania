//
//  StringExtensions.swift
//  AuctionMania
//
//  Created by usear on 6/26/24.
//

import Foundation


extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

extension String{
    
    var addCommaAfterThree: String{
   
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           
           if let number = formatter.number(from: self.replacingOccurrences(of: ",", with: "")) {
               return formatter.string(from: number) ?? ""
           }
           
           return ""
       
    }
    var removeDecimal: String{
        if let decimalRange = self.range(of: ".") {
            return String(self[..<decimalRange.lowerBound])
        } else {
            return self
        }
    }
    var formatToDollar: String {
        return "$" + self.removeDecimal.addCommaAfterThree
    }
}
extension Notification.Name{
    static let on = NSNotification.Name("InterestIsOn")
    static let off = NSNotification.Name("InterestIsOff")
}
