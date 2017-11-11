//
//  TestNewTaskViewController.swift
//  twTests
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import FBSnapshotTestCase
@testable import tw

class TestNewTaskViewController: FBSnapshotTestCase {
  override func setUp() {
    super.setUp()

    recordMode = false
  }
  
  func testNewTaskViewController() {
    let vc = NewTaskViewController()
    FBSnapshotVerifyView(vc.view)
    FBSnapshotVerifyLayer(vc.view.layer)
  }
}
