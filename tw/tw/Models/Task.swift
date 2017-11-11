//
//  Task.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import Foundation

struct Task {
  let name: String
  let description: String
}

extension Task {
  enum Key: String {
    case name = "content",
    description = "description"
  }
  
  func toJSON() -> JSON {
    return [Key.name.rawValue: self.name,
            Key.description.rawValue: self.description]
  }
}
