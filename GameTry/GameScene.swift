//
//  GameScene.swift
//  GameTry
//
//  Created by Samuel Hong on 5/16/22.
//

import SpriteKit
import GameplayKit
import CoreGraphics
import AVFoundation

let defaults = UserDefaults()
var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
var sound = defaults.integer(forKey: "sound")

class GameScene: SKScene {
    
    
    struct Info{
        static var score = 0
        static var target = 1
        static var value = Int.random(in: 1 ... 9)
        static var sound = 1
    }
    
    public class CenterSpriteNode : SKSpriteNode{
        
        var value = 0
        var GScene:GameScene?
        let label = SKLabelNode(fontNamed: "GillSans-Bold")
        var originalPosition = CGPoint(x:0, y:0)
        var outsideHexes: [TouchableSpriteNode] = []
        let border = UIBezierPath()
        var lock = 0
        var prevHex = "hex7"
        func st(c:CenterSpriteNode){
            self.originalPosition = self.position
            label.text = String(value)
            label.fontColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
            label.position = position
            label.verticalAlignmentMode = .center
            label.setScale(3)
            label.isUserInteractionEnabled = false
            label.zPosition = 4
            GScene!.addChild(label)
        }
        
        func addHex(tempHex:TouchableSpriteNode){
            outsideHexes.append(tempHex)
        }
        
        func moveBorder(){
            border.move(to: outsideHexes[1].position)
            border.addLine(to: CGPoint(x:self.originalPosition.x-75, y:self.originalPosition.y+129.9))
            border.addLine(to: outsideHexes[0].position)
            border.addLine(to: CGPoint(x:self.originalPosition.x-150, y:self.originalPosition.y))
            border.addLine(to: outsideHexes[3].position)
            border.addLine(to: CGPoint(x:self.originalPosition.x-75, y:self.originalPosition.y-129.9))
            border.addLine(to: outsideHexes[4].position)
            border.addLine(to: CGPoint(x:self.originalPosition.x+75, y:self.originalPosition.y-129.9))
            border.addLine(to: outsideHexes[5].position)
            border.addLine(to: CGPoint(x:self.originalPosition.x+150, y:self.originalPosition.y))
            border.addLine(to: outsideHexes[2].position)
            border.addLine(to: CGPoint(x:self.originalPosition.x+75, y:self.originalPosition.y+129.9))
            border.addLine(to: outsideHexes[1].position)
        }
        
        func findClosestHex(mousePos:CGPoint) -> TouchableSpriteNode{
            var minDis = 10000.0
            var minHex = outsideHexes[0]
            for hex in outsideHexes{
                let temp1 = hex.position.x - mousePos.x
                let temp2 = hex.position.y - mousePos.y
                let dis = sqrt(temp1*temp1 + temp2*temp2)
                if dis < minDis{
                    minHex = hex
                    minDis = dis
                }
            }
            return minHex
        }
        
        func generateValue() -> Int{
            
            var temp: [Int] = []
            let temp2 = [1,2,3,4,5,6,7,8,9]
            for a in temp2{
                for hex in outsideHexes{
                    if(hex.value + a) % Info.target != 0{
                        temp.append(a)
                        break
                    }
                }
            }
            let temp3 = temp.randomElement()
            return temp3!
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
            
            for touch: AnyObject in touches{
                
                let pointOfTouch = touch.location(in: self)
                let previousPoint = touch.previousLocation(in: self)
                let amountDraggedX = pointOfTouch.x - previousPoint.x
                let amountDraggedY = pointOfTouch.y - previousPoint.y
                let mousePos = CGPoint(x:pointOfTouch.x+self.position.x, y:pointOfTouch.y+self.position.y)
                if border.contains(self.position){
                    if lock == 0{
                        self.position.x += amountDraggedX
                        self.position.y += amountDraggedY
                        label.position.x += amountDraggedX
                        label.position.y += amountDraggedY
                    }
                    else{
                        self.position.y = mousePos.y
                        self.position.x = mousePos.x
                        label.position.y = mousePos.y
                        label.position.x = mousePos.x
                    }
                }
                
                if !border.contains(self.position){
                    lock = 1
                    //self.texture = SKTexture(imageNamed: "hexagon-2")
                    let closestHex = findClosestHex(mousePos: self.position)
                    self.position.x = closestHex.position.x
                    self.position.y = closestHex.position.y
                    self.label.position.x = closestHex.position.x
                    self.label.position.y = closestHex.position.y
                    self.label.zPosition = 1
                    closestHex.label.text = String(closestHex.value + value)
                    closestHex.setScale(1.1)
                    for hex in outsideHexes{
                        if hex != closestHex{
                            hex.setScale(1)
                            hex.label.text = String(hex.value)
                        }
                    }
                    if closestHex.name != prevHex{
                        /*
                        if sound == 1{
                            var player: AVAudioPlayer?
                            if let path = NSDataAsset(name: "Tink"){
                                do {
                                    player = try AVAudioPlayer(data:path.data, fileTypeHint: "mp3")
                                    player?.delegate = self as? AVAudioPlayerDelegate
                                    player?.prepareToPlay()
                                    player?.play()

                                } catch let error {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                        */
                        prevHex = closestHex.name!
                    }
                }
                else{
                    self.label.zPosition = 50
                    for hex in outsideHexes{
                        hex.setScale(1)
                        hex.label.text = String(hex.value)
                    }
                    prevHex = "hex7"
                }
            }
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
            for hex in self.outsideHexes{
                let dis = sqrt((self.position.x - hex.position.x)*(self.position.x - hex.position.x) + (self.position.y - hex.position.y)*(self.position.y - hex.position.y))
                hex.setScale(1)
                if(dis < 5){
                    hex.addToHex()
                }
            }
            self.position = self.originalPosition
            self.label.position = self.originalPosition
            self.label.zPosition = 5
            lock = 0
            prevHex = "hex7"
        }
    }
    
    public class TouchableSpriteNode : SKSpriteNode{
        var value = 0
        var GScene:GameScene?
        var CenterHex:CenterSpriteNode?
        var LabelScore:SKLabelNode?
        let label = SKLabelNode(fontNamed: "GillSans-Bold")
        func st(c:CenterSpriteNode){
            label.text = String(value)
            label.position = position
            label.verticalAlignmentMode = .center
            label.setScale(3)
            label.zPosition = 4
            GScene!.addChild(label)
            CenterHex = c
        }
        
        func addToHex(){
            if((value + CenterHex!.value) % Info.target == 0){
                if(Info.score > highScoreNumber){
                    highScoreNumber = Info.score
                    defaults.set(highScoreNumber, forKey: "highScoreSaved")
                }
                if sound == 1{
                    //let systemSoundID: SystemSoundID = 1006
                    //AudioServicesPlaySystemSound(systemSoundID)
                    
                    
                }
                let gameOver = GameOverScene(size:GScene!.size)
                gameOver.scaleMode = GScene!.scaleMode
                let transition = SKTransition.fade(withDuration: 0.75)
                GScene!.view!.presentScene(gameOver, transition: transition)
            }
            else{
                if sound == 1{
                    //let systemSoundID: SystemSoundID = 1100
                    //AudioServicesPlaySystemSound(systemSoundID)
                    
                }
                Info.score += (CenterHex!.value*(10-Info.target))
                if(Info.score > highScoreNumber){
                    highScoreNumber = Info.score
                    defaults.set(highScoreNumber, forKey: "highScoreSaved")
                }
                value += CenterHex!.value
                let temp = CenterHex!.generateValue()
                Info.value = temp
                CenterHex!.value = temp
                CenterHex!.label.text = String(CenterHex!.value)
                label.text = String(value)
                LabelScore!.text = "SCORE " + String(Info.score)
            }
            
        }
        /*
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            label.text = String(self.value + CenterHex!.value)
            self.setScale(1.1)
        }
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            label.text = String(self.value + CenterHex!.value)
            self.setScale(1.1)
            for touch: AnyObject in touches{
                
                let pointOfTouch = touch.location(in: self)
                let dis = sqrt((pointOfTouch.x * pointOfTouch.x) + (pointOfTouch.y * pointOfTouch.y))
                if dis > 130{
                    label.text = String(self.value)
                    self.setScale(1)
                }
            }
            
        }
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
            
            self.setScale(1)
            
            for touch: AnyObject in touches{
                
                let pointOfTouch = touch.location(in: self)
                let dis = sqrt((pointOfTouch.x * pointOfTouch.x) + (pointOfTouch.y * pointOfTouch.y))
                if dis < 130{
                    addToHex()
                }
            }
             
        }
        */
    }
    
    
    override func didMove(to view: SKView) {
        
        func generateOuterHexes(tempHex: TouchableSpriteNode, n: Int){
            let nameList = ["hex1","hex2","hex3","hex4","hex5","hex6"]
            tempHex.name = nameList[n]
            tempHex.isUserInteractionEnabled = true
            tempHex.value = Int.random(in: 1 ... 9)
            tempHex.GScene = self
            tempHex.st(c:hexCenter)
            tempHex.LabelScore = labelScore
            tempHex.zPosition = 2
            hexCenter.addHex(tempHex:tempHex)
            self.addChild(tempHex)
        }
        
        Info.target = Int.random(in: 3 ... 9)
        Info.value = Int.random(in: 1 ... 9)
        Info.score = 0
        let backgroundColor = UIColor(red: 255/255, green: 247/255, blue: 228/255, alpha: 0.5)
        self.backgroundColor = backgroundColor
        
        let hexSize = CGFloat(300)
        let hexHeight = hexSize/2 * sqrt(3)
                
        
        let hexCenter = CenterSpriteNode(imageNamed: "hexagon-1")
        hexCenter.name = "hexcenter"
        hexCenter.value = Info.value
        hexCenter.isUserInteractionEnabled = true
        hexCenter.position = CGPoint(x:self.size.width/2, y:self.size.height/2-300)
        hexCenter.zPosition = 3
        hexCenter.GScene = self
        self.addChild(hexCenter)
        
        let hex1 = TouchableSpriteNode(imageNamed: "hexagon-2")
        hex1.position = CGPoint(x:self.size.width/2-hexSize*0.75-5, y:self.size.height/2+hexHeight*0.5+5-300)
        
        let hex2 = TouchableSpriteNode(imageNamed: "hexagon-2")
        hex2.position = CGPoint(x:self.size.width/2, y:self.size.height/2+hexHeight+10-300)
        
        let hex3 = TouchableSpriteNode(imageNamed: "hexagon-2")
        hex3.position = CGPoint(x:self.size.width/2+hexSize*0.75+5, y:self.size.height/2+hexHeight*0.5+5-300)
        
        let hex4 = TouchableSpriteNode(imageNamed: "hexagon-2")
        hex4.position = CGPoint(x:self.size.width/2-hexSize*0.75-5, y:self.size.height/2-hexHeight*0.5-5-300)
        
        let hex5 = TouchableSpriteNode(imageNamed: "hexagon-2")
        hex5.position = CGPoint(x:self.size.width/2, y:self.size.height/2-hexHeight-10-300)
        
        let hex6 = TouchableSpriteNode(imageNamed: "hexagon-2")
        hex6.position = CGPoint(x:self.size.width/2+hexSize*0.75+5, y:self.size.height/2-hexHeight*0.5-5-300)
        
            
        hexCenter.GScene = self
        hexCenter.st(c:hexCenter)
        
        let width1 = Double(400)
        let height1 = Double(140)
        
        let labelScore = SKLabelNode(fontNamed: "GillSans-SemiBold")
        labelScore.fontColor = UIColor.white
        
        labelScore.position = CGPoint(x:self.size.width/3+50+(width1-height1)/2, y:self.size.height/2+650)
        labelScore.verticalAlignmentMode = .center
        labelScore.horizontalAlignmentMode = .center
        labelScore.zPosition = 3
        labelScore.text = "SCORE " + String(Info.score)
        labelScore.fontSize = 65
        self.addChild(labelScore)

        generateOuterHexes(tempHex:hex1,n:0)
        generateOuterHexes(tempHex:hex2,n:1)
        generateOuterHexes(tempHex:hex3,n:2)
        generateOuterHexes(tempHex:hex4,n:3)
        generateOuterHexes(tempHex:hex5,n:4)
        generateOuterHexes(tempHex:hex6,n:5)
        
        let temp = hexCenter.generateValue()
        hexCenter.value = temp
        Info.value = temp
        hexCenter.label.text = String(temp)
        
        let bestScoreLabel = SKLabelNode(fontNamed: "GillSans-SemiBold")
        bestScoreLabel.fontColor = UIColor.white
        
        bestScoreLabel.position = CGPoint(x:self.size.width/3+50 + (width1-height1)/2,y:self.size.height/2+800)
        bestScoreLabel.verticalAlignmentMode = .center
        bestScoreLabel.horizontalAlignmentMode = .center
        bestScoreLabel.zPosition = 3
        self.addChild(bestScoreLabel)
        bestScoreLabel.text = "BEST " + String(highScoreNumber)
        bestScoreLabel.fontSize = 65
        
        let labelT = SKLabelNode(fontNamed: "GillSans-SemiBold")
        labelT.fontColor = UIColor.black
        labelT.text = "Don't let any hexagon\nbe divisible by "
        labelT.position = CGPoint(x:self.size.width/3+110, y:self.size.height/2+300)
        labelT.verticalAlignmentMode = .center
        labelT.numberOfLines = 2
        labelT.setScale(1.5)
        labelT.zPosition = 3
        self.addChild(labelT)
        
        let labelT2 = SKLabelNode(fontNamed: "GillSans-Bold")
        labelT2.fontColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
        labelT2.text = String(Info.target)
        labelT2.position = CGPoint(x:self.size.width/3*2, y:self.size.height/2+300)
        labelT2.verticalAlignmentMode = .center
        labelT2.setScale(3)
        labelT2.zPosition = 3
        self.addChild(labelT2)
        
        let targetHex = SKSpriteNode(imageNamed: "hexagon-1")
        targetHex.name = "targetHex"
        targetHex.position = CGPoint(x:self.size.width/3*2, y:self.size.height/2+300)
        targetHex.zPosition = 2
        self.addChild(targetHex)
        
        
        let scoreBox = SKShapeNode(rect: CGRect(x: self.size.width/3-width1/2+50, y:self.size.height/2+650-height1/2, width: 2*width1-height1, height: height1), cornerRadius: 15)
        scoreBox.zPosition = 2
        scoreBox.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
        self.addChild(scoreBox)
        
        let bestBox = SKShapeNode(rect: CGRect(x: self.size.width/3-width1/2+50.0, y:self.size.height/2+800-height1/2, width: 2*width1-height1, height: height1), cornerRadius: 15)
        bestBox.zPosition = 2
        bestBox.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
        self.addChild(bestBox)
        
        let refreshNodeBox = SKShapeNode(rect: CGRect(x: self.size.width/3*2-width1/2-50.0+(width1-height1), y:self.size.height/2+650-height1/2, width: height1, height: height1), cornerRadius: 15)
        refreshNodeBox.zPosition = 2
        refreshNodeBox.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
        refreshNodeBox.name = "refreshNodeBox"
        self.addChild(refreshNodeBox)
            
        let refreshNode = SKLabelNode(fontNamed: "GillSans-SemiBold")
        refreshNode.text = "NEW"
        refreshNode.fontColor = SKColor.white
        refreshNode.position = CGPoint(x:self.size.width/3*2 - 50+(width1-height1)/2, y:self.size.height/2+650)
        refreshNode.fontSize = 40
        refreshNode.zPosition = 3
        refreshNode.verticalAlignmentMode = .center
        refreshNode.name = "refresh"
        //self.addChild(refreshNode)
        
        let rfNode = SKSpriteNode(imageNamed: "refresh")
        rfNode.name = "refresh"
        rfNode.position = CGPoint(x:self.size.width/3*2 - 50+(width1-height1)/2, y:self.size.height/2+650)
        rfNode.zPosition = 2
        rfNode.setScale(0.3)
        self.addChild(rfNode)
        
        
        let mainMenuNodeBox = SKShapeNode(rect: CGRect(x: self.size.width/3*2-width1/2 - 50.0+(width1-height1), y: self.size.height/2+800-height1/2, width: height1, height: height1), cornerRadius: 15)
        mainMenuNodeBox.zPosition = 2
        mainMenuNodeBox.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
        mainMenuNodeBox.name = "mainMenuNodeBox"
        self.addChild(mainMenuNodeBox)
        
        let mainMenuNode = SKLabelNode(fontNamed: "GillSans-SemiBold")
        mainMenuNode.text = "MENU"
        mainMenuNode.fontColor = SKColor.white
        mainMenuNode.position = CGPoint(x:self.size.width/3*2 - 50+(width1-height1)/2, y:self.size.height/2+800)
        mainMenuNode.fontSize = 40
        mainMenuNode.zPosition = 2
        mainMenuNode.verticalAlignmentMode = .center
        mainMenuNode.name = "mainMenu"
        //self.addChild(mainMenuNode)
        let homeNode = SKSpriteNode(imageNamed: "home-2")
        homeNode.name = "mainMenu"
        homeNode.position = CGPoint(x:self.size.width/3*2 - 50+(width1-height1)/2, y:self.size.height/2+800)
        homeNode.zPosition = 2
        homeNode.setScale(0.3)
        self.addChild(homeNode)
        
        let soundNode = SKSpriteNode(imageNamed: "unmute")
        if sound == 0{
            soundNode.texture = SKTexture(imageNamed: "mute")
        }
        soundNode.name = "sound"
        soundNode.position = CGPoint(x:self.size.width/3*2 - 50+(width1-height1)/2, y:self.size.height/2+950)
        soundNode.zPosition = 2
        soundNode.setScale(0.3)
        //self.addChild(soundNode)
        hexCenter.moveBorder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)
            if nodeITapped.name == "refresh" || nodeITapped.name == "refreshNodeBox"{
                
                let newGame = GameScene(size:self.size)
                newGame.scaleMode = self.scaleMode
                let transition = SKTransition.fade(withDuration: 0.75)
                self.view!.presentScene(newGame, transition: transition)
            }
            if nodeITapped.name == "sound"{
                let temp:SKSpriteNode = (nodeITapped as? SKSpriteNode)!
                if sound == 0{
                    temp.texture = SKTexture(imageNamed: "unmute")
                    defaults.set(1, forKey: "sound")
                    sound = 1
                }
                else{
                    temp.texture = SKTexture(imageNamed: "mute")
                    defaults.set(0, forKey: "sound")
                    sound = 0
                }
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
