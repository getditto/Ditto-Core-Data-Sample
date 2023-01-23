//
//  Country+CoreDataProperties.swift
//  DittoCoreDataExample
//
//  Created by Walker Erekson on 1/20/23.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var fullName: String?
    @NSManaged public var shortName: String?
    @NSManaged public var candy: NSSet?
    
    public var wrappedShortName: String {
        shortName ?? "Unknown Country"
    }
    
    public var wrappedFullName: String {
        fullName ?? "Unknown Country"
    }
    
    public var candyArray: [Candy] {
        let set = candy as? Set<Candy> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for candy
extension Country {

    @objc(insertObject:inCandyAtIndex:)
    @NSManaged public func insertIntoCandy(_ value: Candy, at idx: Int)

    @objc(removeObjectFromCandyAtIndex:)
    @NSManaged public func removeFromCandy(at idx: Int)

    @objc(insertCandy:atIndexes:)
    @NSManaged public func insertIntoCandy(_ values: [Candy], at indexes: NSIndexSet)

    @objc(removeCandyAtIndexes:)
    @NSManaged public func removeFromCandy(at indexes: NSIndexSet)

    @objc(replaceObjectInCandyAtIndex:withObject:)
    @NSManaged public func replaceCandy(at idx: Int, with value: Candy)

    @objc(replaceCandyAtIndexes:withCandy:)
    @NSManaged public func replaceCandy(at indexes: NSIndexSet, with values: [Candy])

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: Candy)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: Candy)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)

}

extension Country : Identifiable {

}
