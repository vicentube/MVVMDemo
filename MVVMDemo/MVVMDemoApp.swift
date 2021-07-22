// MVVMDemoApp.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

@main
struct MVVMDemoApp: App {
  
  @StateObject private var store = TaskStore()
  
  var body: some Scene {
    WindowGroup {
      NavigationView {
        TaskListView()
          .environmentObject(store)
      }
    }
  }
}
