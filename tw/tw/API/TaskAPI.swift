//
//  TaskAPI.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import Foundation

struct TaskAPI {
  static func createTask(task: Task, inList taskList: TaskList, completion: @escaping (_ success: Bool, _ error: TWError?) -> Void) {
    let request = API.request(path: "/tasklists/\(taskList.id)/tasks", method: .post, body: ["todo-item": task.toJSON()])
    API.perform(request) { json, error in
      if let error = error {
        completion(false, error)
      } else {
        completion(true, nil)
      }
    }
  }
}
