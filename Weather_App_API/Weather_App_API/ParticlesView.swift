//
//  ParticlesView.swift
//  Weather_App_API
//
//  Created by Vlad Tagunkov on 14/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit
import SpriteKit

class ParticlesView: SKView {
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = UIColor.clear
        self.presentScene(scene)
        
        self.allowsTransparency = true
        self.backgroundColor = UIColor.clear
        
        if let particles = SKEmitterNode(fileNamed: "ParticleScene.sks") {
                particles.position = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height)
            particles.particlePositionRange = CGVector(dx: self.bounds.size.width, dy: 0.0)
            scene.addChild(particles)
            
        }
       
    }

}
