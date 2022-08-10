//
//  hexNode.swift
//  NumberHex
//
//  Created by Samuel Hong on 5/23/22.
//

import Foundation
import SpriteKit


class hexNode:SKSpriteNode{
    
    var value:Int = 0
    var originalPosition:CGPoint?
    var outsideHexes: [hexNode] = []
    let border = UIBezierPath()
    var valueLabel = SKLabelNode(fontNamed: "GillSans-Bold")
    var row:Int?
    var GScene:GameScene2?
    var lock = 0
    var prevHex:String = "hex0"
    var centerHex:hexNode?
    var gInfo:gameInfo?
    
    func start(g:GameScene2, v:Int, r:Int,p:CGPoint){
        self.GScene = g
        self.value = v
        self.row = r
        self.position = p
        self.zPosition = 2
        self.isUserInteractionEnabled = true
        self.GScene!.addChild(self)
        self.originalPosition = self.position
        self.valueLabel.zPosition = 3
        self.valueLabel.position = CGPoint(x:0,y:0)
        self.valueLabel.text = String(v)
        self.valueLabel.fontSize = 100
        self.valueLabel.isUserInteractionEnabled = false
        
        if r == 0{
            self.valueLabel.fontColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
            self.zPosition = 4
            self.valueLabel.zPosition = 5
        }
        else{
            self.valueLabel.fontColor = SKColor.white
            self.isUserInteractionEnabled = false
            self.zPosition = 2
            self.valueLabel.zPosition = 3
        }
        
        self.valueLabel.verticalAlignmentMode = .center
        self.valueLabel.name = "HI"
        self.addChild(self.valueLabel)
    }
    
    func addOutsideHexes(o: [hexNode]){
        self.outsideHexes = o
    }
    
    
    func movementBorder(){
        border.move(to: outsideHexes[1].position)
        border.addLine(to: CGPoint(x:self.originalPosition!.x-75, y:self.originalPosition!.y+129.9))
        border.addLine(to: outsideHexes[0].position)
        border.addLine(to: CGPoint(x:self.originalPosition!.x-150, y:self.originalPosition!.y))
        border.addLine(to: outsideHexes[3].position)
        border.addLine(to: CGPoint(x:self.originalPosition!.x-75, y:self.originalPosition!.y-129.9))
        border.addLine(to: outsideHexes[4].position)
        border.addLine(to: CGPoint(x:self.originalPosition!.x+75, y:self.originalPosition!.y-129.9))
        border.addLine(to: outsideHexes[5].position)
        border.addLine(to: CGPoint(x:self.originalPosition!.x+150, y:self.originalPosition!.y))
        border.addLine(to: outsideHexes[2].position)
        border.addLine(to: CGPoint(x:self.originalPosition!.x+75, y:self.originalPosition!.y+129.9))
        border.addLine(to: outsideHexes[1].position)
    }
    
    func addToHex(add:Int){
        value += add
        valueLabel.text = String(value)
        if gInfo!.rule == 0{
            if(value % gInfo!.target == 0 && value != 0){
                defaults.set(gInfo!.score, forKey:"currentScore")
                let gameOver = GameOverScene(size:GScene!.size)
                gameOver.scaleMode = GScene!.scaleMode
                let transition = SKTransition.fade(withDuration: 0.75)
                GScene!.view!.presentScene(gameOver, transition: transition)
            }
            else if gInfo!.currentTurn+1 == gInfo?.numberOfTurns{
                let gameOver = PassLevel(size:GScene!.size)
                gameOver.scaleMode = GScene!.scaleMode
                let transition = SKTransition.fade(withDuration: 0.75)
                GScene!.view!.presentScene(gameOver, transition: transition)
            }
            else{
                let sLabel = GScene!.children[0].children[0] as! SKLabelNode
                let sLabel2 = GScene!.children[1].children[0] as! SKLabelNode
                gInfo!.score += centerHex!.value
                sLabel.text = "SCORE " + String(gInfo!.score)
                if gInfo!.numberOfTurns < Int.max{
                    sLabel.text = "TURNS LEFT " + String(gInfo!.numberOfTurns-gInfo!.currentTurn-1)
                }
                if(gInfo!.score > highScoreNumber){
                    highScoreNumber = gInfo!.score
                    defaults.set(highScoreNumber, forKey: "highScoreSaved")
                    sLabel2.text = "BEST " + String(highScoreNumber)
                }
            }
        }
        
    }
    func multiplyToHex(mult:Int){
        value *= mult
    }
    func generateNewValue(){
        if gInfo!.numberOfTurns == Int.max{
            var temp: [Int] = []
            let temp2 = [1,2,3,4,5,6,7,8,9]
            for a in temp2{
                for hex in outsideHexes{
                    if(hex.value + a) % gInfo!.target != 0{
                        temp.append(a)
                        break
                    }
                }
            }
            let temp3 = temp.randomElement()
            self.value = temp3!
            self.valueLabel.text = String(temp3!)
        }
        else{
            if gInfo!.currentTurn+1 < gInfo!.numberOfTurns{
                gInfo!.currentTurn += 1
                gInfo!.target = gInfo!.targetValues![gInfo!.currentTurn]
                let temp3 = gInfo!.centerHexValues![gInfo!.currentTurn]
                self.value = temp3
                self.valueLabel.text = String(temp3)
                let sLabel = GScene!.children[14].children[0] as! SKLabelNode
                sLabel.text = String(gInfo!.target)
            }
        }
    }
    
    func findClosestHex(mousePos:CGPoint) -> hexNode{
        var minDis = 100000.0
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
                }
                else{
                    self.position.y = mousePos.y
                    self.position.x = mousePos.x
                }
                self.valueLabel.text = String(self.value)
                for hex in outsideHexes{
                    hex.setScale(1)
                    hex.valueLabel.text = String(hex.value)
                }
                prevHex = "hex7"
            }
            if !border.contains(self.position){
                
                lock = 1
                let closestHex = findClosestHex(mousePos: self.position)
                self.position = closestHex.position
                self.valueLabel.text = ""
                closestHex.valueLabel.text = String(closestHex.value + value)
                closestHex.setScale(1.1)
                for hex in outsideHexes{
                    if hex != closestHex{
                        hex.setScale(1)
                        hex.valueLabel.text = String(hex.value)
                    }
                }
                if closestHex.name! != prevHex{
                    prevHex = closestHex.name!
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        for hex in self.outsideHexes{
            hex.setScale(1)
            let dis = sqrt((self.position.x - hex.position.x)*(self.position.x - hex.position.x) + (self.position.y - hex.position.y)*(self.position.y - hex.position.y))
            if(dis < 5){
                hex.addToHex(add:self.value)
                self.generateNewValue()
            }
        }
        self.valueLabel.text = String(self.value)
        self.position = self.originalPosition!
        lock = 0
        prevHex = "hex0"
    }
}
