//
//  TaskListViewController.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {
  
  enum Mode {
    case full, // Shows the 'add button' and expanded UI
    list // Lists task lists in a shorter way
  }
  
  fileprivate enum Section: Int {
    case loading,
    lists,
    count
  }
  
  @IBOutlet weak var addTaskButton: UIButton!
  @IBOutlet weak var addTasksButtonBottomConstraint: NSLayoutConstraint!
  @IBOutlet private weak var collectionView: UICollectionView!
  fileprivate let mode: Mode
  fileprivate let tasklists: [TaskList]?
  
  init(mode: Mode, lists: [TaskList]? = nil) {
    self.mode = mode
    self.tasklists = lists
    
    super.init(nibName: String(describing: TaskListViewController.self), bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "My Lists"
    
    // CollectionView
    collectionView.register(UINib(nibName: String(describing: TaskListCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TaskListCell.self))
    collectionView.register(UINib(nibName: String(describing: LoadingCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: LoadingCell.self))
    collectionView.delegate = self
    collectionView.dataSource = self
    
    // Button
    addTaskButton.layer.cornerRadius = 30
    addTaskButton.layer.masksToBounds = true
    addTaskButton.layer.borderWidth = 2
    addTaskButton.layer.borderColor = StyleSheet.Button.borderColor.cgColor
    addTaskButton.backgroundColor = StyleSheet.Button.backgroundColor
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    hideButton(animated: false)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    showButton()
  }
  
  private func showButton() {
    UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseInOut, animations: {
      self.addTasksButtonBottomConstraint.constant = 32
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  private func hideButton(animated: Bool) {
    view.layoutIfNeeded()
    
    UIView.animate(withDuration: animated ? 0.3 : 0, delay: 0, options: .curveEaseIn, animations: {
      self.addTasksButtonBottomConstraint.constant = -self.addTaskButton.frame.size.height
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
}

extension TaskListViewController: UICollectionViewDelegate { }
extension TaskListViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Section.count.rawValue
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch Section(rawValue: section)! {
    case .loading:
      return tasklists == nil ? 1 : 0
    case .lists:
      return tasklists?.count ?? 0
    default: return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch Section(rawValue: indexPath.section)! {
    case .loading:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LoadingCell.self), for: indexPath)
      
      return cell
    case .lists:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TaskListCell.self), for: indexPath) as! TaskListCell
      
      return cell
    case .count:
      assert(false, "Count section can't hold any cells! It's used for knowing the amout of sections")
      return UICollectionViewCell()
    }
  }
}


extension TaskListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch Section(rawValue: indexPath.section)! {
    case .loading:
      return CGSize(width: collectionView.frame.size.width, height: 260)
    case .lists:
      return CGSize(width: collectionView.frame.size.width / 2, height: 200)
    default: return .zero
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
