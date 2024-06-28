//
//  DiscoverViewModel.swift
//  AuctionMania
//
//  Created by usear on 6/25/24.
//

import Foundation
import JGProgressHUD

class DiscoverViewModel{
    
    static var shared = DiscoverViewModel()
    
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.hudView.layer.borderWidth = 1
        hud.hudView.layer.borderColor = UIColor.systemYellow.cgColor
        hud.textLabel.text = "Loading"
        hud.textLabel.textColor = .label
        return hud
    }()
    
    var callHUD: ((UIView)->Void)?
    
    var Products = [Product]()
    var categories = [Product]()
    var results = [Product]()
    var categoriesSelected: Bool = false
    
    var selectedIndexPaths: [IndexPath] = []
    var selectedCategories: [String] = []
    
    var APISuccessDidChange: ((Bool)->Void)?
    var categorySuccessDidChange: ((Bool)->Void)?
    var categorySelectedDidChange: ((Bool)->Void)?
    var resultsDidChange: ((Bool)->Void)?
    
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
    func fetchAllProductsFromCategory(category: String){
        APICaller.shared.getAllProductsFromCategoriesFakeStore(category: category) { [weak self] results in
            let success:Bool
            switch results{
            case .success(let products):
                self?.categories += products
                success = true
            case .failure(let error):
                success = false
                print(error)
            }
            
            self?.categorySuccessDidChange?(success)
        }
//        print(categories)
    }
    func getResultsProduct(from search: String){
        results = Products
        if(!search.isEmpty){
            results = results.filter { product in
                return product.title.lowercased() == search.lowercased() || product.title.lowercased().range(of: search.lowercased()) != nil
            }
        }
        print("\(search) = \(results)")
        resultsDidChange?(true)
    }
    
    func deleteProducts(inCategory category: String) {
        let cat = category.lowercased()
        categories = categories.filter { $0.category != cat }
        if categories.isEmpty{
            categorySuccessDidChange?(false)
            fetchAllProducts()
        }else{
            categorySuccessDidChange?(true)
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
