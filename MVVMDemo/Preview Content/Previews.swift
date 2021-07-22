// Previews.swift
// MVVMDemo
//
// Creado el 22/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

extension TaskStore {
  static var preview: TaskStore {
    let store = TaskStore(storage: PreviewStorage())
    store.getAllTasks()
    return store
  }
}

extension Task {
  static var preview: Task {
    Task(title: "Preview task")
  }
}
