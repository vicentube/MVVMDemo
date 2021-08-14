// TaskListView.swift
// MVVMDemo
//
// Creado el 28/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

extension TaskListView: View {
  
  var body: some View {
    NavigationView {
      List {
        ForEach(tasks) { task in
          NavigationLink(destination: TaskDetailView(task: task)) {
            Text(task.title)
          }
        }
        .onMove(perform: moveTasks)
        .onDelete(perform: deleteTasks)
      }
      .navigationBarTitle("Tasks")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          EditButton()
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: showNewTask) {
            Image(systemName: "plus")
          }
        }
      }
      .sheet(isPresented: $showingNewTask) {
        TaskEditView(task: nil)
      }
      .onAppear(perform: loadAllTasks)
    }
  }
  
}

struct TaskListView_Previews: PreviewProvider {
  static let model = TaskStore.preview
  
  static var previews: some View {
    TaskListView()
      .environmentObject(model)
  }
}
