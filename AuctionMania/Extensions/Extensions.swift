//
//  StringExtensions.swift
//  AuctionMania
//
//  Created by usear on 6/26/24.
//

import Foundation
import UIKit


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
extension String {
    func extractNumber() -> Int? {
        // Remove non-numeric characters from the string
        let cleanString = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // Convert the cleaned string to an integer
        if let number = Int(cleanString) {
            return number
        } else {
            return nil
        }
    }
}
extension Notification.Name{
    static let on = NSNotification.Name("InterestIsOn")
    static let off = NSNotification.Name("InterestIsOff")
}

extension UIViewController{
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
