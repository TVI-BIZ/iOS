//
//  ColorPicker.swift
//  Final_Notes_Stepik
//
//  Created by Vlad Tagunkov on 14/07/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class ColorPicker: UIView{
    
    


    @IBOutlet weak var paletteColor: UIView!
    @IBOutlet weak var hexColorLabel: UILabel!
    @IBOutlet weak var topColor: UIView!
    
    
    
    let nibName = "ColorPicker"
    var contentView: UIView?
    var gradient = GradientView()
    var mainController = ViewController()
    var pickedColor: UIColor?
    static var pickedColorFinal: UIColor?
    
    var brightness: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = loadViewFromNib() else {return}
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    
    func loadViewFromNib() -> UIView?{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let hit = touches.first
        let pointerLocation = (hit?.location(in: self))!
        pickedColor = getPixelColor(atPosition: pointerLocation)
        topColor.backgroundColor = pickedColor
        
        if let pickedColor = pickedColor{
            hexColorLabel.text = pickedColor.toRGBAString(uppercased: true)
        }
        
        
        
    }
    
    func getPixelColor(atPosition:CGPoint) -> UIColor{
        var pixel:[CUnsignedChar] = [0, 0, 0, 0];
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        let bitmapInfo = CGBitmapInfo(rawValue:    CGImageAlphaInfo.premultipliedLast.rawValue);
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue);
        
        context!.translateBy(x: -atPosition.x, y: -atPosition.y);
        layer.render(in: context!);
        let color:UIColor = UIColor(red: CGFloat(pixel[0])/255.0,
                                    green: CGFloat(pixel[1])/255.0,
                                    blue: CGFloat(pixel[2])/255.0,
                                    alpha: CGFloat(pixel[3])/255.0);
        
        return color;
    }
    
    
    
    
    
    

    
    
    
    
    @IBAction func brightnessChanged(_ sender: UISlider) {
            self.viewWithTag(1001)?.alpha = CGFloat(sender.value)
    }
    
    
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        self.isHidden = true
        
        for i in 0...self.superview!.subviews.count - 1 {
            self.superview!.subviews[i].alpha = 1
        }
        
        if self.superview?.viewWithTag(4)?.isHidden == false {
            self.superview?.viewWithTag(4)?.isHidden = true
        }
        self.superview?.viewWithTag(14)?.backgroundColor = pickedColor
        self.superview?.viewWithTag(24)?.alpha = 1
        self.superview?.viewWithTag(24)?.backgroundColor = pickedColor
        
        
        
    }
    
}

extension UIColor {
    
    func toRGBAString(uppercased: Bool = true) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgba = [r, g, b, a].map { $0 * 255 }.reduce("", { $0 + String(format: "%02x", Int($1)) })
        return uppercased ? rgba.uppercased() : rgba
    }
}

