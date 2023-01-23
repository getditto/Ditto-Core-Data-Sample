//
//  Candy+CoreDataClass.swift
//  DittoCoreDataExample
//
//  Created by Walker Erekson on 1/20/23.
//
//

import Foundation
import CoreData

@objc(Candy)
public class Candy: NSManagedObject {
    public override func awakeFromInsert() {
        self.id = UUID()
    }
}
