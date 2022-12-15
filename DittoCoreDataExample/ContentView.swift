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
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    VStack {
//                        Text(item.custom?.mood ?? "No mood")
//                        Text(item.defectId ?? "No id")

                        HStack {
                            Text(item.status ?? "Value")
                            NavigationLink {
                                Text("Item at \(item.date ?? Date(), formatter: itemFormatter)")
                            } label: {
                                Text(item.date ?? Date(), formatter: itemFormatter)
                            }
                        }.onTapGesture {
                            viewModel.selecteditemId = item.id
                            viewModel.shouldShowEditText = true
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.shouldShowEditText, content: {
                if let selected = viewModel.selecteditemId {
                    let item = items.filter({ $0.id == selected }).first
                    if let item = item {
                        EditTextView(text: item.status, { text in
                            saveText(item: item, text: text)
                        })
                    }
                }
            })
            Text("Select an item")
        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
    
    func saveText(item: Item, text: String) {
        withAnimation {
            
            if let it = items.filter({ $0.id == item.id }).first {
                it.status = text
//                it.custom?.mood = "happy"
//                it.defectId = "123abc"
            }

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.date = Date()
//            newItem.custom?.mood = "happy"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
