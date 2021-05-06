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
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var counter : Int = 0
    var timer : Timer = Timer()
    var selectedTime : Int = 0
    var player : AVAudioPlayer?
    
    
    @IBOutlet weak var displayTitle: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        displayTitle.text = hardness
        selectedTime = eggTimes[hardness]!
        counter = 0
        progressBar.alpha = 1.0
        progressBar.progress = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    
    func playAlarm(){
        do{
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try! AVAudioPlayer(contentsOf: url!)
            player!.play()
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    @objc func updateCounter() {
        if counter < selectedTime {
            counter += 1
            let p = Float(counter) / Float(selectedTime)
            progressBar.progress = p
        }else{
            timer.invalidate()
            displayTitle.text = "Done."
            playAlarm()
        }
    }
    

}
