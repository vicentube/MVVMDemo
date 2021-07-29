// TaskListView.swift
// MVVMDemo
//
// Creado el 28/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskListView<NavDestination: View>: View {
  
  @Binding var tasks: [Task]
  let onMove: (IndexSet, Int) -> Void
  let onDelete: (IndexSet) -> Void
  let onNewTask: () -> Void
  let navToDetail: (Binding<Task>) -> NavDestination
  
  var body: some View {
    List {
      ForEach(tasks) { task in
        bindTask(task).map { boundTask in
          NavigationLink(destination: navToDetail(boundTask)) {
            Text(task.title)
          }
        }
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
  
  private func bindTask(_ task: Task) -> Binding<Task>? {
    guard let index = tasks.indexOf(task) else { return nil }
    return .init(get: { tasks[index] },
                 set: { tasks[index] = $0 })
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
