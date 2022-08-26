# DittoCoreData Example

*Demonstrates usage of DittoCoreData, a library for mirroring CoreData object graphs
into a Ditto DB and vice-versa.*

## Getting Started

- Checkout this repo
- Install dependencies: `pod install`
- Open `DittoCoreDataExample.xcworkspace`
- Build & Run this app on 2 different iOS simulators

Whenever you add an item in one simulator instance, you should see it be synced over
to the other instance (and vice-versa).

Play around with it, try adding more entities with different properties and
relationships between them.

## API Overview

The API is relatively simple, we have a single DCDMirror class (accompanied by some value types) that mirrors the CoreData object graph into a Ditto DB and vice versa. It takes a root managed object context, a Ditto instance, and an array of "bindings" that describe the mapping.
```
// Set up the CoreData stack:
let persistentContainer = /* ... */
let persistentStoreDescription = persistentContainer.persistentStoreDescriptions.first!
persistentStoreDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
persistentStoreDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
persistentContainer.loadPersistentStores(...)

// Set up Ditto:
let ditto = /* ... */
ditto.isHistoryTrackingEnabled = true

// Create the mirror object:
let mirror = DCDMirror(ditto: ditto, managedObjectContext: persistentContainer.viewContext, bindings: [
    DCDBinding(entity: Flight.entity(), idAttributeName: "id"),
    DCDBinding(entity: Passenger.entity(), idAttributeName: "id"),
    // ...
])

// Register ad delegate (optional, only notification style methods for now):
mirror.delegate = self
```

That's it, the DCDMirror will take it from there.

In the provided example project, you can follow along with `Persistence.swift` and how it uses `DCDMirror` to replicate CoreData models.

## Copyright

See LICENSE file in the root of this repo.
