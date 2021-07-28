// TaskEditViewModel.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskEditViewModel: View {
  
  @Environment(\.presentationMode) var presentation
  @EnvironmentObject private var store: TaskStore
  
  let task: Task?
  
  @State private var draft = Task()
  
  var body: some View {
    TaskEditView(task: $draft, title: viewTitle, onCancel: dismiss, onDone: saveTask)
      .onAppear(perform: viewSetup)
  }
  
  var viewTitle: String {
    task == nil ? "New task" : "Edit task"
  }
  
  func viewSetup() {
    guard let task = task else { return }
    draft = task
  }
  
  func dismiss() { presentation.wrappedValue.dismiss() }
  
  func saveTask() {
    if task == nil {
      store.addTask(draft)
    } else {
      store.updateTask(draft)
    }
    dismiss()
  }
}

struct TaskEditViewModel_Previews: PreviewProvider {
  static let store = TaskStore.preview
  
  static var previews: some View {
    NavigationView {
      TaskEditViewModel(task: nil)
    }
    .environmentObject(store)
  }
}
