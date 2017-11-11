//
//  GradientView.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import UIKit

import UIKit


class GradientView: UIView {
  
  // Default Colors
  var colors: [UIColor] = [UIColor.red, UIColor.blue]
  
  override func draw(_ rect: CGRect) {
    
    // Must be set when the rect is drawn
    setGradient(color1: colors[0], color2: colors[1])
  }
  
  func setGradient(color1: UIColor, color2: UIColor) {
    
    let context = UIGraphicsGetCurrentContext()
    let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [color1.cgColor, color2.cgColor] as CFArray, locations: [0, 1])
    
    // Draw Path
    let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    context!.saveGState()
    path.addClip()
    context!.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: frame.width, y: frame.height), options: CGGradientDrawingOptions())
    context!.restoreGState()
  }
  
  override func layoutSubviews() {
    
    // Ensure view has a transparent background color (not required)
    backgroundColor = UIColor.clear
  }
  
  
  func toImage() -> UIImage? {
    var image: UIImage? = nil
    UIGraphicsBeginImageContext(bounds.size)
    if let context = UIGraphicsGetCurrentContext() {
      layer.render(in: context)
      image = UIGraphicsGetImageFromCurrentImageContext()
    }
    UIGraphicsEndImageContext()
    return image
  }
}

