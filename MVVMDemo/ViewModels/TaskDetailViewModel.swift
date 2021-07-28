// TaskDetailViewModel.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskDetailViewModel: View {
  
  @Binding var task: Task

  @State private var showingTaskEdit = false
  
  var body: some View {
    TaskDetailView(title: task.title, onEdit: editTask)
      .sheet(isPresented: $showingTaskEdit, content: showEditTask)
  }
  
  private func editTask() { showingTaskEdit = true }
  
  private func showEditTask() -> some View {
    NavigationView {
      TaskEditViewModel(task: task)
    }
  }
}

struct TaskDetailViewModel_Previews: PreviewProvider {
  static let store = TaskStore.preview
  
  static var previews: some View {
    NavigationView {
      TaskDetailViewModel(task: .constant(store.tasks[0]))
    }
    .environmentObject(store)
  }
}
