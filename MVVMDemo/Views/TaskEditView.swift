// TaskEditView.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskEditView: View {
  
  @Environment(\.presentationMode) var presentation
  @ObservedObject var vm: TaskEditViewModel
  
  var body: some View {
    VStack {
      HStack {
        Button(action: vm.cancel) {
          Text("Cancel")
        }
        Spacer()
        Button(action: vm.save) {
          Text("Done")
        }
      }
      .padding()
      Text(viewTitle)
        .font(.title)
        .padding()
      TextField("Enter title", text: $vm.title)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
      Spacer()
    }
    .onReceive(vm.$closeView, perform: { value in
      if value  {
        presentation.wrappedValue.dismiss()
      }
    })
  }
  
  var viewTitle: String {
    vm.task == nil ? "New task" : "Edit task"
  }
}

struct TaskEditView_Previews: PreviewProvider {
  static let vm = TaskEditViewModel(dbService: PreviewDatabaseService())
  
  static var previews: some View {
    TaskEditView(vm: vm)
  }
}
