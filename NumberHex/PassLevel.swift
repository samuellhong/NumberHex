//
//  PassLevel.swift
//  NumberHex
//
//  Created by Samuel Hong on 5/23/22.
//

import Foundation
import SpriteKit

class PassLevel: SKScene{
    
    override func didMove(to view: SKView) {
        
        let backgroundColor = UIColor(red: 255/255, green: 247/255, blue: 228/255, alpha: 0.5)
        self.backgroundColor = backgroundColor
        let gameOverSign1 = SKLabelNode(fontNamed: "GillSans-SemiBold")
        gameOverSign1.fontColor = UIColor.black
        gameOverSign1.position = CGPoint(x:self.size.width/2, y:self.size.height/2+50)
        gameOverSign1.verticalAlignmentMode = .center
        gameOverSign1.horizontalAlignmentMode = .center
        gameOverSign1.setScale(3)
        gameOverSign1.zPosition = 3
        gameOverSign1.text = "SUCCESS"
        self.addChild(gameOverSign1)
        
        let scoreLabel = SKLabelNode(fontNamed: "GillSans-SemiBold")
        scoreLabel.fontColor = UIColor.black
        scoreLabel.position = CGPoint(x:self.size.width/2, y:self.size.height/2-50)
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.setScale(2)
        scoreLabel.zPosition = 3
        scoreLabel.text = "Click to Move On"
        self.addChild(scoreLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if level >= 30{ //24
            defaults.set(level, forKey:"currentLevel")
        }
        else{
            highestLevel = defaults.integer(forKey: "highestLevel")
            level += 1
            if level > highestLevel{
                defaults.set(level, forKey: "highestLevel")
                highestLevel += 1
            }
            defaults.set(level, forKey:"currentLevel")
        }
        let newGame = GameScene2(size:self.size)
        newGame.scaleMode = self.scaleMode
        let transition = SKTransition.fade(withDuration: 0.75)
        self.view!.presentScene(newGame, transition: transition)
    }
    
}
