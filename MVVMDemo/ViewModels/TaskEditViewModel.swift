// TaskEditViewModel.swift
// MVVMDemo
//
// Creado el 21/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class TaskEditViewModel: ObservableObject {
  
  @Published var title: String
  @Published var closeView = false
  
  let task: Task?
  
  private let dbService: DatabaseServiceProtocol
  
  init(dbService: DatabaseServiceProtocol, task: Task? = nil) {
    self.dbService = dbService
    self.task = task
    self.title = task?.title ?? ""
  }
  
  func save() {
    var taskToSave = task ?? Task()
    taskToSave.title = title
    dbService.saveTask(taskToSave) { [weak self] done in
      if done {
        self?.closeView = true
      }
    }
  }
  
  func cancel() {
    self.closeView = true
  }
}
