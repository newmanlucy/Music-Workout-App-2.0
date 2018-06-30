//
//  MakeMusicViewController.swift
//  Music Workout App
//
//  Created by Lucy Newman on 6/11/18.
//  Copyright © 2018 uchicago-cs. All rights reserved.
//

import UIKit
import AVFoundation

class MakeMusicViewController: UIViewController {
   
    @IBOutlet weak var PauseOrPlayButton: UIButton!
    
    @IBOutlet weak var RateLabel: UILabel!
    
    @IBAction func PauseOrPlay(_ sender: Any) {
        self.togglePlay()
    }
    
    @IBAction func ChangeRateSlider(_ sender: UISlider) {
        var rate: Float = 1.0
        if (sender.value > 0) {
            rate = 1 + sender.value
        } else if (sender.value < 0) {
            rate = 1 / (1 - sender.value)
        }
        self.RateLabel.text = String(rate)
        player.rate = rate
    }
    
    var player = AVAudioPlayer()
    var isPlaying = false
    
    override func viewDidLoad() {
        let path = Bundle.main.path(forResource: "franz-liszt-liebestraum-3", ofType: "mp3")
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
        } catch {
            print("error: file not loaded")
        }
        player.prepareToPlay()
        player.enableRate = true
        
        self.togglePlay()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func togglePlay() {
        if (self.isPlaying) {
            player.pause()
            self.PauseOrPlayButton.setTitle("Play", for: .normal)
            
        } else {
            player.play()
            self.PauseOrPlayButton.setTitle("Pause", for: .normal)
        }
        self.isPlaying = !self.isPlaying
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
