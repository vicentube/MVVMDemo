// TaskEditViewModel.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI
import Combine

struct TaskEditView {
  
  let task: Task?
  
  @Environment(\.presentationMode) var presentation
  @EnvironmentObject private var model: TaskStore
  @State var draft = Task()
  
  var title: String {
    task == nil ? "New task" : "Edit task"
  }
  
  func viewSetup() {
    guard let task = task else { return }
    draft = task
  }
  
  func dismiss() { presentation.wrappedValue.dismiss() }
  
  func saveTaskAndClose() {
    if task == nil {
      model.addTask(draft)
    } else {
      model.updateTask(draft)
    }
    dismiss()
  }

}
