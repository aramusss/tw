//
//  TaskListCell.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import UIKit

class TaskListCell: UICollectionViewCell {
  
  @IBOutlet private weak var nameLabel: UILabel!
  
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
    nameLabel.font = StyleSheet.Label.titleFont
    nameLabel.textColor = StyleSheet.Label.color
  }

  func update(taskList: TaskList) {
    nameLabel.text = taskList.name
  }
}
