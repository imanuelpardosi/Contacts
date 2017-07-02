//
//  UIViewUtilities.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 7/2/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit

class UIViewUtilities {
    
    func circleView(views: UIView...) {
        for view: UIView in views {
            view.layer.cornerRadius = view.frame.size.width / 2
            view.clipsToBounds = true
        }
    }
    
    func radiusCorner(views: UIView..., radius: CGFloat) {
        for view: UIView in views {
            view.layer.cornerRadius = radius
            view.layer.masksToBounds = true
            view.clipsToBounds = true
        }
    }
    
    func borderView(views: UIView..., borderWidth: CGFloat, color: UIColor) {
        for view: UIView in views {
            view.layer.borderWidth = borderWidth
            view.layer.borderColor = color.cgColor
        }
    }
}
