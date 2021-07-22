// TaskListView.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskListView: View {
  
  @ObservedObject var vm: TaskListViewModel
  
  var body: some View {
    NavigationView {
      List {
        ForEach(vm.tasks) { task in
          NavigationLink(destination: TaskDetailView(vm: vm.taskDetailVM(task))) {
            Text(task.title)
          }
        }
      }
      .navigationBarTitle("Tasks")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: vm.showNewTask) {
            Image(systemName: "plus")
          }
        }
      }
      .sheet(isPresented: $vm.showingNewTask, onDismiss: vm.getAllTasks) {
        TaskEditView(vm: vm.newTaskVM())
      }
      .onAppear(perform: vm.getAllTasks)
    }
  }
}

struct TaskListView_Previews: PreviewProvider {
  static let dbPreview = PreviewDatabaseService()
  
  static var previews: some View {
    let vm = TaskListViewModel(dbService: dbPreview)
    TaskListView(vm: vm)
  }
}
