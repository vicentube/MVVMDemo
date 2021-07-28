// TaskDetailView.swift
// MVVMDemo
//
// Creado el 28/7/21 por Vicente Úbeda (@vicentube)
// Copyright © 2021 Vicente Úbeda. Todos los derechos reservados.

import SwiftUI

struct TaskDetailView: View {
  let title: String
  let onEdit: () -> Void
  
  var body: some View {
    VStack {
      Text(title)
        .font(.title)
    }
    .navigationBarTitle(title)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: onEdit) {
          Image(systemName: "pencil")
        }
      }
    }
  }
}

struct TaskDetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TaskDetailView(title: "Preview task", onEdit: {})
    }
  }
}
