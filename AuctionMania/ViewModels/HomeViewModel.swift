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
