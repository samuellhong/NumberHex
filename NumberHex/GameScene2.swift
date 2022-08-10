//
//  GameScene2.swift
//  NumberHex
//
//  Created by Samuel Hong on 5/23/22.
//

import SpriteKit
import GameplayKit
import CoreGraphics
import AVFoundation

let defaults = UserDefaults()
var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
var currentScoreNumber = defaults.integer(forKey: "currentScore")
var highestLevel = defaults.integer(forKey: "highestLevel")

var sound = defaults.integer(forKey: "sound")
let menuPopUp = SKShapeNode(rect: CGRect(x:0,y:0,width:1536, height:2048))
let resume = SKShapeNode(rect: CGRect(x: 1536/2-200, y:2048/2+375-70, width: 400, height: 140), cornerRadius: 15)
let resumeLabel = SKLabelNode(fontNamed: "GillSans-SemiBold")

let howTo = SKShapeNode(rect: CGRect(x: 1536/2-200, y:2048/2+100-70, width: 400, height: 140), cornerRadius: 15)
let howToLabel = SKLabelNode(fontNamed: "GillSans-SemiBold")
let rulesPage = SKShapeNode(rect: CGRect(x:0,y:0,width:1536, height:2048))
let rulesNotes = SKLabelNode(fontNamed: "GillSans-SemiBold")

let levelsBox = SKShapeNode(rect: CGRect(x: 1536/2-200, y:2048/2-175-70, width: 400, height: 140), cornerRadius: 15)
let levelsLabel = SKLabelNode(fontNamed: "GillSans-SemiBold")

let freePlayBox = SKShapeNode(rect: CGRect(x: 1536/2-200, y:2048/2-450-70, width: 400, height: 140), cornerRadius: 15)
let freePlayLabel = SKLabelNode(fontNamed: "GillSans-SemiBold")

let levelsP = levelsPage(rect: CGRect(x:0,y:0,width:1536, height:2048))

let fSize1 = 65.0
var level = defaults.integer(forKey: "currentLevel")
var levelBoxes:[SKShapeNode] = []
var levelLabelBoxes:[SKLabelNode] = []

func generateMenu(GScene:GameScene2){
    menuPopUp.fillColor = UIColor(red: 255/255, green: 247/255, blue: 228/255, alpha: 0.9)
    resume.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
    howTo.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
    levelsBox.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
    freePlayBox.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
    resumeLabel.position = CGPoint(x:GScene.size.width/2, y:GScene.size.height/2+350)
    howToLabel.position = CGPoint(x:GScene.size.width/2, y:GScene.size.height/2+75)
    levelsLabel.position = CGPoint(x:GScene.size.width/2, y:GScene.size.height/2-200)
    freePlayLabel.position = CGPoint(x:GScene.size.width/2, y:GScene.size.height/2-475)
    menuPopUp.zPosition = 50
    resume.zPosition = 51
    resumeLabel.zPosition = 52
    howToLabel.zPosition = 52
    resume.name = "resume"
    resumeLabel.name = "resume"
    resumeLabel.text = "RESUME"
    resumeLabel.fontSize = 65
    resumeLabel.horizontalAlignmentMode = .center
    howTo.zPosition = 51
    howTo.name = "howto"
    howToLabel.name = "howto"
    howToLabel.fontSize = 65
    howToLabel.text = "RULES"
    levelsLabel.name = "levels"
    levelsLabel.fontSize = 65
    levelsLabel.text = "LEVELS"
    levelsLabel.zPosition = 52
    freePlayLabel.name = "freeplay"
    freePlayLabel.zPosition = 52
    freePlayLabel.text = "FREEPLAY"
    freePlayLabel.fontSize = 65
    rulesPage.fillColor = UIColor(red: 255/255, green: 247/255, blue: 228/255, alpha: 0.9)
    rulesNotes.zPosition = 54
    let rulesText = "Slide the center hexagon\ninto another, adding\ntheir two numbers.\n\nTarget values may increase\nwith higher scores."
    rulesNotes.text = rulesText
    rulesNotes.horizontalAlignmentMode = .center;
    rulesNotes.verticalAlignmentMode = .center;
    rulesNotes.numberOfLines = 6
    rulesNotes.position = CGPoint(x:GScene.size.width/2, y:GScene.size.height/2)
    rulesNotes.fontColor = SKColor.black
    rulesNotes.fontSize = 65
    rulesNotes.name = "rules"
    rulesPage.zPosition = 53
    rulesPage.name = "rules"
    levelsBox.name = "levels"
    levelsBox.zPosition = 51
    freePlayBox.name = "freeplay"
    freePlayBox.zPosition = 51
    levelsP.name = "levelsP"
    levelsP.addLevelNodes()
}

func showMenu(GScene:GameScene2){
    menuPopUp.addChild(resume)
    menuPopUp.addChild(resumeLabel)
    menuPopUp.addChild(howTo)
    menuPopUp.addChild(howToLabel)
    menuPopUp.addChild(levelsBox)
    menuPopUp.addChild(levelsLabel)
    menuPopUp.addChild(freePlayBox)
    menuPopUp.addChild(freePlayLabel)
    GScene.addChild(menuPopUp)
}
func removeMenu(){
    menuPopUp.removeAllChildren()
    menuPopUp.removeFromParent()
}

func generateScene(GScene:GameScene2){
    
    GScene.backgroundColor = UIColor(red: 255/255, green: 247/255, blue: 228/255, alpha: 0.5)
    let width1 = Double(400)
    let height1 = Double(140)
    let scoreBox = SKShapeNode(rect: CGRect(x: GScene.size.width/3-width1/2+50, y:GScene.size.height/2+650-height1/2, width: 2*width1-height1, height: height1), cornerRadius: 15)
    scoreBox.zPosition = 2
    scoreBox.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
    scoreBox.name = "scoreBox"
    GScene.addChild(scoreBox)
    
    let labelScore = SKLabelNode(fontNamed: "GillSans-SemiBold")
    labelScore.fontColor = UIColor.white
    labelScore.position = CGPoint(x:GScene.size.width/3+50 + (width1-height1)/2,y:GScene.size.height/2+650)
    labelScore.verticalAlignmentMode = .center
    labelScore.zPosition = 6

    labelScore.text = "SCORE 0"
    labelScore.fontSize = fSize1
    scoreBox.addChild(labelScore)
    
    let bestBox = SKShapeNode(rect: CGRect(x: GScene.size.width/3-width1/2+50.0, y:GScene.size.height/2+800-height1/2, width: 2*width1-height1, height: height1), cornerRadius: 15)
    bestBox.zPosition = 2
    bestBox.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
    GScene.addChild(bestBox)
    
    let bestScoreLabel = SKLabelNode(fontNamed: "GillSans-SemiBold")
    bestScoreLabel.fontColor = UIColor.white
    
    bestScoreLabel.position = CGPoint(x:GScene.size.width/3+50 + (width1-height1)/2,y:GScene.size.height/2+800)
    bestScoreLabel.verticalAlignmentMode = .center
    bestScoreLabel.zPosition = 3
    bestScoreLabel.text = "LEVEL " + String(level)
    if level == 0{
        bestScoreLabel.text = "BEST " + String(highScoreNumber)
    }
    bestScoreLabel.fontSize = fSize1
    bestBox.addChild(bestScoreLabel)
          
    let labelT = SKLabelNode(fontNamed: "GillSans-SemiBold")
    labelT.fontColor = UIColor.black
    labelT.text = "Don't let any hexagon\nbe divisible by "
    labelT.position = CGPoint(x:GScene.size.width/3+110, y:GScene.size.height/2+300)
    labelT.verticalAlignmentMode = .center
    labelT.numberOfLines = 2
    labelT.fontSize = 50
    labelT.zPosition = 3
    GScene.addChild(labelT)
    
    let refreshNodeBox = SKShapeNode(rect: CGRect(x: GScene.size.width/3*2-width1/2-50.0+(width1-height1), y:GScene.size.height/2+650-height1/2, width: height1, height: height1), cornerRadius: 15)
    refreshNodeBox.zPosition = 2
    refreshNodeBox.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
    refreshNodeBox.name = "refreshNodeBox"
    GScene.addChild(refreshNodeBox)
    
    let rfNode = SKSpriteNode(imageNamed: "refresh")
    rfNode.name = "refresh"
    rfNode.position = CGPoint(x:GScene.size.width/3*2 - 50+(width1-height1)/2, y:GScene.size.height/2+650)
    rfNode.zPosition = 2
    rfNode.setScale(0.3)
    GScene.addChild(rfNode)
    let mainMenuNodeBox = SKShapeNode(rect: CGRect(x: GScene.size.width/3*2-width1/2 - 50.0+(width1-height1), y: GScene.size.height/2+800-height1/2, width: height1, height: height1), cornerRadius: 15)
    mainMenuNodeBox.zPosition = 2
    mainMenuNodeBox.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
    mainMenuNodeBox.name = "mainMenuNodeBox"
    GScene.addChild(mainMenuNodeBox)
    
    let homeNode = SKSpriteNode(imageNamed: "menu")
    homeNode.name = "mainMenu"
    homeNode.position = CGPoint(x:GScene.size.width/3*2 - 50+(width1-height1)/2, y:GScene.size.height/2+800)
    homeNode.zPosition = 2
    homeNode.setScale(0.3)
    GScene.addChild(homeNode)
}

func generateTargetLabel(GScene:GameScene2, t:Int){
    let targetHex = SKSpriteNode(imageNamed: "hex-1-0")
    targetHex.name = "targetHex"
    targetHex.position = CGPoint(x:GScene.size.width/3*2, y:GScene.size.height/2+300)
    targetHex.zPosition = 2
    GScene.addChild(targetHex)
    let labelT2 = SKLabelNode(fontNamed: "GillSans-Bold")
    labelT2.fontColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
    labelT2.text = String(t)
    labelT2.position = CGPoint(x:0, y:0)
    labelT2.verticalAlignmentMode = .center
    labelT2.setScale(3)
    labelT2.zPosition = 3
    targetHex.addChild(labelT2)
}

class GameScene2 : SKScene{
    
    override func didMove(to view: SKView) {
        let h = defaults.integer(forKey:"highestLevel")
        if h == 0{
            //defaults.set(1, forKey:"currentLevel")
            defaults.set(1, forKey:"highestLevel")
        }
        defaults.set(0, forKey: "currentScore")
        generateScene(GScene:self)
        generateMenu(GScene: self)
        let hexSize = CGFloat(300)
        let hexHeight = hexSize/2 * sqrt(3)
        let hexPos:[CGPoint] = [CGPoint(x:self.size.width/2-hexSize*0.75-5, y:self.size.height/2+hexHeight*0.5+5-300),CGPoint(x:self.size.width/2, y:self.size.height/2+hexHeight+10-300),CGPoint(x:self.size.width/2+hexSize*0.75+5, y:self.size.height/2+hexHeight*0.5+5-300),CGPoint(x:self.size.width/2-hexSize*0.75-5, y:self.size.height/2-hexHeight*0.5-5-300),CGPoint(x:self.size.width/2, y:self.size.height/2-hexHeight-10-300),CGPoint(x:self.size.width/2+hexSize*0.75+5, y:self.size.height/2-hexHeight*0.5-5-300)]
        //let hexPos2:[CGPoint] = [CGPoint(x:hexPos[1].x-hexSize*0.75-5.0, y:(self.size.height/2-300.0)+hexHeight*1.5+15.0),CGPoint(x:hexPos[1].x, y:self.size.height/2-300.0+2.0*(hexHeight+10)),CGPoint(x:hexPos[1].x+hexSize*0.75+5.0, y:self.size.height/2+hexHeight*1.5+15.0-300.0)]
        if level == 0{ //FREE PLAY MODE
            
            let centerHex = hexNode(imageNamed: "hex-1-0")
            let val = Int.random(in: 1 ... 9)
            let pos = CGPoint(x:self.size.width/2, y:self.size.height/2-300)
            centerHex.start(g:self, v:val, r:0, p:pos)
            
            var outsideHexes:[hexNode] = []
            var count = 1
            for p in hexPos{
                let temp = hexNode(imageNamed: "hexagon-2")
                temp.centerHex = centerHex
                temp.name = "hex"+String(count)
                let pos = p
                let val = Int.random(in: 1 ... 9)
                temp.start(g: self, v: val, r: 1, p: pos)
                outsideHexes.append(temp)
                count += 1
            }
            /*
            for p in hexPos2{
                let temp = hexNode(imageNamed: "hexagon-2")
                temp.centerHex = centerHex
                temp.name = "hex"+String(count)
                let pos = p
                let val = Int.random(in: 1 ... 9)
                temp.start(g: self, v: val, r: 1, p: pos)
                outsideHexes.append(temp)
                count += 1
            }
            */
            let gInfo = gameInfo(c: centerHex, d: 1, n: Int.max, l1:outsideHexes, t: 1)
            gInfo.target = Int.random(in: 3 ... 9)
            centerHex.gInfo = gInfo
            generateTargetLabel(GScene: self, t: gInfo.target)
            for hex in outsideHexes{
                hex.gInfo = gInfo
            }
            centerHex.addOutsideHexes(o: outsideHexes)
            centerHex.movementBorder()
        }
        else{
            let string = "lv_"+String(level)
            let asset = NSDataAsset(name: string)
            let string1 = String(data:asset!.data, encoding: String.Encoding.utf8)
            var n = 0
            var turns = 0
            var outsideHexValues:[Int] = []
            var targetValues:[Int] = []
            var centerHexValues:[Int] = []
            var rule = 0
            var count = 0
            var currentNumber = ""
            for i in string1!{
                if i != "\n" && i != " "{
                    currentNumber += String(i)
                }
                if i == "\n" || i == " "{
                    let c = Int(currentNumber)!
                    if count == 0{
                        n = c
                    }
                    else if count == 1{
                        turns = c
                    }
                    else if count == 5{
                        rule = c
                    }
                    else if count == 2{
                        outsideHexValues.append(c)
                    }
                    else if count == 3{
                        targetValues.append(c)
                    }
                    else if count == 4{
                        centerHexValues.append(c)
                    }
                    currentNumber = ""
                    if i == "\n"{
                        count += 1
                    }
                }
            }
            let centerHex = hexNode(imageNamed: "hex-1-0")
            let val = centerHexValues[0]
            let pos = CGPoint(x:self.size.width/2, y:self.size.height/2-300)
            centerHex.start(g:self, v:val, r:0, p:pos)
            var outsideHexes:[hexNode] = []
            count = 1
            for p in hexPos{
                let temp = hexNode(imageNamed: "hexagon-2")
                temp.centerHex = centerHex
                temp.name = "hex"+String(count)
                let pos = p
                let val = outsideHexValues[count-1]
                temp.start(g: self, v: val, r: 1, p: pos)
                outsideHexes.append(temp)
                count += 1
            }
            let gInfo = gameInfo(c: centerHex, d: n, n: turns, l1:outsideHexes, t: targetValues, r:rule)
            centerHex.gInfo = gInfo
            generateTargetLabel(GScene: self, t: gInfo.target)
            for hex in outsideHexes{
                hex.gInfo = gInfo
            }
            centerHex.addOutsideHexes(o: outsideHexes)
            centerHex.movementBorder()
            gInfo.centerHexValues = centerHexValues
            gInfo.targetValues = targetValues
            let turn = self.children[0].children[0] as! SKLabelNode
            turn.text = "TURNS LEFT "+String(gInfo.numberOfTurns)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)
            if nodeITapped.name == "refresh" || nodeITapped.name == "refreshNodeBox"{
                
                let newGame = GameScene2(size:self.size)
                newGame.scaleMode = self.scaleMode
                let transition = SKTransition.fade(withDuration: 0.75)
                
                self.view!.presentScene(newGame, transition: transition)
            }
            
            if nodeITapped.name == "mainMenu" || nodeITapped.name == "mainMenuNodeBox"{
                showMenu(GScene: self)
                
            }
            
            if nodeITapped.name == "resume"{
                removeMenu()
            }
            
            if nodeITapped.name == "howto"{
                self.addChild(rulesPage)
                self.addChild(rulesNotes)
                removeMenu()
            }
            if nodeITapped.name == "rules"{
                rulesPage.removeFromParent()
                rulesNotes.removeFromParent()
                showMenu(GScene: self)
            }
            if nodeITapped.name == "levels"{
                self.addChild(levelsP)
                levelsP.showLevels()
                removeMenu()
            }
            if nodeITapped.name == "freeplay"{
                defaults.set(0, forKey:"currentLevel")
                level = 0
                removeMenu()
                let newGame = GameScene2(size:self.size)
                newGame.scaleMode = self.scaleMode
                let transition = SKTransition.fade(withDuration: 0.75)
                self.view!.presentScene(newGame, transition: transition)
            }
            if nodeITapped.name == "levelsP"{
                levelsP.removeFromParent()
                showMenu(GScene: self)
            }
            if nodeITapped.name?.prefix(6) == "level_"{
                let str = nodeITapped.name
                let start = str!.index(str!.startIndex, offsetBy: 6)
                let end = str!.index(str!.endIndex, offsetBy: 0)
                let range = start..<end
                let myString = str![range]
                
                if Int(myString)! <= highestLevel{
                    defaults.set(Int(myString)!, forKey:"currentLevel")
                    level = Int(myString)!
                    levelsP.removeFromParent()
                    let newGame = GameScene2(size:self.size)
                    newGame.scaleMode = self.scaleMode
                    let transition = SKTransition.fade(withDuration: 0.75)
                    self.view!.presentScene(newGame, transition: transition)
                }
            }
        }
    }
}
