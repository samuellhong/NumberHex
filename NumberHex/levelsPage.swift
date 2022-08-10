//
//  levelsPage.swift
//  NumberHex
//
//  Created by Samuel Hong on 5/23/22.
//

import Foundation
import SpriteKit


class levelsPage:SKShapeNode{
    
    func showLevels(){
        self.zPosition = 60
        self.fillColor = UIColor(red: 255/255, green: 247/255, blue: 228/255, alpha: 0.9)
    }
    
    func addLevelNodes(){
        var yChange = [0,-200.0,-400.0,-600.0,-800.0,-1000.0,-1200.0,-1400.0,-1600.0, -1800.0]
        for i in yChange.indices{
            yChange[i] *= 0.7
        }
        var xChange = [-400.0,-200.0,0.0,200.0,400.0]
        for i in xChange.indices{
            xChange[i] *= 0.7
        }
        var counter = 1
        let boxSize = 120.0
        for j in yChange{
            for i in xChange{
                let tempLevel = SKShapeNode(rect: CGRect(x: 1536/2 - boxSize/2 + i, y: 2048/2 - boxSize/2 + 770.0 + j, width: boxSize, height: boxSize), cornerRadius: 15)
                tempLevel.zPosition = 61
                if counter < highestLevel{ //BLUE
                    tempLevel.fillColor = UIColor(red: 34/255, green: 106/255, blue: 232/255, alpha: 1)
                }
                else if counter == highestLevel{ //GREEN
                    tempLevel.fillColor = UIColor(red: 119/255, green: 241/255, blue: 136/255, alpha: 1)
                }
                else{ //RED
                    tempLevel.fillColor = UIColor(red: 255/255, green: 124/255, blue: 85/255, alpha: 1)
                }
                tempLevel.name = "level_"+String(counter)
                self.addChild(tempLevel)
                
                let tempLevelLabel = SKLabelNode(fontNamed: "GillSans-SemiBold")
                tempLevelLabel.text = String(counter)
                tempLevelLabel.zPosition = 62
                tempLevelLabel.name = "level_"+String(counter)
                tempLevel.addChild(tempLevelLabel)
                tempLevelLabel.position = CGPoint(x:1538/2 + i,y:2048/2+770 + j)
                tempLevelLabel.verticalAlignmentMode = .center
                tempLevelLabel.fontSize = 65
                counter += 1
            }
        }
    }
}
