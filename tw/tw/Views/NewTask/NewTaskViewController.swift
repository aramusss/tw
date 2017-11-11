//
//  NewTaskViewController.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import UIKit

protocol NewTaskListViewControllerDelegate: class {
  func newTaskListViewController(_ vc: NewTaskViewController, didTapSaveTask task: Task, inList list: TaskList)
  func newTaskListViewControllerDidTapSelectList(_ vc: NewTaskViewController)
}

class NewTaskViewController: UIViewController {
  
  @IBOutlet fileprivate weak var descriptionField: FormField!
  @IBOutlet fileprivate weak var nameField: FormField!
  
  @IBOutlet private weak var listIDTitleLabel: UILabel!
  @IBOutlet private weak var setListButton: UIButton!
  
  weak var delegate: NewTaskListViewControllerDelegate?
  
  fileprivate var taskName: String = ""
  fileprivate var taskDescription: String = ""
  fileprivate var taskList: TaskList?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "New Task"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped(_:)))
    
    listIDTitleLabel.text = "Task list"
    listIDTitleLabel.font = StyleSheet.Label.titleFont
    listIDTitleLabel.textColor = StyleSheet.Label.color
    
    setListButton.layer.cornerRadius = 10
    setListButton.layer.masksToBounds = true
    setListButton.layer.borderWidth = 1
    setListButton.layer.borderColor = StyleSheet.Button.borderColor.cgColor
    setListButton.backgroundColor = .clear
    setListButton.setTitle("Select List", for: .normal)
    
    descriptionField.delegate = self
    nameField.delegate = self
  }
  
  func selectTaskList(_ list: TaskList) {
    taskList = list
    setListButton.setTitle(list.name, for: .normal)
  }
  
  @objc private func saveTapped(_ sender: Any) {
    
    guard taskName != "" else {
      //TODO: Aram
      return
    }
    
    guard taskDescription != "" else {
      //TODO: Aram
      return
    }
    
    guard let taskList = taskList else {
      //TODO: Aram
      return
    }
    
    delegate?.newTaskListViewController(self, didTapSaveTask: Task(name: taskName, description: taskDescription), inList: taskList)
  }
  
  @IBAction func selectListButtonTapped(_ sender: Any) {
    delegate?.newTaskListViewControllerDidTapSelectList(self)
  }
}

extension NewTaskViewController: FormFieldDelegate {
  func formField(_ field: FormField, didUpdateValue value: String) {
    switch field {
    case nameField:
      taskName = value
    case descriptionField:
      taskDescription = value
    default: break
    }
  }
}
