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
  
  func saveTask(_ task: Task) {
    storage.saveTask(task) { [weak self] done in
      guard done else { return }
      if let index = self?.tasks.indexOf(task) {
        self?.tasks[index] = task
      }
    }
  }
}

extension Array {
  func indexOf(_ item: Element) -> Int? where Element: Identifiable {
    self.firstIndex(where: { $0.id == item.id })
  }
}
