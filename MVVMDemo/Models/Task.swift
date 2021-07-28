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
  let id: UUID
  var title = ""
  
  init() {
    self.id = UUID()
  }
  
  init(_ task: TaskProtocol) {
    id = task.id
    title = task.title
  }
  
}
