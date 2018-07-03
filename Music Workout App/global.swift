//
//  global.swift
//  Music-Driven-Workout-App
//
//  Created by Christopher Choy on 2/27/18.
//  Copyright © 2018 UChicago SoftCon. All rights reserved.
//

import UIKit
import Foundation

class Global: UIViewController {
    // !! There should only be one instantiation of this class in LoginViewController.swift !!
    
    /* * Persistent Global variables * */
    var userid: String!                     // set in LoginVC
    var username: String!                   // set in LoginVC
    var completedWorkout = false
    
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
