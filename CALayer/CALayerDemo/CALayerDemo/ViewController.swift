//
//  ViewController.swift
//  CALayerDemo
//
//  Created by Vlad Tagunkov on 15/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    var shapeLayer: CAShapeLayer! {
        didSet{
            shapeLayer.lineWidth = 15
            shapeLayer.lineCap = .round
            shapeLayer.fillColor = nil
            shapeLayer.strokeEnd = 1
            let color = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1).cgColor
            shapeLayer.strokeColor = color
        }
    }
    var overshapeLayer: CAShapeLayer! {
        didSet{
            overshapeLayer.lineWidth = 15
            overshapeLayer.lineCap = .round
            overshapeLayer.fillColor = nil
            overshapeLayer.strokeEnd = 0
            let color = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1).cgColor
            overshapeLayer.strokeColor = color
        }
    }
    
    
    var gradientLayer: CAGradientLayer!{
        didSet{
            let startColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1).cgColor
            let endColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
            
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            gradientLayer.colors = [startColor,endColor, #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
            //gradientLayer.locations = [0,0.2,1]
            
        }
    }
    

    @IBOutlet weak var button: UIButton! {
        didSet{
         button.layer.shadowOffset = CGSize(width: 0, height: 6)
         button.layer.shadowOpacity = 0.8
         button.layer.shadowRadius = 15
        }
    }
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.layer.cornerRadius = imageView.frame.size.height / 2
            imageView.layer.masksToBounds = true
            let borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            imageView.layer.borderColor = borderColor.cgColor
            imageView.layer.borderWidth = 10
        }
        
    }
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height:  80 + 21 + imageView.frame.size.height / 2)
        
        configShapeLayer(shapeLayer)
        configShapeLayer(overshapeLayer)
        
    }
    func configShapeLayer(_ shapeLayer: CAShapeLayer){
        shapeLayer.frame = view.bounds
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 1.7))
        path.addLine(to: CGPoint(x: self.view.frame.width / 2 + 100, y: self.view.frame.height / 1.7))
        shapeLayer.path = path.cgPath
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        
        overshapeLayer = CAShapeLayer()
        view.layer.addSublayer(overshapeLayer)
        
    }

    @IBAction func tapped(_ sender: UIButton) {
        // tap button and fill
//        overshapeLayer.strokeEnd += 0.2
//        if overshapeLayer.strokeEnd == 1 {
//            performSegue(withIdentifier: "showSecondScreen", sender: self)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.toValue = 1
            animation.duration = 2
            
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            animation.fillMode = CAMediaTimingFillMode.both
            animation.isRemovedOnCompletion = false
        
            animation.delegate = self
        
            overshapeLayer.add(animation, forKey: nil)
        }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        performSegue(withIdentifier: "showSecondScreen", sender: self)
    }
}
    


