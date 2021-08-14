// TaskListViewModel.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import Combine
import SwiftUI

struct TaskListView {
  
  @EnvironmentObject private var model: TaskStore
  @State var showingNewTask = false
  
  var tasks: [Task] { model.tasks }
  
  func showNewTask() { showingNewTask = true }
  
  func loadAllTasks() {
    model.getAllTasks()
  }
  
  func moveTasks(from indices: IndexSet, to index: Int) {
    model.tasks.move(fromOffsets: indices, toOffset: index)
  }
  
  func deleteTasks(indices: IndexSet) {
    let tasksToDelete = indices.map { tasks[$0] }
    model.deleteTasks(tasksToDelete)
  }

}
