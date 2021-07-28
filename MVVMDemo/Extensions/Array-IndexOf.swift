// Array-IndexOf.swift
// MVVMDemo
//
// Creado el 28/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

extension Array {
  func indexOf(_ item: Element) -> Int? where Element: Identifiable {
    self.firstIndex(where: { $0.id == item.id })
  }
}
