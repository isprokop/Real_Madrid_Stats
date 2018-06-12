//
//  ResultPlayerViewController.swift
//  Real_Madrid_Stats
//
//  Created by Ivan Prokopenko on 20.05.2018.
//  Copyright © 2018 Ivan Prokopenko. All rights reserved.
//

import UIKit

class ResultPlayerViewController: UIViewController {
    
    var imageName:String!
    var playerID:String!
    var chosenSeason:String!
    
    let parameters = ["Matches played", "Goals", "Assists", "Yellow cards", "Red cards"]
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var statTableView: UITableView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var heightValueLabel: UILabel!
    @IBOutlet weak var weightLabelValue: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    
}






