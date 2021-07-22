// TaskEditView.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskEditView: View {
  
  let task: Task?
  
  @Environment(\.presentationMode) var presentation
  @EnvironmentObject private var store: TaskStore
  
  @State private var draft = Task()
  
  var viewTitle: String {
    task == nil ? "New task" : "Edit task"
  }
  
  var body: some View {
    VStack {
      HStack {
        Button(action: cancel) {
          Text("Cancel")
        }
        Spacer()
        Button(action: done) {
          Text("Done")
        }
      }
      .padding()
      Text(viewTitle)
        .font(.title)
        .padding()
      TextField("Enter title", text: $draft.title)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
      Spacer()
    }
    .onAppear(perform: viewSetup)
  }
  
  func viewSetup() {
    guard let task = task else { return }
    draft = task
  }
  
  func cancel() { presentation.wrappedValue.dismiss() }
  
  func done() {
    store.saveTask(draft)
    presentation.wrappedValue.dismiss()
  }
}

struct TaskEditView_Previews: PreviewProvider {
  static let store = TaskStore.preview
  
  static var previews: some View {
    TaskEditView(task: Task.preview)
      .environmentObject(store)
  }
}
