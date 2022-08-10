//
//  gameInfo.swift
//  NumberHex
//
//  Created by Samuel Hong on 5/23/22.
//

import Foundation
//test2
let hexesPerRow = [1,6,12]
class gameInfo{
    
    var dimensionality:Int = 1
    var currentTurn:Int = 0
    var numberOfTurns:Int = Int.max
    var centerHex:hexNode?
    var outsideHexes:[hexNode]?
    var targetValues:[Int]?
    var centerHexValues:[Int]?
    var score = 0
    var target:Int=2
    
    //rule values:
    //Divisible = 0
    //Addition = 1
    //Multiplication = 2
    
    var rule = 0
    
    init(c: hexNode, d: Int = 1, n:Int = Int.max, l1: [hexNode], t:Int, r:Int = 0){
        
        self.centerHex = c
        self.dimensionality = d
        self.numberOfTurns = n
        self.outsideHexes = l1
        self.target = t
        self.rule = r
    }
    init(c: hexNode, d: Int = 1, n:Int, l1: [hexNode], t:[Int], r:Int = 0){
        self.target = t[currentTurn]
        self.centerHex = c
        self.dimensionality = d
        self.numberOfTurns = n
        self.outsideHexes = l1
        self.targetValues = t
        self.rule = r
    }
}
