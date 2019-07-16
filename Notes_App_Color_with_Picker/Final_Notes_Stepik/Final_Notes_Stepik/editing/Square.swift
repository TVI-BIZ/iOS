//
//  Square.swift
//  Note_Stepik
//
//  Created by Vlad Tagunkov on 07/07/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

@IBDesignable
class Square: UIView {
    
    @IBInspectable var tickPosition: CGPoint = CGPoint(x: 0, y: 5)
    @IBInspectable var tickSize: CGSize = CGSize(width: 20, height: 20)
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(x: 1, y: 1, width: self.frame.size.height - 2, height: self.frame.size.height - 2 ))
        UIColor.black.setFill()
        path.lineWidth = 1.5
        path.stroke()
        

        let tickPath = getTickPath(in: CGRect(origin: tickPosition, size: tickSize))
        UIColor.black.setFill()
        tickPath.stroke()
        
    }

    private func getTickPath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.lineWidth = 2.0
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - 3.0))
        path.addLine(to: CGPoint(x: rect.minX + 4, y: rect.minY + 10))
        
        return path
    }

}
