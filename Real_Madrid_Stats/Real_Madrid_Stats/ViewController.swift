//
//  ViewController.swift
//  Real_Madrid_Stats
//
//  Created by Ivan Prokopenko on 06.05.2018.
//  Copyright © 2018 Ivan Prokopenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private var indexSeason = 0
    private var indexPlayer = 0
    
    @IBOutlet weak var textSeasonLigaTable: UITextField!
    @IBOutlet weak var textSeasonPlayerPicker: UITextField!
    
    private var seasonPicker = UIPickerView()
    private var playerPicker = UIPickerView()
    
    @IBOutlet weak var showLaLigaTableButton: UIButton!
    @IBOutlet weak var showPlayerStatsButton: UIButton!
    
    @IBAction func checkTableConnection(_ sender: Any) {
        checkReachability()
    }
    
    @IBAction func checkPlayerConnection(_ sender: Any) {
        checkReachability()
    }
    
    private var teamPlayers = ["Cristiano Ronaldo":"sr:player:750"]
    private var playerAndLigaSeasons = ["2017-2018"]
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Player picker implementation
        playerPicker.dataSource = self
        playerPicker.delegate = self
        textSeasonPlayerPicker.inputView = playerPicker
        textSeasonPlayerPicker.text = "Player"
        textSeasonPlayerPicker.tintColor = .clear
        
        textSeasonPlayerPicker.inputView = playerPicker
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePlayer))
        toolbar.items = [barButton]
        textSeasonPlayerPicker.inputAccessoryView = toolbar
        
        // Season picker implementation
        seasonPicker.dataSource = self
        seasonPicker.delegate = self
        textSeasonLigaTable.inputView = seasonPicker
        textSeasonLigaTable.text = "La Liga Season"
        textSeasonLigaTable.tintColor = .clear
        
        textSeasonLigaTable.inputView = seasonPicker
        let toolbarSeason = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let barButtonSeason = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneSeason))
        toolbarSeason.items = [barButtonSeason]
        textSeasonLigaTable.inputAccessoryView = toolbarSeason
    }
    
    @objc func donePlayer() {
        textSeasonPlayerPicker.resignFirstResponder()
    }
    
    
    @objc func doneSeason() {
        textSeasonLigaTable.resignFirstResponder()
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkReachability() {
        if currentReachabilityStatus == .notReachable {
            let alert = UIAlertController(title: "Sorry, something went wrong", message: "Check Internet connection", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numOfRows = 0
        if pickerView == playerPicker {
            numOfRows = teamPlayers.count
        } else if pickerView == seasonPicker {
            numOfRows = playerAndLigaSeasons.count
        }
        return numOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let names = [String](teamPlayers.keys)
        var titForRow = ""
        if pickerView == playerPicker {
            titForRow = names[row]
        } else if pickerView == seasonPicker {
            titForRow = playerAndLigaSeasons[row]
        }
        return titForRow
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let names = [String](teamPlayers.keys)
        if pickerView == playerPicker {
            indexPlayer = row
            textSeasonPlayerPicker.text = names[indexPlayer]
        } else if pickerView == seasonPicker {
            indexSeason = row
            textSeasonLigaTable.text = playerAndLigaSeasons[indexSeason]
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard currentReachabilityStatus != .notReachable else { return }
        let names = [String](teamPlayers.keys)
        let resultDestination = segue.destination as? ResultPlayerViewController
        resultDestination?.imageName = teamPlayers[names[indexPlayer]]
        if let playerID = teamPlayers[names[indexPlayer]] {
            resultDestination?.playerID = playerID
        }
        let chosenSeason = playerAndLigaSeasons[indexSeason]
        resultDestination?.chosenSeason = chosenSeason
    }
}







