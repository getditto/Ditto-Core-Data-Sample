//
//  Candy+CoreDataProperties.swift
//  DittoCoreDataExample
//
//  Created by Walker Erekson on 1/25/23.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var orgin: Country?
    
    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
    

}

extension Candy : Identifiable {

}
