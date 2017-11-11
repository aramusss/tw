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
  
  func start() {
    let taskListVC = TaskListViewController(mode: .full)
    taskListVC.delegate = self
    navigationController.pushViewController(taskListVC, animated: true)
  }
}

extension MainCoordinator: TaskListViewControllerDelegate {
  func taskListViewControllerDidTapAddTask(_ vc: TaskListViewController) {
    let newTaskCoordinator = NewTaskCoordinator(navController: self.navigationController)
    self.nextCoordinator = newTaskCoordinator
    newTaskCoordinator.start()
  }
  
  func taskListViewController(_ vc: TaskListViewController, didSelectTaskList taskList: TaskList) {
    // TODO: Aram (because this is a test, this won't do anything)
  }
}
