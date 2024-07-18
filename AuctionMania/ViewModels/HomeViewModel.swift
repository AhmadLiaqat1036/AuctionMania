//
//  HomeViewModel.swift
//  AuctionMania
//
//  Created by usear on 6/25/24.
//

import Foundation
import UIKit


class HomeViewModel{
    
    var Products = [Product]()
    var counters = [Int]()
    var counterLabels = [String]()
    var APISuccess: Bool = false
    var APISuccessDidChange: ((Bool)->Void)?
    
    var timer = Timer()
    var count = 500
    
    var headerCounter = 4
    var headerTimer = Timer()
    
    var gestureL = UISwipeGestureRecognizer()
    var gestureR = UISwipeGestureRecognizer()
    
    func fetchAllProducts(){
        APICaller.shared.getAllProductsFromFakeStore { [weak self] results in
            let success: Bool
            switch results{
            case .success(let products):
                self?.Products = products
                success = true
                for i in 0..<products.count{
                    self?.counters.append(Range(1000...172800).randomElement()!)
                    let time = Constants.secondsToHourMinutesSeconds(self!.counters[i])
                    let label = Constants.hourMinutesSecondsIntoString(hour: time.0, min: time.1, sec: time.2)
                    self?.counterLabels.append(label)
                }
                
            case .failure(let error):
                success = false
                print(error)
            }
            self?.APISuccessDidChange?(success)
        }
    }
}
