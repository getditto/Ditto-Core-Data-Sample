//
//  Country+CoreDataClass.swift
//  DittoCoreDataExample
//
//  Created by Walker Erekson on 1/20/23.
//
//

import Foundation
import CoreData

@objc(Country)
public class Country: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        // NOTE: we do not want to generate a new UUID if DittoCoreData is
        // inserting an instance, because it already has one.
        guard self.dcdMirror?.isUpdatingCoreData == false else { return }
        self.id = UUID()
    }
}
