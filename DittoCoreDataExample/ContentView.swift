//
//  ContentView.swift
//  DittoCoreDataExample
//
//  Created by Konstantin Bender on 12.11.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    class ViewModel: ObservableObject {
        @Published var shouldShowEditText = false
        @Published var selecteditemId: UUID?

        init() {

        }
    }
    
    @ObservedObject var viewModel = ViewModel()
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var countries: FetchedResults<Country>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach (countries, id: \.self) { country in
                        Section(country.wrappedFullName) {
                            ForEach(country.candyArray, id: \.self) { candy in
                                Text(candy.wrappedName)
                                Text(DateFormatter().string(from: candy.date!))
                            }
                        }
                    }
                }
                
                Button("Add") {
                    let candy1 = Candy(context: viewContext)
                    candy1.name = "Mars"
                    candy1.orgin = Country(context: viewContext)
                    candy1.orgin?.shortName = "UK"
                    candy1.orgin?.fullName = "United Kingdom"

                    let candy2 = Candy(context: viewContext)
                    candy2.name = "KitKat"
                    candy2.orgin = Country(context: viewContext)
                    candy2.orgin?.shortName = "UK"
                    candy2.orgin?.fullName = "United Kingdom"

                    let candy3 = Candy(context: viewContext)
                    candy3.name = "Twix"
                    candy3.orgin = Country(context: viewContext)
                    candy3.orgin?.shortName = "UK"
                    candy3.orgin?.fullName = "United Kingdom"

                    let candy4 = Candy(context: viewContext)
                    candy4.name = "Toblerone"
                    candy4.orgin = Country(context: viewContext)
                    candy4.orgin?.shortName = "CH"
                    candy4.orgin?.fullName = "Switzerland"

                    try? viewContext.save()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
    
//    func saveText(item: Item, text: String) {
//        withAnimation {
//
//            if let it = items.filter({ $0.id == item.id }).first {
//                it.status = text
//            }
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

//    private func addItem() {shouldShowEditText
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.date = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
