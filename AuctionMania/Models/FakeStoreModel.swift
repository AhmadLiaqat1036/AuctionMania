//
//  CarNinjaModel.swift
//  AuctionMania
//
//  Created by usear on 6/21/24.
//

import Foundation

/*{"id":10,"title":"SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s","price":109,"description":"Easy upgrade for faster boot up, shutdown, application load and response (As compared to 5400 RPM SATA 2.5” hard drive; Based on published specifications and internal benchmarking tests using PCMark vantage scores) Boosts burst write performance, making it ideal for typical PC workloads The perfect balance of performance and reliability Read/write speeds of up to 535MB/s/450MB/s (Based on internal testing; Performance may vary depending upon drive capacity, host device, OS and application.)","category":"electronics","image":"https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg","rating":{"rate":2.9,"count":470}},
*/

struct ProductResponse: Codable{
    let results: [Product]
}

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String?
    let category: String?
    let image: String?
    let rating: Rating
}

struct Rating: Codable {
    let rate: Double?
    let count: Int?
}


struct Category: Codable{
    let name: String?
}
