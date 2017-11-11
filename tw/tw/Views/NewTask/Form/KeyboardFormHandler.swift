//
//  KeyboardFormHandler.swift
//  tw
//
//  Created by ARAM MIQUEL MATEU on 29/04/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import UIKit

protocol KeyboardFormHandler {
  func setupKeyboardFormHandler(show: Selector, hide: Selector)
  func keyboardWillShow(_ notification: Notification)
  func keyboardWillHide(_ notification: Notification)
}

extension KeyboardFormHandler where Self: UIViewController {
  func setupKeyboardFormHandler(show: Selector, hide: Selector) {
    NotificationCenter.default.addObserver(self,
                                           selector: show,
                                           name: Notification.Name.UIKeyboardWillShow,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: hide,
                                           name: Notification.Name.UIKeyboardWillHide,
                                           object: nil)
  }
  
  func keyboardWillShow(_ notification: Notification) {
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
      let window = self.view.window?.frame {
      // We're not just minusing the kb height from the view height because
      // the view could already have been resized for the keyboard before
      
      let view = self.view.subviews.filter({ $0 is UITableView }).first ?? self.view!
      var height = window.origin.y + window.height - keyboardSize.height
      if view is UITableView {
        height -= 64
      }
      
      view.frame = CGRect(x: view.frame.origin.x,
                               y: view.frame.origin.y,
                               width: view.frame.width,
                               height: height)
    } else {
      debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
    }
  }
  
  func keyboardWillHide(_ notification: Notification) {
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      
      let view = self.view.subviews.filter({ $0 is UITableView }).first ?? self.view!
      
      let viewHeight = view.frame.height
      view.frame = CGRect(x: view.frame.origin.x,
                               y: view.frame.origin.y,
                               width: view.frame.width,
                               height: viewHeight + keyboardSize.height)
    } else {
      debugPrint("We're about to hide the keyboard and the keyboard size is nil. Now is the rapture.")
    }
  }
}
