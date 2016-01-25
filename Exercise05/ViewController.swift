//
//  ViewController.swift
//  Exercise05
//
//  Created by Amr Sami on 1/25/16.
//  Copyright © 2016 Amr Sami. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var enemyImg: UIImageView!
    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var printLbl: UILabel!
    @IBOutlet weak var playerAttackBtn: UIButton!
    @IBOutlet weak var playerAttackLbl: UILabel!
    @IBOutlet weak var playerHpLbl: UILabel!

    @IBOutlet weak var enemyAttackBtn: UIButton!
    @IBOutlet weak var enemyAttackLbl: UILabel!
    @IBOutlet weak var enemyHpLbl: UILabel!
    
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var restartLbl: UILabel!
    

    var orc = Player(name: "Orc", attackPwr: 30, startingHp: 90)
    var soldier = Player(name: "Soldier", attackPwr: 20, startingHp: 100)
    var game: Game!
    
    var bgSound = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("8-Bit", ofType: "mp3")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try bgSound = AVAudioPlayer(contentsOfURL: soundUrl)
            bgSound.prepareToPlay()
        } catch let err as NSError {
            print (err.debugDescription)
        }
        
        bgSound.play()
        
        game = Game(player1: soldier, player2: orc)
        firstTurn()
        attackBtnDisable()
        printLbl.text = game.gameState()
        
    }

    @IBAction func enemyAttackTapped(sender: AnyObject) {
        attack()
    }
    
    @IBAction func playerAttackTapped(sender: AnyObject) {
        attack()
    }
    
    @IBAction func onRestartPressed(sender: AnyObject) {
        restartGame()
    }
    
    func attack() {
        if !gameOver() {
            game.attack()
            attackBtnDisable()
            //NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "attackBtnEnable", userInfo: nil, repeats: false)
            printLbl.text = game.gameState()
            displayPlayersHp()
        }
        gameOver()
        
    }
    
    func attackBtnEnable() {
        playerAttackBtn.enabled = true
        enemyAttackBtn.enabled = true
    }
    
    func attackBtnDisable() {
        if soldier.isTurn {
            playerAttackBtn.enabled = true
            enemyAttackBtn.enabled = false
        } else {
            playerAttackBtn.enabled = false
            enemyAttackBtn.enabled = true
        }
    }
    
    func displayPlayersHp() {
        enemyHpLbl.text = orc.hpState
        playerHpLbl.text = soldier.hpState
    }
    
    func gameOver() -> Bool {
        if !soldier.isAlive || !orc.isAlive {
            printLbl.text = game.gameState()
            restartBtn.hidden = false
            restartLbl.hidden = false
            playerAttackBtn.enabled = false
            enemyAttackBtn.enabled = false
            return true
        }
        return false
    }
    
    func restartGame() {
        orc = Player(name: "Orc", attackPwr: 30, startingHp: 90)
        soldier = Player(name: "Soldier", attackPwr: 20, startingHp: 100)
        game = Game(player1: soldier, player2: orc)
        firstTurn()
        printLbl.text = game.gameState()
        attackBtnDisable()
        displayPlayersHp()
        restartLbl.hidden = true
        restartBtn.hidden = true
        if bgSound.playing {
            bgSound.stop()
        }
        bgSound.play()
    }
    
    func firstTurn() {
        var turns = [true, false]
        soldier.isTurn = turns[Int(arc4random_uniform(2))]
        orc.isTurn = !soldier.isTurn
    }
    
    
}

