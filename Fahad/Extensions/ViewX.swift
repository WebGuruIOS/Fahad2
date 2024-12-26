//
//  ViewX.swift
//  Fahad
//
//  Created by Kondalu on 24/08/21.
//

import UIKit

class ViewX: UIView {
    @IBInspectable var cornerRadius: Double {
         get {
           return Double(self.layer.cornerRadius)
         }set {
           self.layer.cornerRadius = CGFloat(newValue)
         }
    }
    @IBInspectable var borderWidth: Double {
          get {
            return Double(self.layer.borderWidth)
          }
          set {
           self.layer.borderWidth = CGFloat(newValue)
          }
    }
    @IBInspectable var borderColor: UIColor? {
         get {
            return UIColor(cgColor: self.layer.borderColor!)
         }
         set {
            self.layer.borderColor = newValue?.cgColor
         }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
           return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
           self.layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
           return self.layer.shadowOpacity
        }
        set {
           self.layer.shadowOpacity = newValue
       }
    }
    @IBInspectable var shadowRadius: CGFloat {
        get {
           return self.layer.shadowRadius
        }
        set {
           self.layer.shadowRadius = newValue
       }
    }
    @IBInspectable var shadowOffset: CGSize {
        get {
           return self.layer.shadowOffset
        }
        set {
           self.layer.shadowOffset = newValue
       }
    }
}
