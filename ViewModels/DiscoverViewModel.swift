//
//  DiscoverViewModel.swift
//  AuctionMania
//
//  Created by usear on 6/25/24.
//

import Foundation


class DiscoverViewModel{
    var Products = [Product]()
    
    var APISuccess: Bool = false
    var APISuccessDidChange: ((Bool)->Void)?
    
    func fetchAllProducts(){
        APICaller.shared.getAllProductsFromFakeStore { [weak self] results in
            let success:Bool
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
    func findUpDownTagBackgroundWidth(_ tag: Int)->CGFloat{
        switch tag{
        case 0...9:
            return 45
        case 10...99:
            return 56
        case 100...999:
            return 66
        default:
            return 77
        }
    }
}
