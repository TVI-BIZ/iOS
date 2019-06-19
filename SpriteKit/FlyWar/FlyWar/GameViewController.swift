//
//  GameViewController.swift
//  FlyWar
//
//  Created by Vlad Tagunkov on 18/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            let scene = GameScene(size: self.view.bounds.size)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
           
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
