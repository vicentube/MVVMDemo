// TaskListViewModel.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskListViewModel: View {
  
  @EnvironmentObject private var store: TaskStore
  
  @State private var showingNewTask = false
  
  var body: some View {
    TaskListView(tasks: $store.tasks,
                 onMove: moveTasks,
                 onDelete: deleteTasks,
                 onNewTask: newTask,
                 onNavToDetail: navToDetailTask)
      .sheet(isPresented: $showingNewTask, content: showNewTask)
      .onAppear(perform: store.getAllTasks)
  }
  
  private func moveTasks(from offsets: IndexSet, to index: Int) {
    store.moveTasks(from: offsets, to: index)
  }
  
  private func deleteTasks(indices: IndexSet) {
    store.deleteTasks(indices: indices)
  }
  
  private func newTask() { showingNewTask = true }
  
  private func showNewTask() -> some View {
    NavigationView {
      TaskEditViewModel(task: nil)      
    }
  }
  
  private func navToDetailTask(_ task: Binding<Task>) -> some View {
    TaskDetailViewModel(task: task)
  }
}

struct TaskListViewModel_Previews: PreviewProvider {
  static let store = TaskStore.preview
  
  static var previews: some View {
    NavigationView {
      TaskListViewModel()
    }
    .environmentObject(store)
  }
}
