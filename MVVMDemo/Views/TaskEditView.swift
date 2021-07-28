// TaskEditView.swift
// MVVMDemo
//
// Creado el 28/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskEditView: View {
  
  @Binding var task: Task
  let title: String
  let onCancel: () -> Void
  let onDone: () -> Void
  
  var body: some View {
    VStack {
      TextField("Enter task title", text: $task.title)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
      Spacer()
    }
    .navigationBarTitle(title)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button(action: onCancel) {
          Text("Cancel")
        }
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: onDone) {
          Text("Done")
        }
      }
    }
  }
  
}

struct TaskEditView_Previews: PreviewProvider {
  static let store = TaskStore.preview
  
  static var previews: some View {
    NavigationView {
      TaskEditView(task: .constant(store.tasks[0]), title: "Edit preview", onCancel: {}, onDone: {})
    }
  }
}
