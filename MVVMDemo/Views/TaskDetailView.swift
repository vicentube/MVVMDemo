// TaskDetailView.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskDetailView: View {
  
  @ObservedObject var vm: TaskDetailViewModel
  
  var body: some View {
    VStack {
      Text(vm.task.title)
        .font(.title)
      Text("Id: \(vm.task.id)")
        .font(.footnote)
    }
    .navigationBarTitle(vm.task.title)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: vm.showTaskEdit) {
          Image(systemName: "pencil")
        }
      }
    }
    .sheet(isPresented: $vm.showingTaskEdit, onDismiss: vm.refreshData) {
      TaskEditView(vm: vm.taskEditVM())
    }
  }
}

struct TaskDetailView_Previews: PreviewProvider {
  static let vm = TaskDetailViewModel(dbService: PreviewDatabaseService(), task: Task.preview)
  
  static var previews: some View {
    TaskDetailView(vm: vm)
  }
}
