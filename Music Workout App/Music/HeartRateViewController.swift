//
//  HeartRateViewController.swift
//  Music Workout App
//
//  Created by Lucy Newman on 7/7/18.
//  Copyright © 2018 uchicago-cs. All rights reserved.
//

import UIKit
import CoreBluetooth

let heartRateServiceCBUUID = CBUUID(string: "0x180D")

class HeartRateViewController: UIViewController, UIPickerViewDataSource,
UIPickerViewDelegate {

    let pickerData = [Array(0...2), Array(0...9), Array(0...9)]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[component][row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didChangePickerSelection()
    }
    
    var centralManager: CBCentralManager!
    
    @IBOutlet weak var heartRatePicker: UIPickerView!
    
    func setUpPicker() {
        heartRatePicker.delegate = self
        heartRatePicker.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPicker()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        // Do any additional setup after loading the view.
    }

    func getHeartRate() -> Int {
        let v1 = pickerData[0][heartRatePicker.selectedRow(inComponent: 0)]
        let v2 = pickerData[1][heartRatePicker.selectedRow(inComponent: 1)]
        let v3 = pickerData[2][heartRatePicker.selectedRow(inComponent: 2)]
        let heartRate = 100 * v1 + 10 * v2 + v3
        return heartRate
    }
    
    func isClose(n1: Int, n2: Int, buffer: Int) -> Bool {
        return abs(n1-n2) < buffer
    }
    
    func adjustTempo1(targetHR: Int, currentHR: Int, buffer: Int, changeInterval: Float) {
        print(g.rate)
        if isClose(n1: targetHR, n2: currentHR, buffer: buffer) {
            return
        }
        if currentHR > targetHR {
            global.setRate(rate: global.rate - changeInterval)
        }
        else {
            global.setRate(rate: global.rate + changeInterval)
        }
    }
    
    func adjustTempo2(targetHR: Int, currentHR: Int, baseTempo: Float) -> Float {
        let difference = Float(targetHR - currentHR)
        return (baseTempo + difference) / baseTempo
    }
    
    func didChangePickerSelection(){
        let heartRate = getHeartRate()
        print(heartRate)
        adjustTempo1(targetHR: 100, currentHR: heartRate, buffer: 5, changeInterval: 0.02)
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

extension HeartRateViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("unknown")
        case .resetting:
            print("resetting")
        case .unsupported:
            print("unsupported")
        case .unauthorized:
            print("unauthorized")
        case .poweredOff:
            print("powered off")
        case .poweredOn:
            print("powered on")
            centralManager.scanForPeripherals(withServices: [heartRateServiceCBUUID])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
    }
    
}
