//
//  Cloud.swift
//  FlyWar
//
//  Created by Vlad Tagunkov on 18/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import SpriteKit
import GameplayKit



final class Cloud: SKSpriteNode, GameBackgroundSpritable {
    static func popluate() -> Cloud {
        let cloudImageName = configureName()
        let cloud = Cloud(imageNamed: cloudImageName)
        cloud.setScale(randomScaleFactor)
        cloud.position = randomPoint()
        cloud.zPosition = 10
        cloud.run(move(from: cloud.position))
        
        return cloud
    }
   fileprivate static func configureName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        let randomNumber = distribution.nextInt()
        let imageName = "cl" + String(randomNumber)
        
        return imageName
        
    }
   fileprivate static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 20, highestValue: 30)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
  
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePOint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 150.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePOint, duration: TimeInterval(duration))
    }
    
    
}
