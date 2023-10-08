//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var eggHardness = ["Soft": 3, "Medium": 4, "Hard": 7]
    var eggCounter = 0
    var initialEggCount = 0
    var player: AVAudioPlayer?
    
    @IBOutlet weak var titleLabel: UILabel!
    var timer = Timer()
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func IBSelect(_ sender: UIButton) {
        progressBar.progress = 0.00
        initialEggCount = 0
        titleLabel.text = sender.currentTitle!
        timer.invalidate()
        if sender.currentTitle == nil {
            print("Error")
            return
        }
        if eggHardness[sender.currentTitle!] != nil {
            eggCounter = eggHardness[sender.currentTitle!]!
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        } else {
            print("Error")
        }
    }
    
    @objc func updateCounter() {
        //example functionality
        if initialEggCount < eggCounter {
            print("\(initialEggCount) seconds")
            initialEggCount += 1
            print ("Setting value: ", Float(initialEggCount)/Float(eggCounter))
            progressBar.setProgress(Float(initialEggCount)/Float(eggCounter), animated: true)
        } else {
            titleLabel.text = "Done!"
            playSound()
            timer.invalidate()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
}
