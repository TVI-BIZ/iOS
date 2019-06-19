//
//  PlayerPlain.swift
//  FlyWar
//
//  Created by Vlad Tagunkov on 19/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import SpriteKit

class PlayerPlain: SKSpriteNode {
    static func populate(at point: CGPoint) -> SKSpriteNode {
        let playerPlainTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        let playerPlane = SKSpriteNode(texture: playerPlainTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 20
        
        return playerPlane
    }
    

}
