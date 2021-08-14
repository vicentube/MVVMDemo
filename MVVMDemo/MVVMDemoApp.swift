// MVVMDemoApp.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

@main
struct MVVMDemoApp: App {
  
  @StateObject private var model = TaskStore(storage: CoreDataStorage())
  
  var body: some Scene {
    WindowGroup {
      TaskListView()
        .environmentObject(model)
    }
  }

}
