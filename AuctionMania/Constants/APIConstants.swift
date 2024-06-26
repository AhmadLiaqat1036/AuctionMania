//
//  Constants.swift
//  AuctionMania
//
//  Created by usear on 6/26/24.
//

import Foundation


class Constants{
    static let API_ninja_key = "ol0JYCEmDBNtbfKza089qA==fXQYfZsUZZZUx5K8"
    static let FakeStoreProductsURL = "https://fakestoreapi.com/products"
    static let FakeStoreCategoriesURL = "https://fakestoreapi.com/products/category/"
    static let sellerNames = [
        "John Doe",
        "Jane Smith",
        "Tech Solutions Inc.",
        "Global Mart",
        "Sophie Enterprises",
        "Mark Johnson",
        "Ella Brown",
        "ABC Technologies",
        "Maxwell Group",
        "David Wilson",
        "Lily's Boutique",
        "XYZ Innovations",
        "Emma Lee",
        "Green Thumb Garden Supplies",
        "River City Motors",
        "Oliver White",
        "Elite Fitness Club",
        "Silver Star Jewelry",
        "Rebecca Clark",
        "Sunshine Bakery"
    ]
    struct headers{
        let poster: String
        let name: String
        let bid: String
    }
    static let posters: [headers] = [
    headers(poster: "Hypercars" , name: "Lamborghini Aventador", bid: "120000.99"),
    headers(poster: "Hatchback", name: "VW Golf", bid: "34000.05"),
    headers(poster: "Luxury", name: "Audi A8", bid: "55000.34"),
    headers(poster: "Sedan", name: "Honda Accord 2020", bid: "24000.77"),
    headers(poster: "Sports", name: "Cheverolet Camaro", bid: "88000.99"),
    headers(poster: "Supercars", name: "Aston Martin", bid: "250000.08"),
    headers(poster: "SUV", name: "Range Rover", bid: "75000.88")
    ]
    
    static let timeLeft = [
        "2d 23h",
        "5d 12h",
        "1d 6h",
        "23h 45m",
        "12h 30m",
        "1h 15m",
        "45m 30s",
        "30m 15s",
        "15m 5s",
        "10m 0s",
        "5m 30s",
        "2m 15s",
        "1m 0s",
        "45s",
        "30s",
        "15s"
    ]
    
    static let categories = ["Electronics","Jewelery","Men's Clothing","Women's Clothing"]
}
