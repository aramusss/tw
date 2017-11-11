//
//  FormField
//  tw
//
//  Created by ARAM MIQUEL MATEU on 16/04/2017.
//  Copyright © 2017 AramApps. All rights reserved.
//

import UIKit

protocol FormFieldDelegate: class {
  func formField(_ field: FormField, didUpdateValue value: String)
}

@IBDesignable class FormField: UIView {
  
  @IBOutlet weak var titleLabel: UILabel! { didSet {
    titleLabel.font = StyleSheet.Label.titleFont
    titleLabel.textColor = StyleSheet.Label.color
    titleLabel.text = ""
    titleLabel.numberOfLines = 2
    }
  }
  
  @IBOutlet weak var textField: UIFormTextField! { didSet {
    textField.font = StyleSheet.TextField.font
    textField.textColor = StyleSheet.TextField.color
    textField.addTarget(self, action: #selector(didUpdateTexfield(_:)), for: UIControlEvents.editingChanged)
    textField.text = ""
    textField.delegate = self
    }
  }
  
  @IBOutlet weak var nextField: FormField? { didSet {
    textField.nextTextField = nextField?.textField
    textField.returnKeyType = .next
    }
  }
  
  @IBInspectable var titleText: String = "" { didSet {
    titleLabel.text = titleText
    }
  }
  
  @IBInspectable var isSecureTextEntry: Bool = false { didSet {
    textField.isSecureTextEntry = true
    }
  }
  
  @IBInspectable var valueText: String = "" { didSet {
    textField.text = valueText
    }
  }
  
  @IBInspectable var placeholderText: String = "" { didSet {
    textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSFontAttributeName: StyleSheet.TextField.font, NSForegroundColorAttributeName: StyleSheet.Label.lightColor])
    }
  }
  
  
  @IBOutlet weak var textFieldBackgroundView: UIView! { didSet {
    textFieldBackgroundView.layer.masksToBounds = true
    textFieldBackgroundView.layer.cornerRadius = 10
    textFieldBackgroundView.layer.borderWidth = 1
    textFieldBackgroundView.layer.borderColor = StyleSheet.TextField.borderColor.cgColor
    }
  }
  
  weak var delegate: FormFieldDelegate?
  var view: UIView!
  
  func xibSetup() {
    view = loadFromNib()
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    //view.setup()
    addSubview(view)
  }
  
  func loadFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    return UINib(nibName: String(describing: FormField.self), bundle: bundle).instantiate(withOwner: self, options: nil).first as! UIView
    
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    xibSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    xibSetup()
  }
  
  func update(title: String, value: String) {
    titleLabel.text = title
    textField.text = value
  }
  
  @objc private func didUpdateTexfield(_ sender: UITextField) {
    delegate?.formField(self, didUpdateValue: sender.text ?? "")
  }
}

extension FormField: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let textField = textField as? UIFormTextField {
      if let nextTextField = textField.nextTextField {
        nextTextField.becomeFirstResponder()
      } else {
        textField.resignFirstResponder()
      }
    }
    
    return true
  }
}
