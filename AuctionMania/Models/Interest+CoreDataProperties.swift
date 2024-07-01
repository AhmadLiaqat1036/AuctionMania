//
//  Interest+CoreDataProperties.swift
//  AuctionMania
//
//  Created by usear on 7/1/24.
//
//

import Foundation
import CoreData


extension Interest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Interest> {
        return NSFetchRequest<Interest>(entityName: "Interest")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var price: Double
    @NSManaged public var desc: String?
    @NSManaged public var category: String?
    @NSManaged public var image: String?
    @NSManaged public var rate: Double
    @NSManaged public var count: Int64

}

extension Interest : Identifiable {

}
