//
//  ContentView.swift
//  To_do_App
//
//  Created by Rodolfo Menocal on 09/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ToDo.isCompleted) private var toDos: [ToDo]
    
    // States to manage the input alert to show or not
    @State private var isAlertShowing = false
    @State private var toDoTittle = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "receipt")
                        .padding(.leading, 20)
                    Text("ToDo App")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    //Button to add a new task
                    Button {
                        isAlertShowing.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.title)
                    }
                    .padding(.trailing, 20)
                }
                .padding(.vertical, 10)
                
                
                // This conditional will make sure that the view of no task is shown when the task array is empty
                if toDos.isEmpty {
                    ContentUnavailableView("No task yet", systemImage: "checkmark.circle.fill")
                } else {
                    List {
                        // Section of missing task
                        if !toDos.filter({ !$0.isCompleted }).isEmpty {
                            Section(header: Text("To Do")) {
                                ForEach(toDos.filter { !$0.isCompleted }) { toDo in
                                    HStack {
                                        Button {
                                            toDo.isCompleted.toggle()
                                        } label: {
                                            Image(systemName: toDo.isCompleted ? "checkmark.circle.fill" : "circle")
                                        }
                                        
                                        Text(toDo.title)
                                    }
                                }
                                .onDelete { indexSet in
                                    let pendingToDos = toDos.filter { !$0.isCompleted }
                                    for index in indexSet {
                                        let toDo = pendingToDos[index]
                                        modelContext.delete(toDo)
                                    }
                                }
                            }
                        } else {
                            Section {
                                Text("🎉 No pending tasks!")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        // Section of completed task
                        if !toDos.filter({ $0.isCompleted }).isEmpty {
                            Section(header: Text("Completed")) {
                                ForEach(toDos.filter { $0.isCompleted }) { toDo in
                                    HStack {
                                        Button {
                                            toDo.isCompleted.toggle()
                                        } label: {
                                            Image(systemName: toDo.isCompleted ? "checkmark.circle.fill" : "circle")
                                        }
                                        
                                        Text(toDo.title)
                                            .strikethrough()
                                            .foregroundColor(.gray)
                                    }
                                }
                                .onDelete { indexSet in
                                    let completedToDos = toDos.filter { $0.isCompleted }
                                    for index in indexSet {
                                        let toDo = completedToDos[index]
                                        modelContext.delete(toDo)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }

            }
            .alert("Add ToDo", isPresented: $isAlertShowing) {
                TextField("Enter Task", text: $toDoTittle)
                
                Button("Add") {
                    modelContext.insert(ToDo(title: toDoTittle))
                    toDoTittle = ""
                }
            }
        }
    }
    
    // Function to delete the tasks (ya manejado en los onDelete de cada sección)
    func deleteToDos(_ indexSet: IndexSet) {
    }
}

#Preview {
    ContentView()
}
