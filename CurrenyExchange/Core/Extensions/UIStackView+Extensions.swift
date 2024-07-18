//
//  UIStackView+Extensions.swift
//  CurrenyExchange
//
//  Created by Janbaz Ali on 07/11/2023.
//

import UIKit

extension UIStackView {

    @discardableResult
    public func addArrangedSubviews(_ views: [UIView]) -> Self {
        views.forEach(addArrangedSubview)
        return self
    }

//    @discardableResult
//    public func addArrangedSubviews(_ views: UIView...) -> Self {
//        views.forEach(addArrangedSubview)
//        return self
//    }

    public func addArrangedSubview(_ view: UIView?) {
        guard let view = view else { return }
        addArrangedSubview(view)
    }

}
