//
//  MakeMusicViewController.swift
//  Music Workout App
//
//  Created by Lucy Newman on 6/11/18.
//  Copyright © 2018 uchicago-cs. All rights reserved.
//

import UIKit
import AVFoundation
var global = Global()

class MakeMusicViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var PauseOrPlayButton: UIButton!
    
    @IBOutlet weak var RateLabel: UILabel!
    
    @IBAction func PauseOrPlay(_ sender: Any) {
      
    }
    
    @IBAction func ChangeRateSlider(_ sender: UISlider) {
        var rate: Float = 1.0
        if (sender.value > 0) {
            rate = 1 + sender.value
        } else if (sender.value < 0) {
            rate = 1 / (1 - sender.value)
        }
        self.RateLabel.text = String(rate)
        global.setRate(rate: rate)
    }
    
    var viewModel = ViewModel()
    var song: String = ""

    override func viewDidLoad() {
        
        self.loadSongs()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    func loadSongs() {
        let songs = [
            [
                "name": "Feeling Happy Summer",
                "fullname": "Feeling Happy Summer - The Best Of Vocal Deep House Music Chill Out #109 - Mix By Regard"
            ], [
                "name": "Feeling Happy Summer 2018",
                "fullname": "Feeling Happy Summer 2018 - The Best Of Vocal Deep House Music Chill Out #93 - Mix By Regard"
            ]
        ]
        let vmitems = songs.map { ViewModelItem(item: Model(title: $0["name"]! , data: $0)) }
        self.viewModel.setItems(items: vmitems)
        
        self.tableView?.register(CustomCell.nib, forCellReuseIdentifier: CustomCell.identifier)
        self.tableView?.dataSource = self.viewModel
        self.tableView?.delegate = self.viewModel
        self.tableView?.estimatedRowHeight = 100
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.separatorStyle = .none
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
