//
//  ViewController.swift
//  Xylophone
//
//  Created by Jesus Ruiz on 21/05/2018.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{

    let url1 = Bundle.main.url(forResource: "note1", withExtension: "wav")
    let url2 = Bundle.main.url(forResource: "note2", withExtension: "wav")
    let url3 = Bundle.main.url(forResource: "note3", withExtension: "wav")
    let url4 = Bundle.main.url(forResource: "note4", withExtension: "wav")
    let url5 = Bundle.main.url(forResource: "note5", withExtension: "wav")
    let url6 = Bundle.main.url(forResource: "note6", withExtension: "wav")
    let url7 = Bundle.main.url(forResource: "note7", withExtension: "wav")
    var singlePlayer : AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func notePressed(_ sender: UIButton) {
    
        switch sender.tag {
        case 1:
            playSound(waveName: url1!)
        case 2:
            playSound(waveName: url2!)
        case 3:
            playSound(waveName: url3!)
        case 4:
            playSound(waveName: url4!)
        case 5:
            playSound(waveName: url5!)
        case 6:
            playSound(waveName: url6!)
        case 7:
            playSound(waveName: url7!)
        default:
            print("default case executed!!")
        }

    }
    
    func playSound(waveName: URL) -> Void {
        do {
            try  singlePlayer = AVAudioPlayer(contentsOf: waveName)
            singlePlayer.prepareToPlay()
            singlePlayer.play()
        } catch {
            print ("Playback Error!!")
        }
    }
}
