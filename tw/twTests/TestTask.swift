//
//  TestTask.swift
//  twTests
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import XCTest
@testable import tw

class TestTask: XCTestCase {
  override func setUp() {
    super.setUp()
    
  }
  
  func testTaskToJSON() {
    let name = "Test_Task"
    let description = "Test_Description"
    let task = Task(name: name, description: description)
    let dict = task.toJSON()
    
    XCTAssertTrue(dict["content"] as? String == task.name)
    XCTAssertTrue(dict["description"] as? String == task.description)
  }
}
