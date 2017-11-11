//
//  NewTaskCoordinator.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import UIKit

class NewTaskCoordinator: Coordinator {
  
  var nextCoordinator: Coordinator?
  var navigationController: UINavigationController
  
  init(navController: UINavigationController) {
    self.navigationController = navController
  }
  
  func start() {
    let newTaskVC = NewTaskViewController()
    newTaskVC.delegate = self
    navigationController.pushViewController(newTaskVC, animated: true)
  }
}

extension NewTaskCoordinator: NewTaskListViewControllerDelegate {
  func newTaskListViewControllerDidTapSelectList(_ vc: NewTaskViewController) {
    let listVC = TaskListViewController(mode: .list)
    listVC.delegate = self
    navigationController.pushViewController(listVC, animated: true)
  }
  
  func newTaskListViewController(_ vc: NewTaskViewController, didTapSaveTask task: Task) {
    //TODO: Aram
  }
}

extension NewTaskCoordinator: TaskListViewControllerDelegate {
  func taskListViewControllerDidTapAddTask(_ vc: TaskListViewController) {
    // Not applicable here
  }
  
  func taskListViewController(_ vc: TaskListViewController, didSelectTaskList taskList: TaskList) {
    CATransaction.begin()
    CATransaction.setCompletionBlock {
      if let newTaskVC = self.navigationController.topViewController as? NewTaskViewController {
        newTaskVC.selectTaskList(taskList)
      }
    }
    navigationController.popViewController(animated: true)
    CATransaction.commit()
  }
}
