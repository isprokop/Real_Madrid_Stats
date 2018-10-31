//
//  ResultLigaViewController.swift
//  Real_Madrid_Stats
//
//  Created by Ivan Prokopenko on 20.05.2018.
//  Copyright © 2018 Ivan Prokopenko. All rights reserved.
//

import UIKit

class ResultLigaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var teamID:String!
    var chosenSeason:String!
    var tournamentName:String!
    var teamsInTournament:Int = 20
    
    let parameters = ["Pos", "Team", "Points"]
    
    @IBOutlet weak var teamTableView: UITableView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsInTournament
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as! ShowLigaViewCell
        
        cell.teamPositionResultLabel.text = "1"
        cell.teamNameResultLabel.text = "-"
        cell.pointsResultLabel.text = "0"
        cell.selectionStyle = .none
        tableView.rowHeight = 44
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Downloader.sharedInstance.fetchStandings(chosenSeason: chosenSeason, completion: {(standingsData) in
            self.updateUI(standingsData) } )
    }
    
    
    func updateUI(_ statData: StandingsData) {
        let results = [String(statData.rank!), String(statData.name!), String(statData.points!)]
        for item in 0..<results.count {
            let cell = teamTableView.cellForRow(at: IndexPath(item: item, section: 0)) as? ShowLigaViewCell
            cell?.teamPositionResultLabel.text = results[0]
            cell?.teamNameResultLabel.text = results[1]
            cell?.pointsResultLabel.text = results[2]
        }
    }
}
