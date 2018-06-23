//
//  WorkoutSettingsViewController.swift
//  Music Workout App
//
//  Created by Marjorie Antohi on 6/18/18.
//  Copyright © 2018 uchicago-cs. All rights reserved.
//

import UIKit

class WorkoutSettingsViewController: UIViewController {

    @IBAction func durationslider(_ sender: UISlider) {
        durationlabel.text = self.getdurationslidertext(slider: sender)
    }
    @IBOutlet weak var durationsliderobject: UISlider!
    @IBOutlet weak var durationlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        durationlabel.text = self.getdurationslidertext(slider: self.durationsliderobject)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getdurationslidertext(slider: UISlider) -> String {
        return "duration: " + String(Int(durationsliderobject.value)) + "min"
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
