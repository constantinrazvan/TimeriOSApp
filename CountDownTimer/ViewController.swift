//
//  ViewController.swift
//  CountDownTimer
//
//  Created by Constantin Razvan on 26.08.2022.
//

import UIKit
import AVFoundation

var audioPlayer: AVAudioPlayer!
class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var userSelection: UISegmentedControl!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var sec = 0
    var min = 0
    var timer = Timer()
    var t = 0
    var secondsRemaining = 60
    var caseI = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Timer"
        
        titleLabel.text = "Choose a time"
        timerLabel.text = "05.00"
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        startButton.setTitle("Start", for: .normal)
        stopButton.setTitle("Stop", for: .normal)
        timer = Timer()
        clearButton.setTitle("Clear", for: .normal)
        
    
    caseI = 5 * secondsRemaining
    
    }
    
    
    @IBAction func segmentSelector(_ sender: UISegmentedControl) {
        
        switch userSelection.selectedSegmentIndex {
        case 0:
            
            caseI = 5 * secondsRemaining
            timerLabel.text = "05:00"
            print("index selected == \(userSelection.selectedSegmentIndex)")
           break
        case 1:
            
            caseI = 15 * secondsRemaining
            timerLabel.text = "15:00"
            print("index selected == \(userSelection.selectedSegmentIndex)")
            
           break
        case 2:
            
            timerLabel.text = "30:00"
            caseI = 30 * secondsRemaining
           
            print("index selected == \(userSelection.selectedSegmentIndex)")
            break
            
       default:
            let ac = UIAlertController(title: "You didn't choose a time", message: "You must choose a time for starting timer", preferredStyle: .actionSheet)
            
            present(ac, animated: true)
        }
    }
    
       /* func updateTimer() {
        seconds -= 1
        timerLabel.text = “\(secondsRemaining)”
    }*/
        @IBAction func startButton(_ sender: UIButton) {
        
    
        timer.invalidate()
        progressBar.progress = 1
        
        secondsRemaining = caseI
        t = secondsRemaining
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        if secondsRemaining <= 1 {
                self.timerLabel?.text="Done"
        }
           
        }
    func playSound() {
        if let sound = NSDataAsset(name: "alarm_sound") {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: Couldn't create the AVAudioPlayer")
            }
        } else {
            print("ERROR: Couldn't load sound file from asset catalog. Verify file is a valid sound file and that the name is correct.")
        }
    }
            

    @objc func updateTimer(){
        if secondsRemaining >=  1 {
            
          //  timerLabel.text = secondsRemaining
           print("\(secondsRemaining) seconds")
            progressBar.progress -= 1 / Float (t)
            secondsRemaining -= 1
            min = secondsRemaining / 60
            sec = secondsRemaining % 60
            print (sec, min)
            timerLabel.text = "\(min) : \(sec)"
            
            if min == 0 && sec == 4{
                playSound()
            }
            
        } else{
            timer.invalidate()
            self.timerLabel?.text="Done"
           
            
            
        }
    
    }
    @IBAction func stopTapped(_ sender: UIButton) {
        print("Stop button tapped")
        timer.invalidate()
        
        secondsRemaining = 60
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        print("Clear button tapped")
        timer.invalidate()
        secondsRemaining = 60
        switch userSelection.selectedSegmentIndex {
        case 0:
            
            
            timerLabel.text = "05:00"
            print("index selected == \(userSelection.selectedSegmentIndex)")
           break
        case 1:
            
            
            timerLabel.text = "15:00"
            print("index selected == \(userSelection.selectedSegmentIndex)")
            
           break
        case 2:
            
            timerLabel.text = "30:00"
            
           
            print("index selected == \(userSelection.selectedSegmentIndex)")
            break
            
       default:
            let ac = UIAlertController(title: "You didn't choose a time", message: "You must choose a time for starting timer", preferredStyle: .actionSheet)
            
            present(ac, animated: true)
        }
    }
    
    
}
