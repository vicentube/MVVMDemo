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
  
  func moveTasks(from indices: IndexSet, to index: Int) {
    tasks.move(fromOffsets: indices, toOffset: index)
  }
  
  func deleteTasks(indices: IndexSet) {
    let tasksToDelete = indices.map { tasks[$0] }
    let ids = tasksToDelete.map { $0.id }
    storage.deleteTasks(tasksToDelete) { [weak self] done in
      guard done else { return }
      self?.tasks.removeAll {
        ids.contains($0.id)
      }
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
