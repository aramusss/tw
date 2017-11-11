//
//  MainCoordinator.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
  
  var nextCoordinator: Coordinator?
  var navigationController: UINavigationController
  
  init(navController: UINavigationController) {
    self.navigationController = navController
  }
  
  func start(animated: Bool = true) {
    let taskListVC = TaskListViewController(mode: .full)
    taskListVC.delegate = self
    navigationController.pushViewController(taskListVC, animated: animated)
  }
  
  func handle(shortcut: ShortcutType) -> Bool {
    switch shortcut {
    case .add:
      popToRoot()
      startAddTaskFlow()
      return true
    }
  }
  
  fileprivate func startAddTaskFlow() {
    let newTaskCoordinator = NewTaskCoordinator(navController: self.navigationController)
    self.nextCoordinator = newTaskCoordinator
    newTaskCoordinator.start()
  }
}

extension MainCoordinator: TaskListViewControllerDelegate {
  func taskListViewControllerDidTapAddTask(_ vc: TaskListViewController) {
    startAddTaskFlow()
  }
  
  func taskListViewController(_ vc: TaskListViewController, didSelectTaskList taskList: TaskList) {
    // TODO: Aram (because this is a test, this won't do anything)
  }
}
