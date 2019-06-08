//
//  ViewController.swift
//  UIGestureRecognizer
//
//  Created by Vlad Tagunkov on 08/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipesObservers()
        tapObserver()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func swipesObservers(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        

    }
    func tapObserver(){
        let trippleTap = UITapGestureRecognizer(target: self, action: #selector(tripleTapAction))
        trippleTap.numberOfTapsRequired = 3
        self.view.addGestureRecognizer(trippleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
        doubleTap.require(toFail: trippleTap)
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
    }
    
    
    
    @objc func handleSwipes(gesture: UISwipeGestureRecognizer){
        switch gesture.direction {
        case .right:
            label.text = "Right Swipe was Recognized"
        case .left:
            label.text = "Left Swipe was Recognized"
        case .up:
            label.text = "Up Swipe was Recognized"
        case .down:
            label.text = "Down Swipe was Recognized"
        default:
            break
        }
    }
    @objc func tripleTapAction(){
        label.text = "Tripple Tap was recognized"
    }
    @objc func doubleTapAction(){
        label.text = "Double Tap was recognized"
    }
    
}

