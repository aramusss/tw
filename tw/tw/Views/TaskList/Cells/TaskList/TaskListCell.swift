//
//  TaskListCell.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import UIKit

class TaskListCell: UICollectionViewCell {
  
  @IBOutlet private weak var containerView: GradientView!
  @IBOutlet private weak var nameLabel: UILabel!
  
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
    nameLabel.font = StyleSheet.Task.font
    nameLabel.textColor = StyleSheet.Task.textColor
    
    containerView.layer.masksToBounds = true
    containerView.layer.cornerRadius = 6
    
    containerView.colors = StyleSheet.Task.gradient
    
    containerView.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOpacity = 0.5
    self.layer.shadowOffset = CGSize(width: -1, height: 1)
    self.layer.shadowRadius = 1
  }

  func update(taskList: TaskList) {
    nameLabel.text = taskList.name
  }
}
