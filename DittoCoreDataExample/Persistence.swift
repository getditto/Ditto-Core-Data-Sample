//
//  Persistence.swift
//  DittoCoreDataExample
//
//  Created by Konstantin Bender on 12.11.21.
//

import CoreData
import DittoSwift
import DittoCoreData

class PersistenceController: NSObject {
    static let shared = PersistenceController()

//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.date = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()

    let container: NSPersistentContainer
    let ditto: Ditto
    let mirror: DCDMirror

    init(inMemory: Bool = false) {

        // MARK: Set up the CoreData stack:

        container = NSPersistentContainer(name: "DittoCoreDataExample")

        let fileManager = FileManager.default
        let applicationSupportURL = try! fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

        let coreDataDBURL = applicationSupportURL.appendingPathComponent("CoreData").appendingPathExtension("db")
        let dittoDBURL = applicationSupportURL.appendingPathComponent("Ditto").appendingPathExtension("db")

        // MARK: delete all previous data to start fresh:
        try? fileManager.removeItem(at: coreDataDBURL)
        try? fileManager.removeItem(at: dittoDBURL)

        let persistentStoreDescription = container.persistentStoreDescriptions.first!
        persistentStoreDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        persistentStoreDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        persistentStoreDescription.url = inMemory ? URL(fileURLWithPath: "/dev/null") : coreDataDBURL

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump

        // MARK: Set up the Ditto instance:

        let identity = DittoIdentity.offlinePlayground(appID: "2f5619b5-7660-46df-ae10-189b80cf184e")
        ditto = Ditto(identity: identity, persistenceDirectory: dittoDBURL)
        ditto.isHistoryTrackingEnabled = true

        try! ditto.setLicenseToken("o2d1c2VyX2lkcXdhbGtlckBkaXR0by5saXZlZmV4cGlyeXgYMjAyMy0wMi0yMlQyMDoyODo1OS4xODRaaXNpZ25hdHVyZXhYR0hjNzJCY2ozMHR5cEVKL3lRNGd5VFlUZ2xZSGw3cVFwTzdGeVdWUlNsZWNzb0JlRlhKTjlHUW05RnYrYkNWQUNrUmtrUzIrZXBQZllPbGJ0bW5XeVE9PQ==")
        // MARK: Set up the DittoCoreData mirror:

        mirror = DCDMirror(ditto: ditto, managedObjectContext: container.viewContext, bindings: [
            // For each entity, DittoCoreData needs to know which of the
            // properties to use as the ID. It is important for this property
            // to:
            //     - be guaranteed to be globally unique
            //     - be set only once on creation and never changed again
            //     - be preserved on deletion (checkbox in CoreData editor)
            //
            // If you are not sure, just add a propery `id` of type `UUID` to
            // each entity and set it to `UUID()` in the awakeFromInsert()
            // method of the corresponding entity. This is exactly what we did
            // for the Item entity, see Item.swift and the CoreData model.
            DCDBinding(entity: Country.entity(), idAttributeName: "id"),
        ])

        super.init()
        mirror.delegate = self

        // MARK: Start syncing:

        var transportConfig = DittoTransportConfig()
        transportConfig.enableAllPeerToPeer()
        ditto.setTransportConfig(config: transportConfig)
        try! ditto.tryStartSync()
    }
}

// MARK: - DCDMirrorDelegate

extension PersistenceController: DCDMirrorDelegate {
    // Nothing here yet.
}
