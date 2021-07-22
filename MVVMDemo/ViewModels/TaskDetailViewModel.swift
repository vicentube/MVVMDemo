// TaskDetailViewModel.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class TaskDetailViewModel: ObservableObject {
  
  private let dbService: DatabaseServiceProtocol
  
  @Published var showingTaskEdit = false
  @Published var task: Task
  
  init(dbService: DatabaseServiceProtocol, task: Task) {
    self.dbService = dbService
    self.task = task
  }
  
  func refreshData() {
    dbService.fetchTaskById(task.id) { [weak self] result in
      self?.task = Task(result)
    }
  }
  
  func showTaskEdit() { showingTaskEdit = true }
  
  func taskEditVM() -> TaskEditViewModel {
    TaskEditViewModel(dbService: dbService, task: task)
  }
}
