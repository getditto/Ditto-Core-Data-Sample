//
//  Custom.swift
//  DittoCoreDataExample
//
//  Created by Walker Erekson on 12/6/22.
//

import Foundation
import CoreData

public class Mood: NSObject, NSCoding {
    var value: Int
    
    init(value: Int) {
        self.value = value
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.value = aDecoder.decodeInteger(forKey:"value")
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(value, forKey: "value")
    }
}


