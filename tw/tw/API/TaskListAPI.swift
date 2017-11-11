//
//  TaskListAPI.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import Foundation

struct TaskListAPI {
  static func getListForProject(projectID: String, completion: @escaping (_ list: [TaskList], _ error: TWError?) -> Void) {
    let request = API.request(path: "/projects/\(projectID)/tasklists", method: .get)
    API.perform(request) { json, error in
      if let error = error {
        completion([], error)
        return
      } else {
        guard let json = json,
          let listJSON = json["tasklists"] as? [JSON] else {
          completion([], nil)
          return
        }
          
        completion(listJSON.flatMap({ TaskList(json: $0) }), nil)
      }
    }
  }
}
