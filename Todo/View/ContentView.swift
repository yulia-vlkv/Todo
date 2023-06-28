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
                ForEach(self.todos, id: \.self) { todo in
                    HStack {
                        Text(todo.name ?? "Unknown")
                        Spacer()
                        Text(todo.priority ?? "Unknown")
                    }
                } //: For each
                .onDelete(perform: deleteTodo)
            } //: List
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    self.showingAddTodoView.toggle()
                }) {
                    Image(systemName: "plus")
                } //: Add button
                    .sheet(isPresented: $showingAddTodoView) {
                        AddTodoView().environment(\.managedObjectContext, self.viewContext)
                    }
            )
        } //: Navigation
    }
    // MARK: - Functions
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            viewContext.delete(todo)
        }
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .previewDevice("iPhone 11 Pro")
    }
}
