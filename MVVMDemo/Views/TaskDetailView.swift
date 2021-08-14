// TaskDetailView.swift
// MVVMDemo
//
// Creado el 28/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

extension TaskDetailView: View {
  
  var body: some View {
    VStack {
      Text(task.title)
        .font(.title)
    }
    .navigationBarTitle(task.title)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: showTaskEdit) {
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
  static let model = TaskStore.preview
  
  static var previews: some View {
    TaskDetailView(task: model.tasks[0])
  }
}
