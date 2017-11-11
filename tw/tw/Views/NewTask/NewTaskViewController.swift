//
//  NewTaskViewController.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import UIKit

protocol NewTaskListViewControllerDelegate: class {
  func newTaskListViewController(_ vc: NewTaskViewController, didTapSaveTask task: Task)
  func newTaskListViewControllerDidTapSelectList(_ vc: NewTaskViewController)
}

class NewTaskViewController: UIViewController {
  
  @IBOutlet private weak var descriptionField: FormField!
  @IBOutlet private weak var nameField: FormField!
  
  @IBOutlet private weak var listIDTitleLabel: UILabel!
  @IBOutlet private weak var setListButton: UIButton!
  
  weak var delegate: NewTaskListViewControllerDelegate?
  
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
  }
  
  func selectTaskList(_ list: TaskList) {
    setListButton.setTitle(list.name, for: .normal)
  }
  
  @objc private func saveTapped(_ sender: Any) {
    delegate?.newTaskListViewController(self, didTapSaveTask: Task(name: "", id: ""))
  }
  
  @IBAction func selectListButtonTapped(_ sender: Any) {
    delegate?.newTaskListViewControllerDidTapSelectList(self)
  }
}
