//
//  Candy+CoreDataProperties.swift
//  DittoCoreDataExample
//
//  Created by Walker Erekson on 1/20/23.
//
//

import Foundation
import CoreData


extension Candy {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var orgin: Country?
    
    public var wrappedName: String {
        name ?? "Unkown Candy"
    }

}

extension Candy : Identifiable {

}
