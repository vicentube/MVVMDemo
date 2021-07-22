// Task.swift
// MVVMDemo
//
// Creado el 22/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

protocol TaskProtocol {
  var id: UUID { get }
  var title: String { get set }
}

struct Task: Identifiable, TaskProtocol {
  var id = UUID()
  var title = ""
  
  init() { }
  
  init(_ task: TaskProtocol) {
    id = task.id
    title = task.title
  }
  
  init(title: String) {
    self.title = title
  }
  
  static var preview: Task {
    Task(title: "Preview task")
  }
}
