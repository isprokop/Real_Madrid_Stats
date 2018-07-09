//
//  ResultPlayerViewController.swift
//  Real_Madrid_Stats
//
//  Created by Ivan Prokopenko on 20.05.2018.
//  Copyright © 2018 Ivan Prokopenko. All rights reserved.
//

import UIKit

class ResultPlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var imageName:String!
    var playerID:String!
    var chosenSeason:String!
    var tournamentName:String!
    
    let parameters = ["Matches played", "Goals", "Assists", "Yellow cards", "Red cards"]
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var statTableView: UITableView!
    
    @IBOutlet weak var heightValueLabel: UILabel!
    @IBOutlet weak var weightValueLabel: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parameters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statisticCell", for: indexPath) as! ShowPlayerViewCell
        cell.parameterLabel.text = parameters[indexPath.row]
        cell.resultLabel.text = "0"
        cell.selectionStyle = .none
        tableView.rowHeight = (tableView.frame.maxY - tableView.frame.minY) / CGFloat(parameters.count)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIImage(named: imageName) != nil {
            playerImage.image = UIImage(named: imageName)
        } else { playerImage.image = UIImage(named: "defaultPlayerImage") }
        
        heightValueLabel.text = "0"
        weightValueLabel.text = "0"
        
        Downloader.sharedInstance.fetchData(player: playerID, chosenSeason: chosenSeason, completion: {(statData) in
            self.updateUI(statData) } )
    }
    
    func updateUI(_ statData: StatData) {
        let results = [String(statData.matchesPlayed!), String(statData.goals!), String(statData.assists!), String(statData.yellowCards!), String(statData.redCards!)]
        if statData.height != nil {
            heightValueLabel.text! = String(statData.height!)
        } else { heightValueLabel.text! = "?" }
        if statData.weight != nil {
            weightValueLabel.text! = String(statData.weight!)
        } else { weightValueLabel.text = "?" }
        
        for item in 0..<results.count {
            let cell = statTableView.cellForRow(at: IndexPath(item: item, section: 0)) as? ShowPlayerViewCell
            cell?.resultLabel.text = results[item]
            
        }
        
    }
    
    
    
}






