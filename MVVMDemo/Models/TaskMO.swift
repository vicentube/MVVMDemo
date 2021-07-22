// TaskMO.swift
// MVVMDemo
//
// Creado el 22/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation

extension TaskMO: TaskProtocol {
  public var id: UUID { idM ?? UUID() }
  var title: String {
    get { titleM ?? "" }
    set { titleM = newValue }
  }
}
