// TaskDetailView.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskDetailView: View {
  
  let task: Task
  
  @State private var showingTaskEdit = false
  
  var body: some View {
    VStack {
      Text(task.title)
        .font(.title)
      Text("Id: \(task.id)")
        .font(.footnote)
    }
    .navigationBarTitle(task.title)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: { showingTaskEdit = true }) {
          Image(systemName: "pencil")
        }
      }
    }
    .sheet(isPresented: $showingTaskEdit) {
      TaskEditView(task: task)
    }
  }
}

struct TaskDetailView_Previews: PreviewProvider {
  static let store = TaskStore.preview
  
  static var previews: some View {
    TaskDetailView(task: store.tasks[0])
  }
}
