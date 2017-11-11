//
//  StyleSheet.swift
//  tw
//
//  Created by Aram Mateu on 11/11/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import UIKit

struct StyleSheet {
  struct Label {
    static var titleFont: UIFont { return UIFont(name: Font.bold, size: 18)! }
    static var color: UIColor { return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) }
    static var lightColor: UIColor { return #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) }
  }
  
  struct View {
    
  }
  
  struct Button {
    static var backgroundColor: UIColor { return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) }
    static var borderColor: UIColor { return #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) }
  }
  
  
  struct TextField {
    static var font: UIFont { return UIFont(name: Font.regular, size: 16)! }
    static var color: UIColor { return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) }
    static var borderColor: UIColor { return #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) }
  }
  
  private struct Font {
    static var regular: String { return "HelveticaNeue" }
    static var bold: String { return "HelveticaNeue-Bold" }
  }
}
