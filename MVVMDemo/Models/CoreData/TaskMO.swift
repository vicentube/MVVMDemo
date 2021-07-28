// TaskMO.swift
// MVVMDemo
//
// Creado el 22/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import Foundation
import CoreData

extension TaskMO: TaskProtocol {
  
  public var id: UUID { idM ?? UUID() }
  
  var title: String {
    get { titleM ?? "" }
    set { titleM = newValue }
  }
  
  func update(with task: TaskProtocol) {
    guard id == task.id else { return }
    title = task.title
  }
  
  @discardableResult static func fromTask(_ task: TaskProtocol, context: NSManagedObjectContext) -> TaskMO {
    let mo = TaskMO(context: context)
    mo.idM = task.id
    mo.update(with: task)
    return mo
  }
  
  
}
