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
    
    
    private var teamPlayers = ["Cristiano Ronaldo":"sr:player:750"]
    private var playerAndLigaSeasons = ["2017-2018"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerPicker.dataSource = self
        playerPicker.delegate = self
        textSeasonPlayerPicker.inputView = playerPicker
        textSeasonPlayerPicker.text = "Player"
        textSeasonPlayerPicker.tintColor = .clear
        
        seasonPicker.dataSource = self
        seasonPicker.delegate = self
        textSeasonLigaTable.inputView = seasonPicker
        textSeasonLigaTable.text = "La Liga Season"
        textSeasonLigaTable.tintColor = .clear
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
}







