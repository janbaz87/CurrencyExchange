//
//  UIToolbar+Extentions.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 08/11/2023.
//

import UIKit

extension UITextField {
    func addDoneButtonToKeyboard(target: Any, action: Selector) {
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: action)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.items = [flexibleSpace, doneButton]

        self.inputAccessoryView = toolbar
    }
}
