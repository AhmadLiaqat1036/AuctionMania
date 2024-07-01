//
//  InterestsViewmodel.swift
//  AuctionMania
//
//  Created by usear on 7/1/24.
//

import Foundation
import UIKit
import CoreData


class InterestsViewModel{
    
    static let shared = InterestsViewModel()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var Products = [Product]()
    var InterestsCore = [Interest]()
    var interestsNames = [String]()
    
    var APISuccessDidChange: ((Bool)->Void)?
    var deleteAllSuccessDidChange: ((Bool)->Void)?

    var puttingCoreDataSuccessDidChange: ((Bool)->Void)?
    var fetchingCoreDataSuccessDidChange: ((Bool)->Void)?
    
    func fetchAllProducts(){
        APICaller.shared.getAllProductsFromFakeStore { [weak self] results in
            let success: Bool
            switch results{
            case .success(let products):
                success = true
                self?.Products = products
            case .failure(let error):
                success = false
                print(error)
            }
            self?.APISuccessDidChange?(success)
        }
    }
    func deleteAllInterests() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Interest.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            print("Successfully deleted all interests")
        } catch {
            deleteAllSuccessDidChange?(false)
            print("Error deleting all interests: \(error.localizedDescription)")
        }
        deleteAllSuccessDidChange?(true)
    }
    func getAllTitlesFromCoreData(){
        do{
            let items = try context.fetch(Interest.fetchRequest())
            InterestsCore = items
        }
        catch{
            print(error.localizedDescription)
            fetchingCoreDataSuccessDidChange?(false)
        }
        fetchingCoreDataSuccessDidChange?(true)
    }
    func putInterestsInCoreData(){
    
        do{
            for name in interestsNames{
                try addInterest(name: name)
            }
        }catch{
            puttingCoreDataSuccessDidChange?(false)
        }
        puttingCoreDataSuccessDidChange?(true)
    }
    
    enum InterestError: Error {
        case productNotFound
        case coreDataSaveError(Error)
    }

    func addInterest(name: String) throws {
        guard let product = Products.first(where: { $0.title == name }) else {
            throw InterestError.productNotFound
        }
        
        let item = Interest(context: context)
        item.name = product.title
        item.category = product.category
        item.count = Int64(product.rating.count ?? 0)
        item.desc = product.description
        item.image = product.image
        item.price = product.price
        item.rate = product.rating.rate ?? 0.0
        item.id = Int64(product.id)
        
        do {
            try context.save()
        } catch {
            throw InterestError.coreDataSaveError(error)
        }
    }

   
    func deleteInterest(name: String){
        if(!InterestsCore.isEmpty){
            guard let item = InterestsCore.first(where: { item in
                item.name == name
            }) else{
                print("Error finding item to delete")
                return}
            context.delete(item)
            do{
                try context.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteCell(at indexPath: IndexPath) {
        // Fetch the managed object to be deleted
        let objectToDelete = InterestsCore[indexPath.row]
        
        // Delete the object from the managed object context
        context.delete(objectToDelete)
        
        // Save changes to Core Data
        do {
            try context.save()
        } catch {
            print("Failed to delete object: \(error)")
        }
    }
    
}
