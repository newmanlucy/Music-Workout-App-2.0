//
//  global.swift
//  Music-Driven-Workout-App
//
//  Created by Christopher Choy on 2/27/18.
//  Copyright © 2018 UChicago SoftCon. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class Global: UIViewController {
    // !! There should only be one instantiation of this class in LoginViewController.swift !!
    
    /* * Persistent Global variables * */
    var userid: String!                     // set in LoginVC
    var username: String!                   // set in LoginVC
    var player = AVAudioPlayer()
    var isPlaying = Bool()
    var rate: Float = 1.0

    func setRate(rate: Float) {
        print("HERE", isPlaying)
        self.rate = rate
        if (self.isPlaying) {
            self.player.rate = self.rate
            print(self.player.rate)
        }
    }
    
    func setSong(name: String) {
        let path = Bundle.main.path(forResource: name, ofType: "mp3")
        do {
            try self.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
        } catch {
            print("error: file not loaded")
        }
    }
    
    func playSong(choice: String) {
        let path = Bundle.main.path(forResource: choice, ofType: "mp3")
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
        } catch {
            print("error: file not loaded")
        }
        self.player.prepareToPlay()
        self.player.enableRate = true
        self.player.rate = self.rate
        self.play()
    }

    func play() {
        print("PLAY", self.isPlaying)
        player.play()
        self.isPlaying = true
        print(self.isPlaying)
    }
    
    func pause() {
        player.pause()
        self.isPlaying = false
    }
    
    func togglePlay() {
        if (self.isPlaying) {
            self.pause()
        } else {
            self.play()
        }
    }
    
    /* * Global Methods * */
    func reset() {
        self.userid = nil
        self.username = nil
    }
    
    func printAll() {
        print("Global Variables:")
        print("\t userid: \(userid)")
        print("\t username: \(username)")
    }
    
    func alert_error() {
        let alert = UIAlertController(title: "Sorry!", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss Alert", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
