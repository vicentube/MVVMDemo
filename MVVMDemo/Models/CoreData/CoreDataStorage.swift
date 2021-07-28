// CoreDataStorage.swift
// MVVMDemo
//
// Creado el 22/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import CoreData

protocol StorageProtocol {
  
  func fetchAllTasks(completion: @escaping ([TaskProtocol]) -> Void)
  func deleteTasks(_ tasks: [TaskProtocol], completion: @escaping (Bool) -> Void)
  func saveTask(_ task: TaskProtocol, completion: @escaping (Bool) -> Void)
}

final class CoreDataStorage: StorageProtocol {
  
  private static let container = { () -> NSPersistentContainer in
    let container = NSPersistentContainer(name: "MVVMDemo")
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  // use a background thread for database access
  private let moc = container.newBackgroundContext()
  
  
  // MARK: - DatabaseServiceProtocol
  
  func fetchAllTasks(completion: @escaping ([TaskProtocol]) -> Void) {
    // background work
    moc.perform {
      do {
        // fetch all tasks
        let request: NSFetchRequest = TaskMO.fetchRequest()
        let sort = NSSortDescriptor(key: "titleM", ascending: true)
        request.sortDescriptors = [sort]
        let tasks = try self.moc.fetch(request)
        DispatchQueue.main.async {
          completion(tasks)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func deleteTasks(_ tasks: [TaskProtocol], completion: @escaping (Bool) -> Void) {
    // background work
    moc.perform {
      do {
        // fetch projects to delete
        let ids = tasks.map { $0.id }
        let tasks = try self.fetchTasksMO(ids)
        // mark them to be deleted
        let _ = tasks.map(self.moc.delete)
        // delete them
        try self.save()
        DispatchQueue.main.async {
          completion(true)
        }
      } catch {
        print(error.localizedDescription)
        DispatchQueue.main.async {
          completion(false)
        }
      }
    }
  }
  
  func saveTask(_ task: TaskProtocol, completion: @escaping (Bool) -> Void) {
    // background work
    moc.perform {
      do {
        // fetch project
        let tasks = try self.fetchTasksMO([task.id])
        if let mo = tasks.first {
          // if exists, then update
          mo.update(with: task)
        } else {
          // if it doesn't, then create
          TaskMO.fromTask(task, context: self.moc)
        }
        try self.save()
        DispatchQueue.main.async {
          completion(true)
        }
      } catch {
        print(error.localizedDescription)
        DispatchQueue.main.async {
          completion(false)
        }
      }
    }
  }
  
  // MARK: - Helper methods
  
  private func fetchTasksMO(_ ids: [UUID]) throws -> [TaskMO] {
    let request: NSFetchRequest = TaskMO.fetchRequest()
    request.predicate = NSPredicate(format: "idM IN %@", ids)
    let result = try moc.fetch(request)
    return result
  }
  
  private func save() throws {
    if moc.hasChanges {
      try moc.save()
    }
  }
}
