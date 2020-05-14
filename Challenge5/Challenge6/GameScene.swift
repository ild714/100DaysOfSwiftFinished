//
//  GameScene.swift
//  Challenge6
//
//  Created by Ильдар Нигметзянов on 10.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    var aim: SKSpriteNode!
    var monster: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var timer1: Timer!
    var timer2: Timer!
    var timer3: Timer!
    var timeInterval: Double = 1
    var score = 0 {
        didSet{
            scoreLabel.text = "Score \(score)"
        }
    }
    var timeLabelForEnd: SKLabelNode!
    var timeForEndGame = 10 {
        didSet{
            timeLabelForEnd.text = "Time \(timeForEndGame)"
        }
    }
    
    override func didMove(to view: SKView) {
        aim = SKSpriteNode(imageNamed: "Aim")
        aim.position = CGPoint(x: 300, y: 400)
        aim.zPosition = 1
        addChild(aim)
        
        let lake = SKSpriteNode(imageNamed: "Lake")
        lake.position = CGPoint(x: 512, y: 384)
        lake.zPosition = -1
        lake.xScale = 1.2
        lake.yScale = 1.2
        addChild(lake)
        
        
        scoreLabel = SKLabelNode()
        scoreLabel.text = "Score \(score)"
        scoreLabel.position = CGPoint(x: 60, y: 30)
        scoreLabel.zPosition = 1
        addChild(scoreLabel)
        
        timeLabelForEnd = SKLabelNode()
        timeLabelForEnd.text = "Time \(timeForEndGame)"
        timeLabelForEnd.position = CGPoint(x: 912, y: 700)
        timeLabelForEnd.zPosition = 1
        addChild(timeLabelForEnd)
        
        timer1 = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(createMonster), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(remainTime), userInfo: nil, repeats: true)
//        timer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createRestPerson), userInfo: nil, repeats: true)
    }
    
//    @objc func createRestPerson(){
//        let restPerson = SKSpriteNode(imageNamed: "rest")
//        restPerson.zPosition = 1
//        restPerson.position = CGPoint(x: Int.random(in: 100...700), y: Int.random(in: 100...700))
//        addChild(restPerson)
//    }
    
    @objc func remainTime(){
         timeForEndGame -= 1
         timeLabelForEnd.text = "Time \(timeForEndGame)"
        
        if timeForEndGame == 0 {
            timer1.invalidate()
            timer2.invalidate()
//            timer3.invalidate()
            let gameOver = SKLabelNode(fontNamed: "Chalkduster")
            gameOver.text = "Game Over , your score \(score) \n New game"
            gameOver.name = "NewGame"
            gameOver.position = CGPoint(x: 412, y: 384)
            gameOver.zPosition = 1
            for node in children {
                node.removeFromParent()
            }
            addChild(gameOver)
//            self.reloadInputViews()
            
        }
    }
    
    @objc func createMonster(){
        timeInterval *= 0.8
        monster = SKSpriteNode(imageNamed: "danger")
        monster.zPosition = 1
        monster.position = CGPoint(x: Int.random(in: 100...700), y: Int.random(in: 100...700))
        monster.name = "monster"
        addChild(monster)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        aim.position = first.location(in: self)
        
        let node: SKNode = self.atPoint(first.location(in: self))
        if node.name == "monster"{
//            print("hello")
            score += 1
            monsterDissapear(node: node)
        }  else if node.name == "NewGame" {
            let newScene = GameScene(size: self.size)
            newScene.scaleMode = self.scaleMode
            let animation = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(newScene,transition: animation)
        } else {
            score -= 5
        }
    }
    
    func monsterDissapear(node: SKNode){
        node.xScale = 0.8
        node.yScale = 0.8
        
        let scale = SKAction.scale(to: 0.1, duration: 0.5)
        let fade = SKAction.fadeOut(withDuration: 0.5)
        let sequence = SKAction.sequence([scale,fade])
        
        node.run(sequence)
    }
    
    
}
