// TaskListView.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskListView: View {
  
  @EnvironmentObject private var store: TaskStore
  
  @State private var showingNewTask = false
  
  var tasks: [Task] { store.tasks }
  
  var body: some View {
    List {
      ForEach(tasks) { task in
        NavigationLink(destination: TaskDetailView(task: task)) {
          Text(task.title)
        }
      }
    }
    .navigationBarTitle("Tasks")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: { showingNewTask = true }) {
          Image(systemName: "plus")
        }
      }
    }
    .sheet(isPresented: $showingNewTask) {
      TaskEditView(task: nil)
    }
    .onAppear(perform: store.getAllTasks)
  }
}

struct TaskListView_Previews: PreviewProvider {
  static let store = TaskStore.preview
  
  static var previews: some View {
    NavigationView {
      TaskListView()
    }
  }
}
