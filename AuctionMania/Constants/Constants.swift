//
//  Constants.swift
//  AuctionMania
//
//  Created by usear on 6/26/24.
//

import Foundation
import UIKit


class MyTapGesture: UITapGestureRecognizer {
    var detail: ProductDetailViewModel?
}
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
    
    
    
    

    static let menNames = [
        "Hiroshi Tanaka", "Takeshi Suzuki", "Kazuki Yamamoto", "Haruto Sato", "Ryota Ito",
        "Yoshiro Watanabe", "Kenji Inoue", "Takumi Kato", "Daiki Nakamura", "Kaito Kobayashi",
        "Aarav Patel", "Alok Sharma", "Arjun Singh", "Dinesh Kumar", "Gagan Verma",
        "Ishaan Kapoor", "Jayesh Gupta", "Kunal Mehta", "Nikhil Sharma", "Pranav Reddy",
        "Muhammad Khan", "Ahmed Ali", "Ali Hassan", "Yusuf Abdullah", "Omar Mahmoud",
        "Hamza Khan", "Ibrahim Ahmed", "Hassan Farid", "Sami Rahman", "Mustafa Ahmed",
        "Zayn Malik", "Faris Abdullah", "Yasin Ibrahim", "Zakariya Hassan", "Yousef Mahmoud",
        "James Smith", "John Johnson", "William Brown", "Michael Davis", "David Wilson",
        "Richard Miller", "Daniel Moore", "Joseph Taylor", "Thomas Anderson", "Matthew Clark",
        "George Lewis", "Harry Hall", "Jack Walker", "Jacob Green", "Ethan Carter"
    ]

    static let womenNames = [
        "Sakura Tanaka", "Yuki Suzuki", "Hana Yamamoto", "Aiko Sato", "Mei Ito",
        "Ayaka Watanabe", "Emi Inoue", "Hikari Kato", "Natsumi Nakamura", "Yui Kobayashi",
        "Anaya Patel", "Divya Sharma", "Isha Singh", "Kavya Kumar", "Neha Verma",
        "Pooja Kapoor", "Riya Gupta", "Shreya Mehta", "Tanvi Sharma", "Trisha Reddy",
        "Aisha Khan", "Fatima Ali", "Mariam Hassan", "Khadija Abdullah", "Zahra Mahmoud",
        "Layla Khan", "Noor Ahmed", "Sana Farid", "Huda Rahman", "Maryam Ahmed",
        "Zara Malik", "Leila Abdullah", "Amina Ibrahim", "Sarah Hassan", "Nadia Mahmoud",
        "Emma Smith", "Olivia Johnson", "Sophia Brown", "Isabella Davis", "Mia Wilson",
        "Emily Miller", "Ava Moore", "Charlotte Taylor", "Amelia Anderson", "Evelyn Clark",
        "Abigail Lewis", "Harper Hall", "Elizabeth Walker", "Grace Green", "Sophie Carter"
    ]
    
    static let fullNames = ["Hiroshi Tanaka", "Takeshi Suzuki", "Kazuki Yamamoto", "Haruto Sato", "Ryota Ito",
                            "Yoshiro Watanabe", "Kenji Inoue", "Takumi Kato", "Daiki Nakamura", "Kaito Kobayashi",
                            "Aarav Patel", "Alok Sharma", "Arjun Singh", "Dinesh Kumar", "Gagan Verma",
                            "Ishaan Kapoor", "Jayesh Gupta", "Kunal Mehta", "Nikhil Sharma", "Pranav Reddy",
                            "Muhammad Khan", "Ahmed Ali", "Ali Hassan", "Yusuf Abdullah", "Omar Mahmoud",
                            "Hamza Khan", "Ibrahim Ahmed", "Hassan Farid", "Sami Rahman", "Mustafa Ahmed",
                            "Zayn Malik", "Faris Abdullah", "Yasin Ibrahim", "Zakariya Hassan", "Yousef Mahmoud",
                            "James Smith", "John Johnson", "William Brown", "Michael Davis", "David Wilson",
                            "Richard Miller", "Daniel Moore", "Joseph Taylor", "Thomas Anderson", "Matthew Clark",
                            "George Lewis", "Harry Hall", "Jack Walker", "Jacob Green", "Ethan Carter",
                            "Sakura Tanaka", "Yuki Suzuki", "Hana Yamamoto", "Aiko Sato", "Mei Ito",
                            "Ayaka Watanabe", "Emi Inoue", "Hikari Kato", "Natsumi Nakamura", "Yui Kobayashi",
                            "Anaya Patel", "Divya Sharma", "Isha Singh", "Kavya Kumar", "Neha Verma",
                            "Pooja Kapoor", "Riya Gupta", "Shreya Mehta", "Tanvi Sharma", "Trisha Reddy",
                            "Aisha Khan", "Fatima Ali", "Mariam Hassan", "Khadija Abdullah", "Zahra Mahmoud",
                            "Layla Khan", "Noor Ahmed", "Sana Farid", "Huda Rahman", "Maryam Ahmed",
                            "Zara Malik", "Leila Abdullah", "Amina Ibrahim", "Sarah Hassan", "Nadia Mahmoud",
                            "Emma Smith", "Olivia Johnson", "Sophia Brown", "Isabella Davis", "Mia Wilson",
                            "Emily Miller", "Ava Moore", "Charlotte Taylor", "Amelia Anderson", "Evelyn Clark",
                            "Abigail Lewis", "Harper Hall", "Elizabeth Walker", "Grace Green", "Sophie Carter"]
    
    static var randomProfilesMen : String {
        let random = Array(1...99).randomElement() ?? 1
        return "https://randomuser.me/api/portraits/men/\(String(random)).jpg"
    }


    static var randomProfilesWomen : String {
        let random = Array(1...99).randomElement() ?? 1
        return "https://randomuser.me/api/portraits/women/\(String(random)).jpg"
    }
    static let randomDatesAndTimes = [
        "22 May 2013, 11:45pm", "10 June 2015, 09:30am", "5 September 2018, 03:15pm",
        "18 April 2017, 01:00pm", "7 July 2014, 08:20am", "14 March 2016, 06:55pm",
        "3 November 2019, 10:10am", "26 December 2012, 07:30pm", "9 August 2011, 02:45pm",
        "30 October 2010, 04:25am", "12 February 2018, 12:15pm", "21 September 2016, 05:50am",
        "8 May 2014, 11:00pm", "17 January 2022, 01:35pm", "23 July 2015, 10:05am",
        "6 December 2017, 03:40pm", "11 October 2013, 09:15am", "19 June 2020, 07:55pm",
        "4 April 2011, 06:30am", "15 August 2019, 08:50pm", "28 February 2014, 02:20pm"
    ]
    
    struct PriceInfo {
        let originalPrice: String
        let price100Less: String
    }
    
    static let mergedPrices: [PriceInfo] = [
            PriceInfo(originalPrice: "$125.50", price100Less: "$25.50"),
            PriceInfo(originalPrice: "€189.99", price100Less: "€89.99"),
            PriceInfo(originalPrice: "¥12,345", price100Less: "¥12,245"),
            PriceInfo(originalPrice: "£175.25", price100Less: "£75.25"),
            PriceInfo(originalPrice: "₹345,678.50", price100Less: "₹245,578.50"),
            PriceInfo(originalPrice: "$299.99", price100Less: "$199.99"),
            PriceInfo(originalPrice: "€145.75", price100Less: "€45.75"),
            PriceInfo(originalPrice: "¥108,765", price100Less: "¥8,765"),
            PriceInfo(originalPrice: "£150.00", price100Less: "£50.00"),
            PriceInfo(originalPrice: "₹223,450.25", price100Less: "₹123,350.25"),
            PriceInfo(originalPrice: "$149.95", price100Less: "$49.95"),
            PriceInfo(originalPrice: "€229.50", price100Less: "€129.50"),
            PriceInfo(originalPrice: "¥206,789", price100Less: "¥106,789"),
            PriceInfo(originalPrice: "£199.99", price100Less: "£99.99"),
            PriceInfo(originalPrice: "₹157,890.75", price100Less: "₹57,790.75"),
            PriceInfo(originalPrice: "$199.99", price100Less: "$99.99"),
            PriceInfo(originalPrice: "€179.50", price100Less: "€79.50"),
            PriceInfo(originalPrice: "¥309,876", price100Less: "¥209,876"),
            PriceInfo(originalPrice: "£320.25", price100Less: "£220.25"),
            PriceInfo(originalPrice: "₹212,345.50", price100Less: "₹112,345.50")
        ]

    static let moreAsianPlaces = [
        "Tokyo, Japan", "Seoul, South Korea", "Shanghai, China", "Singapore, Singapore",
        "Mumbai, India", "Bangkok, Thailand", "Jakarta, Indonesia", "Beijing, China",
        "Kuala Lumpur, Malaysia", "Manila, Philippines", "Hanoi, Vietnam", "Taipei, Taiwan",
        "Hong Kong, China", "Dhaka, Bangladesh", "Karachi, Pakistan", "Yangon, Myanmar",
        "Colombo, Sri Lanka", "Phnom Penh, Cambodia", "Astana, Kazakhstan", "Tashkent, Uzbekistan"
    ]



    
    static let categories = ["Electronics","Jewelery","Men's Clothing","Women's Clothing"]
    static func description(for rating: Double) -> String {
                switch rating {
                case 0.0..<1.0:
                    return "Very poor - Avoid this product"
                case 1.0..<2.0:
                    return "Poor - Not recommended"
                case 2.0..<3.0:
                    return "Fair - Basic functionality, may have issues"
                case 3.0..<4.0:
                    return "Good - Decent product, meets expectations"
                case 4.0..<4.5:
                    return "Very good - High quality, recommended"
                case 4.5..<5.0:
                    return "Excellent - Top tier, highly recommended"
                case 5.0:
                    return "Outstanding - Best in class, exceptional"
                default:
                    return "No rating"
                }
            }
    static func getColourOnRating(rating: Double)->UIColor{
        switch rating{
        case 0.0...0.9:
            return .systemRed
        case 1.0...1.9:
            return .systemPink.withAlphaComponent(0.8)
        case 2.0...2.9:
           return .systemOrange
        case 3.0...3.9:
            return .systemYellow
        default:
            return .systemGreen
        }
        
    }
    static let pics = ["jewelry", "Clothes.jpg"]
    static let labels = ["Bid On High End Jewelery","Bid On Trending Branded Clothes"]
    static func secondsToHourMinutesSeconds(_ sec:Int)->(Int, Int, Int){
        return (sec/3600, (sec%3600)/60, (sec%3600)%60)
    }
    static func hourMinutesSecondsIntoString(hour: Int, min:Int, sec:Int)->String{
        var label = ""
        label += String(format: "%02d", hour)
        label += ":"
        label += String(format: "%02d", min)
        label += ":"
        label += String(format: "%02d", sec)
        return label
    }
}
