//
//  TaskList.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import Foundation

struct TaskList {
  let name: String
  let id: String
}

extension TaskList {
  private enum Key: String {
    case name = "name",
    id = "id"
  }
  
  init?(json: JSON) {
    guard let name = json[Key.name.rawValue] as? String,
      let id = json[Key.id.rawValue] as? String
      else { return nil }
    
    self.name = name
    self.id = id
  }
}
