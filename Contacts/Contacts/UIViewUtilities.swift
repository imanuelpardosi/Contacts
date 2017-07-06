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
    var colorUtilities: ColorUtilities = ColorUtilities()
    
    func circleView(views: UIView...) {
        for view: UIView in views {
            view.frame.size.height = view.frame.size.width
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
    
    func setGradientBackground(topColor: String, bottomColor: String, uiView: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = uiView.bounds
        gradientLayer.frame.size.width = UIScreen.main.bounds.width
        
        let color1 = colorUtilities.colorFromHex(hex: topColor)
        let color2 = colorUtilities.colorFromHex(hex: bottomColor).withAlphaComponent(0.28)
        
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        
        uiView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
