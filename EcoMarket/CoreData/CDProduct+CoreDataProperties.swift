//
//  CDProduct+CoreDataProperties.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 21.12.2023.
//
//

import Foundation
import CoreData

@objc(CDProduct)
public class CDProduct: NSManagedObject {

}


extension CDProduct {

//    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProduct> {
//        return NSFetchRequest<CDProduct>(entityName: "CDProduct")
//    }

    @NSManaged public var price: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var image: String?
    @NSManaged public var category: Int16
    @NSManaged public var descriptions: String?
    @NSManaged public var title: String?
    @NSManaged public var id: Int16

}

extension CDProduct : Identifiable {

}
