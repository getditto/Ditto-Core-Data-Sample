//
//  Item+CoreDataClass.swift
//  DittoCoreDataExample
//
//  Created by Konstantin Bender on 12.11.21.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    public override func awakeFromInsert() {
        self.id = UUID()
    }
}
