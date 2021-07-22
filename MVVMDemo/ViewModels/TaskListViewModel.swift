// TaskListViewModel.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class TaskListViewModel: ObservableObject {
  
  @Published var tasks: [Task] = []
  @Published var showingNewTask = false
  
  private let dbService: DatabaseServiceProtocol
  
  init(dbService: DatabaseServiceProtocol = CoreDataService()) {
    self.dbService = dbService
  }
  
  func getAllTasks() {
    dbService.fetchAllTasks { [weak self] result in
      self?.tasks = result.map(Task.init)
    }
  }
  
  func showNewTask() { showingNewTask = true }
  
  func taskDetailVM(_ task: Task) -> TaskDetailViewModel {
    TaskDetailViewModel(dbService: dbService, task: task)
  }
  
  func newTaskVM() -> TaskEditViewModel {
    TaskEditViewModel(dbService: dbService)
  }
}
