//
//  UIView+Extensions.swift
//  Github
//
//  Created by NJ Development on 25/05/23.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    static var identifier: String {
        String(describing: self)
    }
    
    func addShadow() {
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
    }
}
