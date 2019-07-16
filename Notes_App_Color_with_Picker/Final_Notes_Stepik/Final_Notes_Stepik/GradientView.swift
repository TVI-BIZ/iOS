//
//  GradientView.swift
//  Final_Notes_Stepik
//
//  Created by Vlad Tagunkov on 14/07/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class GradientView: UIView {
    var poiterPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var pointerColor: UIColor?
    //var colorPicker = ColorPicker(coder: )
    
    var brightness: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        let size = self.bounds.size
        //let elementSize = 1.0
        let height = size.height
        let width = size.width
        let context = UIGraphicsGetCurrentContext()!
        
        for y : CGFloat in stride(from: 0.0, to: height, by: 1) {
            
            for x : CGFloat in stride(from: 0.0, to: width, by: 1.0) {
                // Создаём палитру HSV
                let color = UIColor(
                    hue: x/width,
                    saturation: 1 - (y/height),
                    brightness: 1.0,
                    alpha: 1.0
                )
                // Ставим цвет заполнитель
                context.setFillColor(color.cgColor)
                // Закрашиваем прямоугольник
                context.fill(CGRect(x: x, y: y, width: 1.0, height: 1.0))
            }
        }
    }
    
    
    
    
    
    
    
}
