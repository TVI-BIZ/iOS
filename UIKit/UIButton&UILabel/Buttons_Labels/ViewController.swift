//
//  ViewController.swift
//  Buttons_Labels
//
//  Created by Vlad Tagunkov on 09/05/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet var actionButtons: [UIButton]!
    
    @IBAction func pressedButton(_ sender: UIButton) {
//        label.isHidden = false
//        label.text = "Hello world!"
        
//        if label.isHidden {
//            label.isHidden = false
//            label.text = "Hello, world!"
//            button.setTitle("Clear", for: .normal)
//            button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
//            button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//        } else {
//            label.isHidden = true
//            label.text = "Hello, world!"
//            button.setTitle("Get result", for: .normal)
//            button.setTitleColor(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), for: .normal)
//            button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
//
//
//        }
        label.isHidden = false
        button.isHidden = false
        
        if sender.tag == 0 {
            label.text = "Hello World!"
            label.textColor = .yellow
            
        } else if sender.tag == 1{
            label.text = "Hi there!"
            label.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        } else if sender.tag == 2 {
            label.isHidden = true
            button.isHidden = true
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        label.isHidden = true
        label.font = label.font.withSize(35)
        label.textColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        
        for button in actionButtons {
            button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
            button.backgroundColor = .green
        }
        
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
   
        
        button.isHidden = true
        
        
    }


}

