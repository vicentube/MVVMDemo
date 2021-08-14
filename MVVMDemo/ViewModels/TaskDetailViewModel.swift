// TaskDetailViewModel.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskDetailView {
  
  let task: Task
  
  @State var showingTaskEdit = false
  
  func showTaskEdit() { showingTaskEdit = true }
  
}
