//
//  UIView+Extensions.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 08/11/2023.
//

import UIKit

extension UIView {
    public var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    public var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    public var borderColor: UIColor? {
        get {
            UIColor(cgColor: layer.borderColor!)
        }
        
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
