//
//  View.swift
//  MaskDemo
//
//  Created by Vlad Tagunkov on 15/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

@IBDesignable
class View: UIView {
    private var size = CGSize()
    @IBInspectable var cornerRadiiSize: CGFloat = 0 {
        didSet{
            size = CGSize(width: cornerRadiiSize, height: cornerRadiiSize)
        }
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: size).cgPath
        
        layer.mask = shapeLayer
    }
    override func prepareForInterfaceBuilder() {
        setNeedsLayout()
    }
    
}
