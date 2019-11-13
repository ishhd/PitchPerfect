//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Shahad on 14/01/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    
    //for calling buttons
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    //connects between the two view controllers
    var recordedAudioURL:URL!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    //all the buttons
    enum ButtonType: Int {
        case slow = 1, fast, chipmunk, vader, echo, reverb
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        stopAudio()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
    
        configureUI(.notPlaying)
        

    }
    
    
    
    
    
    

}
