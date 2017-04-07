//
//  battleScene.swift
//  MalvaniGo
//
//  Created by admin on 07/04/17.
//  Copyright © 2017 ACE. All rights reserved.
//

import UIKit
import SpriteKit

class battleScene: SKScene, SKPhysicsContactDelegate{
    
    var pokemon : Pokemon!
    
    //View did load for game scene
    override func didMove(to view: SKView) {
        print("Gotta Catch them All")
        print(pokemon.hello)
        
        //BackGround Code
        let battleBG = SKSpriteNode(imageNamed: "FullSizeRender")
        battleBG.size = self.size
        battleBG.position = CGPoint(x: self.size.width/2, y: self.size.height/2) //Show the center poisition of image
        battleBG.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        battleBG.zPosition = -1
        self.addChild(battleBG)
    }
}
