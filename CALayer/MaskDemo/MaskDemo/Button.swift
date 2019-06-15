//
//  Button.swift
//  MaskDemo
//
//  Created by Vlad Tagunkov on 15/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit
@IBDesignable
class Button: UIButton {
    private var cornerRadii = CGSize()
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
        }
    }
    @IBInspectable var color: UIColor = .green
    var path: UIBezierPath?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: cornerRadii)
        color.setFill()
        path?.fill()
    
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let path = path  {
            return path.contains(point)
        }
        return false
    }
    
}
