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
        
        let mainMenuLabel = SKSpriteNode(imageNamed: "home-2")
        //mainMenuLabel.fontColor = UIColor.white
        mainMenuLabel.position = CGPoint(x:self.size.width/3+50.0, y:self.size.height/2-500)
        //mainMenuLabel.verticalAlignmentMode = .center
        //mainMenuLabel.horizontalAlignmentMode = .center
        mainMenuLabel.setScale(0.7)
        mainMenuLabel.zPosition = 3
        //mainMenuLabel.text = "MENU"
        mainMenuLabel.name = "mainMenu"
        self.addChild(mainMenuLabel)
        
        let width1 = Double(250)
        
        let refreshNodeBox = SKShapeNode(rect: CGRect(x: self.size.width/3*2-width1/2-50.0, y: self.size.height/2-500-width1/2, width: width1, height: width1), cornerRadius: 15)
        refreshNodeBox.zPosition = 2
        refreshNodeBox.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
        refreshNodeBox.name = "refreshNodeBox"
        self.addChild(refreshNodeBox)
        
        let newGameLabel = SKSpriteNode(imageNamed: "refresh")
        //newGameLabel.fontColor = UIColor.white
        newGameLabel.position = CGPoint(x:self.size.width/3*2-50.0, y:self.size.height/2-500.0)
        newGameLabel.setScale(0.7)
        newGameLabel.zPosition = 3
        newGameLabel.name = "refresh"
        self.addChild(newGameLabel)
        
        let mainMenuNodeBox = SKShapeNode(rect: CGRect(x: self.size.width/3-width1/2+50.0, y:self.size.height/2-500-width1/2, width: width1, height: width1), cornerRadius: 15)
        mainMenuNodeBox.zPosition = 2
        mainMenuNodeBox.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
        mainMenuNodeBox.name = "mainMenuNodeBox"
        self.addChild(mainMenuNodeBox)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)
            if nodeITapped.name == "refresh" || nodeITapped.name == "refreshNodeBox"{
                let newGame = GameScene(size:self.size)
                newGame.scaleMode = self.scaleMode
                let transition = SKTransition.fade(withDuration: 0.75)
                self.view!.presentScene(newGame, transition: transition)
            }
            if nodeITapped.name == "mainMenu" || nodeITapped.name == "mainMenuNodeBox"{
                let mainMenu = MainMenuScene(size:self.size)
                mainMenu.scaleMode = self.scaleMode
                let transition = SKTransition.fade(withDuration: 0.75)
                self.view!.presentScene(mainMenu, transition: transition)
            }
        }
        
    }
    
    
    
}
