// TaskEditView.swift
// MVVMDemo
//
// Creado el 28/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

extension TaskEditView: View {
  
  var body: some View {
    NavigationView {
      VStack {
        TextField("Enter task title", text: $draft.title)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
        Spacer()
      }
      .navigationBarTitle(title)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: dismiss) {
            Text("Cancel")
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: saveTaskAndClose) {
            Text("Done")
          }
        }
      }
    }
  }
  
}

struct TaskEditView_Previews: PreviewProvider {
  static let model = TaskStore.preview
  
  static var previews: some View {
    TaskEditView(task: model.tasks[0])
      .environmentObject(model)
  }
}
