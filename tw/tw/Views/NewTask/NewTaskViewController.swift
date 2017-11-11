//
//  NewTaskViewController.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import UIKit

protocol NewTaskListViewControllerDelegate: class {
  func newTaskListViewController(_ vc: NewTaskViewController, didSaveTask task: Task, inList list: TaskList)
  func newTaskListViewControllerDidTapSelectList(_ vc: NewTaskViewController)
}

class NewTaskViewController: UIViewController {
  
  @IBOutlet fileprivate weak var descriptionField: FormField!
  @IBOutlet fileprivate weak var nameField: FormField!
  
  @IBOutlet private weak var listIDTitleLabel: UILabel!
  @IBOutlet private weak var setListButton: UIButton!
  
  private var saveButton: UIBarButtonItem!
  
  weak var delegate: NewTaskListViewControllerDelegate?
  
  fileprivate var taskName: String = ""
  fileprivate var taskDescription: String = ""
  fileprivate var taskList: TaskList?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "New Task"
    view.backgroundColor = StyleSheet.View.backgroundColor
    
    saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped(_:)))
    navigationItem.rightBarButtonItem = saveButton
    
    listIDTitleLabel.text = "Task list"
    listIDTitleLabel.font = StyleSheet.Label.titleFont
    listIDTitleLabel.textColor = StyleSheet.Label.color
    
    setListButton.layer.cornerRadius = 10
    setListButton.layer.masksToBounds = true
    setListButton.layer.borderWidth = 1
    setListButton.layer.borderColor = StyleSheet.TextField.borderColor.cgColor
    setListButton.backgroundColor = .white
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
      nameField.shake()
      return
    }
    
    guard taskDescription != "" else {
      descriptionField.shake()
      return
    }
    
    guard let taskList = taskList else {
      setListButton.shake()
      return
    }
    
    saveButton.isEnabled = false
    
    let task = Task(name: taskName, description: taskDescription)
    
    TaskAPI.createTask(task: task, inList: taskList) { [weak self] success, error in
      guard let strongSelf = self else { return }
      strongSelf.saveButton.isEnabled = true
      if let error = error {
        strongSelf.showError(message: error.localizedDescription)
      } else if success {
        strongSelf.showSuccessAndFinish(task: task, list: taskList)
      } else {
        strongSelf.showError(message: "Unknown error")
      }
    }
  }
  
  @IBAction func selectListButtonTapped(_ sender: Any) {
    delegate?.newTaskListViewControllerDidTapSelectList(self)
  }
  
  private func showError(message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: { _ in
      
    }))
    present(alert, animated: true, completion: nil)
  }
  
  private func showSuccessAndFinish(task: Task, list: TaskList) {
    let alert = UIAlertController(title: "Success", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: { _ in
      self.delegate?.newTaskListViewController(self, didSaveTask: task, inList: list)
    }))
    present(alert, animated: true, completion: nil)
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

fileprivate extension UIView {
  func shake() {
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    animation.duration = 0.6
    animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
    layer.add(animation, forKey: "shake")
  }
}
