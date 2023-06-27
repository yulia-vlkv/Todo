//
//  ContentView.swift
//  Todo
//
//  Created by Iuliia Volkova on 26.06.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - Properties
    @State private var showingAddTodoView: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Todo.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)],
        animation: .default)
    private var todos: FetchedResults<Todo>
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(todos) { todo in
                    NavigationLink {
                        Text("Item at \(todo.name!)")
                    } label: {
                        Text(todo.name!)
                    }
                }
                .onDelete(perform: deleteItems)
            } //: List
            .navigationBarTitle("Todo", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    } //: Add button
                    .sheet(isPresented: $showingAddTodoView) {
                        AddTodoView().environment(\.managedObjectContext, self.viewContext)
                    }
                }
            }
            Text("Select an item")
        }
    } //: Navigation

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { todos[$0] }.forEach(viewContext.delete)

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

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
