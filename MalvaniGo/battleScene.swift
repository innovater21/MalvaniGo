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
    var pokemonsprite : SKSpriteNode!
    var pokeballsprite : SKSpriteNode!
    
    //define constant
    let kPokemonSize = CGSize(width: 120 , height: 120)
    let kPokeballSize = CGSize(width: 60 , height: 60)
    
    
    //define bitcategories
    let kpokeballcategory : UInt32 = 0x1 << 0
    let kpokemoncategory : UInt32 = 0x1 << 1
    let kedgecategory : UInt32 = 0x1 << 2
    
    
    // physics variable setup
    var velocity : CGPoint = CGPoint.zero
    var touchpoint : CGPoint = CGPoint()
    var canthrowpokball : Bool = false
    
    //other variables
    var startCount = false
    var maxTime = 20
    var myTime = 20
    var pokemonCaught = false
    var timeLabel = SKLabelNode(fontNamed: "Helvetica")
    
    
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
        
        self.makeMessageWith(imageName: "battle")
        
        
        self.perform(#selector(setupPokemon), with: nil, afterDelay: 2.0)
        self.perform(#selector(setupPokeBall), with: nil, afterDelay: 2.0)
        
        //physics body setup
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = kedgecategory
        
        self.physicsWorld.contactDelegate = self
        self.startCount = true
        //Adding Label to the UI
        
        self.timeLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.9)
        self.addChild(timeLabel)
    }

    func setupPokemon(){
    
        self.pokemonsprite = SKSpriteNode(imageNamed: pokemon.imageFileName!)
        self.pokemonsprite.size = kPokemonSize
        self.pokemonsprite.position = CGPoint(x: self.size.width/2 , y: self.size.height/2)
        self.pokemonsprite.zPosition = 1
        
        //pokemon physics
        self.pokemonsprite.physicsBody = SKPhysicsBody(rectangleOf: kPokemonSize)
        self.pokemonsprite.physicsBody?.affectedByGravity = false
        self.pokemonsprite.physicsBody?.isDynamic = false
        self.pokemonsprite.physicsBody?.mass = 6.0
        
        //movements
        let moveRight = SKAction.moveBy(x: 100, y: 0, duration: 3.0)
        let sequence = SKAction.sequence([moveRight , moveRight.reversed(), moveRight.reversed(), moveRight] )
        self.pokemonsprite.run(SKAction.repeatForever(sequence))
        
        //bitmass
        pokemonsprite.physicsBody?.categoryBitMask = kpokemoncategory
        pokemonsprite.physicsBody?.collisionBitMask = kedgecategory
        pokemonsprite.physicsBody?.contactTestBitMask = kpokeballcategory
        
        self.addChild(pokemonsprite)
    }
    func setupPokeBall(){
        
        self.pokeballsprite = SKSpriteNode(imageNamed: "pokeball")
        self.pokeballsprite.size = kPokeballSize
        self.pokeballsprite.position = CGPoint(x: self.size.width/2 , y: 50)
        self.pokeballsprite.zPosition = 1
        
        
        //setup pokeball physics
        self.pokeballsprite.physicsBody = SKPhysicsBody(circleOfRadius: self.pokeballsprite.frame.size.width/2 )
        self.pokeballsprite.physicsBody?.affectedByGravity = true
        self.pokeballsprite.physicsBody?.isDynamic = true
        self.pokeballsprite.physicsBody?.mass = 0.5
        
        // bitmass
        pokeballsprite.physicsBody?.categoryBitMask = kpokeballcategory
        pokeballsprite.physicsBody?.contactTestBitMask = kpokemoncategory
        pokeballsprite.physicsBody?.collisionBitMask = kpokemoncategory | kedgecategory
        
        self.addChild(pokeballsprite)
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
    self.canthrowpokball = true
    let touch = touches.first
    let location = touch?.location(in: self)
    
        if self.pokeballsprite.frame.contains(location!){
            self.canthrowpokball = true
        }
            
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        
            let touch = touches.first
            let location = touch?.location(in:self)
            self.touchpoint = location!
            if self.canthrowpokball{
                throwball()
            }
        }
 
     func didBegin(_ contact: SKPhysicsContact) {
            let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
            switch contactMask {
            case kpokemoncategory | kpokeballcategory :
                print("Pokemon has been Caught")
                self.pokemonCaught = true
                endgame()
            default:
                return
        }
        }
  
    override func update(_ currentTime: TimeInterval) {
        if self.startCount{
            self.maxTime = Int(currentTime) + self.maxTime
            self.startCount = false
        }
        self.myTime = self.maxTime - Int(currentTime)
        self.timeLabel.text = "\(self.myTime)"
        if self.myTime <= 0 {
            endgame()
        }
        
    }
    
    func throwball(){
        self.canthrowpokball = false
        let dt : CGFloat = 1.0/30
        let distance = CGVector(dx: self.touchpoint.x - self.pokeballsprite.position.x, dy: self.touchpoint.y - self.pokeballsprite.position.y)
        let velocity = CGVector( dx: distance.dx/dt, dy: distance.dy/dt )
        self.pokeballsprite.physicsBody?.velocity = velocity
    }
    
    func endgame(){
       self.pokeballsprite.removeFromParent()
        self.pokemonsprite.removeFromParent()
        
        if pokemonCaught{
            
            self.makeMessageWith(imageName: "gotcha")
            self.pokemon.timesCaught += 1
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }
        else{
            self.makeMessageWith(imageName: "footprints")
        }
        self.perform(#selector(endbattle), with: nil , afterDelay: 3.0)
    }
    
    
    func endbattle(){
        NotificationCenter.default.post(name: NSNotification.Name("StopBattle"), object: nil)
    }
    
    func makeMessageWith(imageName: String){
        let message  = SKSpriteNode (imageNamed: imageName)
        message.size = CGSize(width: 150, height: 150)
        message.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        message.run(SKAction.sequence([SKAction.wait(forDuration: 2),SKAction.removeFromParent()]))
        self.addChild(message)
    }
}


