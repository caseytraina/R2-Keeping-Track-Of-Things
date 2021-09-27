//
//  ContentView.swift
//  Todo List
//
//  Created by Casey Traina on 9/24/21.
//

import SwiftUI


struct Todo: Hashable {
    var todo: String
    var isComplete: Bool = false
    var day: String
    var textColor = Color.black
    
    init(todo: String, isComplete: Bool, day: String, textColor: Color) {
        self.todo = todo
        self.isComplete = isComplete
        self.day = day
        self.textColor = textColor
    }
    
    mutating func edit(new: String) {
        self.todo = new
    }
    mutating func updateCompletion() {
                
        if self.isComplete == true {
            self.isComplete = false
        } else {
            self.isComplete = true
        }
        
    }
    
}



struct ContentView: View {
    
    @State private var mondayTodos = [Todo(todo: "Add a New Todo Below", isComplete: false, day: "Monday", textColor: Color.black)]
    @State private var newTodo = ""
    @State private var edit = ""
    @State private var showEdit = false
    @State private var todoColor = Color.black
    
    mutating func addItem(todo: String, day: String, color: Color) {
        mondayTodos.append(Todo(todo: todo, isComplete: false, day: day, textColor: color))
    }
    
    
    var body: some View {
        
        VStack {
//            View {
//                Text("Weekly Planner")
//            }
            GroupBox() {
                Text("Weekly Planner")
                    .font(.title)
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                    .padding(.all)
            }
            .frame(width: UIScreen.main.bounds.width)

            HStack {
                Text("Monday:")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                Spacer()

            }
            ScrollView(.horizontal) {
            
            HStack {
            
                ForEach(mondayTodos, id: \.self) { todo in
                    GroupBox(label: Text(todo.todo)
                                .multilineTextAlignment(.center)
                                .lineLimit(6)
                                .padding(.vertical)) {
                        if showEdit {
                            TextField("New Todo", text: $edit, onCommit: {
                                showEdit.toggle()
                                for x in 0..<mondayTodos.count {
                                    if mondayTodos[x]==todo {
                                        mondayTodos[x].todo = edit
                                    }
                                }
                                edit = ""
                            })
                        }
                        Spacer()
                            
                        HStack {
                            Button(action: {
                                
                                print(mondayTodos.index(of: todo))
                                let i = mondayTodos.index(of: todo)
                                mondayTodos.remove(at: Int(i!))
                                
                            }) {
                                Text("Mark Complete")
                            }
                            Spacer()
                            Button(action: {showEdit.toggle()}) {
                                Text("Edit")
                            }
                            .padding(.trailing)

                            }
                    }
                                .frame(minWidth: 250, idealWidth: 250, maxWidth: 350, minHeight: 200, idealHeight: 200, maxHeight: 200, alignment: .center)
                                .foregroundColor(todo.textColor)
                                
                }
                
            }
        
            }
            .padding(.horizontal)
            .frame(height: 200)
        
            Spacer()
            GroupBox(label: Text("")) {
            TextField("New Todo", text: $newTodo)
                .padding(.leading)
            ColorPicker("Color", selection: $todoColor, supportsOpacity: false)
                .padding([.top, .leading, .trailing])
            HStack {
                Picker(selection: .constant(1), label: Text("Choose Day")) {
                    Text("Monday").tag(1)
                    Text("Tuesday").tag(2).hidden()
                    Text("Wednesday").tag(3).hidden()
                    Text("Thursday").tag(4).hidden()
                    Text("Friday").tag(5).hidden()
                    Text("Saturday").tag(6).hidden()
                    Text("Sunday").tag(7).hidden()
                }
                .padding([.leading, .bottom])
                Spacer()

                Button(action: {
                    mondayTodos.append(Todo(todo: newTodo, isComplete: false, day: "Monday", textColor: todoColor))
                    newTodo = ""
                }) {
                    Text("Add")
                }
                .padding(.trailing)
            }
            }
            .cornerRadius(/*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}


