// TaskListView.swift
// MVVMDemo
//
// Creado el 28/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskListView<Detail: View>: View {
  
  @Binding var tasks: [Task]
  let onMove: (IndexSet, Int) -> Void
  let onDelete: (IndexSet) -> Void
  let onNewTask: () -> Void
  let navToDetail: (Task) -> Detail
  
  var body: some View {
    List {
      ForEach(tasks) { task in
        navToDetail(task)
      }
      .onMove(perform: onMove)
      .onDelete(perform: onDelete)
    }
    .navigationBarTitle("Tasks")
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        EditButton()
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: onNewTask) {
          Image(systemName: "plus")
        }
      }
    }
  }
  
}

struct TaskListView_Previews: PreviewProvider {
  static let store = TaskStore.preview
  
  static var previews: some View {
    NavigationView {
      TaskListView(tasks: .constant(store.tasks),
                   onMove: { _, _ in },
                   onDelete: { _ in },
                   onNewTask: {},
                   navToDetail: { _ in EmptyView() })
    }
  }
}
