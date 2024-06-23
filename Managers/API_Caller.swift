//
//  API_Caller.swift
//  AuctionMania
//
//  Created by usear on 6/21/24.
//

import Foundation

class Constants{
    static let API_ninja_key = "ol0JYCEmDBNtbfKza089qA==fXQYfZsUZZZUx5K8"
    
}
enum APIErrors: Error{
    case failedToGetData, invalidResponse
}
class APICaller{
    
    static let shared = APICaller()
    
    func getCarsFromNinja(){
        let url = URL(string: "https://api.api-ninjas.com/v1/cars?model=")!
        var request = URLRequest(url: url)
        request.setValue(Constants.API_ninja_key, forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    func getAllProductsFromFakeStore(completion: @escaping (Result<[Product], Error>) -> Void) {
           guard let url = URL(string: "https://fakestoreapi.com/products") else {
               completion(.failure(APIErrors.invalidResponse))
               return
           }
           
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data, error == nil else {
                   completion(.failure(error ?? APIErrors.failedToGetData))
                   return
               }
               
               guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                   completion(.failure(APIErrors.invalidResponse))
                   return
               }
               
               do {
                   let decoder = JSONDecoder()
                   let productsResponse = try decoder.decode([Product].self, from: data)
                   completion(.success(productsResponse))
               } catch {
                   completion(.failure(APIErrors.failedToGetData))
               }
           }
           
           task.resume()
       }
}
