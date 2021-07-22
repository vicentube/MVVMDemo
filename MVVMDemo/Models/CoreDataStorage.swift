// CoreDataStorage.swift
// MVVMDemo
//
// Creado el 22/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import CoreData

protocol StorageProtocol {
  
  func fetchAllTasks(completion: @escaping ([TaskProtocol]) -> Void)
  func fetchTaskById(_ id: UUID, completion: @escaping (TaskProtocol) -> Void)
  func deleteTasks(_ ids: [UUID], completion: @escaping (Bool) -> Void)
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
  
  func fetchTaskById(_ id: UUID, completion: @escaping (TaskProtocol) -> Void) {
    // background work
    moc.perform {
      do {
        let request: NSFetchRequest = TaskMO.fetchRequest()
        request.predicate = NSPredicate(format: "idM == %@", id as CVarArg)
        let tasks = try self.moc.fetch(request)
        if let mo = tasks.first {
          DispatchQueue.main.async {
            completion(mo)
          }
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func deleteTasks(_ ids: [UUID], completion: @escaping (Bool) -> Void) {
    // background work
    moc.perform {
      do {
        // fetch projects to delete
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
          mo.titleM = task.title
        } else {
          // if it doesn't, then create
          let newMO = TaskMO(context: self.moc)
          newMO.idM = task.id
          newMO.titleM = task.title
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

final class PreviewStorage: StorageProtocol {
  
  func fetchAllTasks(completion: @escaping ([TaskProtocol]) -> Void) {
    let tasks = [
      Task(title: "Task 1"),
      Task(title: "Task 2"),
      Task(title: "Task 3"),
      Task(title: "Task 4"),
      Task(title: "Task 5"),
      Task(title: "Task 6"),
    ]
    completion(tasks)
  }
  
  func fetchTaskById(_ id: UUID, completion: @escaping (TaskProtocol) -> Void) {
    
  }
  
  func deleteTasks(_ ids: [UUID], completion: @escaping (Bool) -> Void) {
    
  }
  
  func saveTask(_ task: TaskProtocol, completion: @escaping (Bool) -> Void) {
    
  }
}
