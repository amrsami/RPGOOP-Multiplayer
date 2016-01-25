//
//  Player.swift
//  Exercise05
//
//  Created by Amr Sami on 1/25/16.
//  Copyright © 2016 Amr Sami. All rights reserved.
//

import Foundation

class Player {
    
    private var _name: String = "Player"
    private var _attackPwr: Int = 10
    private var _hp: Int = 100
    private var _isTurn: Bool = true
    
    var name: String {
        return _name
    }
    
    var attackPwr: Int {
        return _attackPwr
    }
    
    var hp: Int {
        return _hp
    }
    
    var hpState: String {
        if hp > 0 {
            return "\(hp) HP"
        } else {
            return "0 HP"
        }
    }
    
    var isTurn: Bool {
        get {
            return _isTurn
        }
        
        set {
            if newValue != _isTurn {
                _isTurn = newValue
            }
        }
    }
    
    var isAlive: Bool {
        if hp <= 0 {
            return false
        }

        return true
    }
    
    init (name: String, attackPwr: Int, startingHp: Int) {
        self._name = name
        self._attackPwr = attackPwr
        self._hp = startingHp
    }
    
    func attemptAttack(attackPwr: Int) -> Bool {
        self._hp -= attackPwr
        
        return true
    }

}