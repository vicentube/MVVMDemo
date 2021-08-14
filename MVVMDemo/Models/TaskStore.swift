// TaskStore.swift
// MVVMDemo
//
// Creado el 22/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class TaskStore: ObservableObject {
  
  private let storage: StorageProtocol
  
  @Published var tasks: [Task] = []
  
  init(storage: StorageProtocol = CoreDataStorage()) {
    self.storage = storage
  }
  
  func getAllTasks() {
    storage.fetchAllTasks { [weak self] result in
      self?.tasks = result.map(Task.init)
    }
  }
  
  func deleteTasks(_ tasksToDelete: [Task]) {
    tasksToDelete.forEach { task in
      guard let index = tasks.indexOf(task) else { return }
      tasks.remove(at: index)
    }
    storage.deleteTasks(tasksToDelete) { done in
      guard done else { return }
    }
  }
  
  func addTask(_ task: Task) {
    storage.saveTask(task) { [weak self] done in
      guard done else { return }
      self?.tasks.append(task)
    }
  }
  
  func updateTask(_ task: Task) {
    storage.saveTask(task) { [weak self] done in
      guard done else { return }
      guard let index = self?.tasks.indexOf(task) else { return }
      self?.tasks[index] = task
    }
  }
}
