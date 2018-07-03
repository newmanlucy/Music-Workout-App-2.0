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
   
    @IBOutlet weak var tableView: UITableView!
    
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
    var viewModel = ViewModel()
    var song: String

    override func viewDidLoad() {
        let name = "Feeling Happy Summer - The Best Of Vocal Deep House Music Chill Out #109 - Mix By Regard"
        self.setSong(name: name)
        player.prepareToPlay()
        player.enableRate = true
        
        self.loadSongs()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setSong(name: String) {
        let path = Bundle.main.path(forResource: name, ofType: "mp3")
        do {
            try self.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
        } catch {
            print("error: file not loaded")
        }
    }
    
    func loadSongs() {
        let songs = [["name": "Feeling Happy Summer", "fullpath": "Feeling Happy Summer - The Best Of Vocal Deep House Music Chill Out #109 - Mix By Regard"], ["name": "Song 2", "fullname": "song 22222"]]
        let vmitems = songs.map { ViewModelItem(item: Model(title: $0["name"] as! String, data: $0)) }
        self.viewModel.setItems(items: vmitems)
        
        self.tableView?.register(CustomCell.nib, forCellReuseIdentifier: CustomCell.identifier)
        self.tableView?.dataSource = self.viewModel
        self.tableView?.delegate = self.viewModel
        self.tableView?.estimatedRowHeight = 100
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.separatorStyle = .none
    }
    
    func playSong() {
        let choice = viewModel.selectedItems[0].data["fullname"] as! String
        let path = Bundle.main.path(forResource: choice, ofType: "mp3")
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
        } catch {
            print("error: file not loaded")
        }
        self.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func play() {
        player.play()
        self.PauseOrPlayButton.setTitle("Pause", for: .normal)
        self.isPlaying = true
    }
    
    func pause() {
        player.pause()
        self.PauseOrPlayButton.setTitle("Play", for: .normal)
        self.isPlaying = false
    }
    
    func togglePlay() {
        if (self.isPlaying) {
            self.pause()
        } else {
            self.play()
        }
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
