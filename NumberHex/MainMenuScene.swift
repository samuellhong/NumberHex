//
//  MainMenuScene.swift
//  GameTry
//
//  Created by Samuel Hong on 5/17/22.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene{
    
    
    override func didMove(to view: SKView){
        
        let backgroundColor = UIColor(red: 255/255, green: 247/255, blue: 228/255, alpha: 0.5)
        self.backgroundColor = backgroundColor
        
        let gameOverSign1 = SKLabelNode(fontNamed: "GillSans-SemiBold")
        gameOverSign1.fontColor = UIColor.black
        gameOverSign1.position = CGPoint(x:self.size.width/2, y:self.size.height/2+250)
        gameOverSign1.verticalAlignmentMode = .center
        gameOverSign1.horizontalAlignmentMode = .center
        gameOverSign1.setScale(2.4)
        gameOverSign1.zPosition = 3
        gameOverSign1.text = "Main"
        self.addChild(gameOverSign1)
        
        let gameOverSign2 = SKLabelNode(fontNamed: "GillSans-SemiBold")
        gameOverSign2.fontColor = UIColor.black
        gameOverSign2.position = CGPoint(x:self.size.width/2, y:self.size.height/2+150)
        gameOverSign2.verticalAlignmentMode = .center
        gameOverSign2.horizontalAlignmentMode = .center
        gameOverSign2.setScale(2.4)
        gameOverSign2.zPosition = 3
        gameOverSign2.text = "Menu"
        self.addChild(gameOverSign2)
        
        let click = SKLabelNode(fontNamed: "GillSans-SemiBold")
        click.fontColor = UIColor.black
        click.position = CGPoint(x:self.size.width/2, y:self.size.height/2-200)
        click.verticalAlignmentMode = .center
        click.horizontalAlignmentMode = .center
        click.setScale(1.8)
        click.zPosition = 3
        click.text = "Click Anywhere"
        self.addChild(click)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        let game = GameScene2(size:self.size)
        game.scaleMode = self.scaleMode
        let transition = SKTransition.fade(withDuration: 0.75)
        self.view!.presentScene(game, transition: transition)
        
    }
}
