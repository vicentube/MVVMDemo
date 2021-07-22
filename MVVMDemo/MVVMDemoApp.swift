// MVVMDemoApp.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

@main
struct MVVMDemoApp: App {
  @StateObject var vm = TaskListViewModel()
  
  var body: some Scene {
    WindowGroup {
      TaskListView(vm: vm)
    }
  }
}
