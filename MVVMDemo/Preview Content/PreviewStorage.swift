// PreviewStorage.swift
// MVVMDemo
//
// Creado el 28/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

final class PreviewStorage: StorageProtocol {
  private var tasks = [
    Task.fromTitle(title: "Task 1"),
    Task.fromTitle(title: "Task 2"),
    Task.fromTitle(title: "Task 3"),
    Task.fromTitle(title: "Task 4"),
    Task.fromTitle(title: "Task 5"),
    Task.fromTitle(title: "Task 6"),
  ]
  
  func fetchAllTasks(completion: @escaping ([TaskProtocol]) -> Void) {
    completion(tasks)
  }
  
  func deleteTasks(_ tasks: [TaskProtocol], completion: @escaping (Bool) -> Void) {
    let ids = tasks.map { $0.id }
    self.tasks.removeAll {
      ids.contains($0.id)
    }
  }
  
  func saveTask(_ task: TaskProtocol, completion: @escaping (Bool) -> Void) {
    let savingTask = Task(task)
    if let index = tasks.indexOf(savingTask) {
      tasks[index] = savingTask
    } else {
      tasks.append(savingTask)
    }
  }
}

extension Task {
  static func fromTitle(title: String) -> Task {
    var task = Task()
    task.title = title
    return task
  }
}
