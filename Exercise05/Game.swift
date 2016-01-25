//
//  Game.swift
//  Exercise05
//
//  Created by Amr Sami on 1/25/16.
//  Copyright © 2016 Amr Sami. All rights reserved.
//

import Foundation

class Game {
    
    private var _gameState: String = ""
    private var player1: Player
    private var Player2: Player
    
    init (player1: Player, player2: Player) {
        self.player1 = player1
        self.Player2 = player2
    }
    
    func attack() {
        
        if player1.isTurn {
            Player2.attemptAttack(player1.attackPwr)
            switchTurns()
        } else {
            player1.attemptAttack(Player2.attackPwr)
            switchTurns()
        }
        
    }
    
    
    func gameState() -> String {
        
        if !player1.isAlive {
            return "\(Player2.name) Win!"
        } else if !Player2.isAlive {
            return "\(player1.name) Win!"
        } else if player1.isTurn {
            return "\(player1.name) Turn"
        } else if Player2.isTurn {
            return "\(Player2.name) Turn"
        } else {
            return ""
        }
        
    }
    
    func switchTurns() {
        if player1.isTurn == true && Player2.isTurn == false {
            
            player1.isTurn = false
            Player2.isTurn = true
            
        } else {
            
            player1.isTurn = true
            Player2.isTurn = false
            
        }
    }
    
}