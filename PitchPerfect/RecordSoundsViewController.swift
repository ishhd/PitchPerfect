//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Shahad on 12/01/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopLabel: UIButton!
    @IBOutlet weak var recordButtonLabel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // unables users to pause before they record
        stopLabel.isEnabled=false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    @IBAction func RecordButton(_ sender: Any) {
        
         // changing the text
         // now they can pause
        abling(string: "Recording in progress",stop: true,record: false)
        
        //AVAudioRecorderDelegate PROTOCOL
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    
    @IBAction func stopRecordingButton(_ sender: Any) {
        // turn it back to its statue
        abling(string: "Tap to record",stop: false,record: true)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("recording was not successful")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func abling(string:String,stop:Bool,record:Bool){
        
        recordingLabel.text=string
        stopLabel.isEnabled=stop
        recordButtonLabel.isEnabled=record
        
    
    }
}

