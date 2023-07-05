//
//  AddTodoView.swift
//  Todo
//
//  Created by Iuliia Volkova on 26.06.2023.
//

import SwiftUI
import CoreData

struct AddTodoView: View {
    // MARK: - Properties
    
    @Environment(\.managedObjectContext) var viewContext  
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High", "Normal", "Low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    // MARK: - Theme
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings.shared
    
    // MARK: - Body

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    // MARK: - Todo name
                    TextField("Todo", text:  $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24, weight: .bold, design: .default))
                    
                    // MARK: - Todo priority
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    // MARK: - Save button
                    Button(action: {
                        if self.name != "" {
                            let todo = Todo(context: viewContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            do {
                                try self.viewContext.save()
//                                print("NEW TODO: \(String(describing: todo.name))")
                            } catch {
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalid name"
                            self.errorMessage = "Make sure to enter something for\nthe new todo item."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(themes[self.theme.themeSettings].themeColor)
                            .cornerRadius(9)
                            .foregroundColor(Color.white)
                    }) //: Save button 
                } //: VStack
                .padding(.horizontal)
                .padding(.vertical, 30)
                
                Spacer()
            } //: Vstack
            .navigationBarTitle("New Todo", displayMode: .inline )
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            }))
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage ), dismissButton: .default(Text("OK")))
            }
        } //: Navigation
        .accentColor(themes[self.theme.themeSettings].themeColor)
    }
}

// MARK: - Preview
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
            .previewDevice("iPhone 11 Pro")
    }
}
