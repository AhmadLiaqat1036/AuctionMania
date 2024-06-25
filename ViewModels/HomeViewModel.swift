//
//  HomeViewModel.swift
//  AuctionMania
//
//  Created by usear on 6/25/24.
//

import Foundation


class HomeViewModel{
    
    var Products = [Product]()
    var APISuccess: Bool = false
    var APISuccessDidChange: ((Bool)->Void)?
    
    func fetchAllProducts(){
        APICaller.shared.getAllProductsFromFakeStore { [weak self] results in
            let success: Bool
            switch results{
            case .success(let products):
                self?.Products = products
                success = true
                
            case .failure(let error):
                success = false
                print(error)
            }
            self?.APISuccessDidChange?(success)
        }
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
