//
//  Coordinator.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import UIKit

protocol Coordinator: class {
  var nextCoordinator: Coordinator? { get set }
  var navigationController: UINavigationController { get }
  
  // Will pop any presented VC, NavController, or view that the coordinator has presented
  func popToRoot()
  
  // Gets the presented view controller (via push or modally)
  var topViewController: UIViewController? { get }
}

extension Coordinator {
  func popToRoot() {
    nextCoordinator?.popToRoot()
    
    navigationController.presentedViewController?.dismiss(animated: false, completion: nil)
    navigationController.popToRootViewController(animated: false)
    
    nextCoordinator = nil
  }
  
  var topViewController: UIViewController? { get {
    func getTop(navController: UINavigationController) -> UIViewController? {
      if let innerNavController = navController.presentedViewController as? UINavigationController {
        return getTop(navController: innerNavController)
      } else if let innerNavController = navController.topViewController as? UINavigationController {
        return getTop(navController: innerNavController)
      } else if let topVC = navController.topViewController {
        return topVC
      } else if let topVC = navController.presentedViewController {
        return topVC
      } else {
        return nil
      }
    }
    
    if let topVC = nextCoordinator?.topViewController {
      return topVC
    } else {
      return getTop(navController: navigationController)
    }
    }
  }
}
