//
//  BattleViewController.swift
//  MalvaniGo
//
//  Created by admin on 07/04/17.
//  Copyright © 2017 ACE. All rights reserved.
//

import UIKit
import SpriteKit
class BattleViewController: UIViewController {
    
    var pokemon : Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = battleScene(size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        self.view = SKView() //
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = false
        
        
        scene.pokemon = pokemon
        scene.scaleMode = .aspectFit
        skView.presentScene(scene)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
