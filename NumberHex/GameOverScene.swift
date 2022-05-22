//
//  GameOverScene.swift
//  GameTry
//
//  Created by Samuel Hong on 5/17/22.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene{
    
    
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
        gameOverSign1.text = "GAME OVER"
        self.addChild(gameOverSign1)

        let labelScore = SKLabelNode(fontNamed: "GillSans-SemiBold")
        labelScore.fontColor = UIColor.black
        
        let scoreLabel = SKLabelNode(fontNamed: "GillSans-SemiBold")
        scoreLabel.fontColor = UIColor.black
        scoreLabel.position = CGPoint(x:self.size.width/2, y:self.size.height/2-50)
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.setScale(2)
        scoreLabel.zPosition = 3
        scoreLabel.text = "Score: \(GameScene.Info.score)"
        self.addChild(scoreLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let newGame = GameScene(size:self.size)
        newGame.scaleMode = self.scaleMode
        let transition = SKTransition.fade(withDuration: 0.75)
        self.view!.presentScene(newGame, transition: transition)
    }
}
