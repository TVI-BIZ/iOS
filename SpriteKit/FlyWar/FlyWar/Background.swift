//
//  Background.swift
//  FlyWar
//
//  Created by Vlad Tagunkov on 18/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import SpriteKit

class Background: SKSpriteNode {
    static func populatesBackgrounds(at point: CGPoint) -> Background {
        let background = Background(imageNamed: "background")
        background.position = point
        background.zPosition = 0
        
        return background
    }
}
