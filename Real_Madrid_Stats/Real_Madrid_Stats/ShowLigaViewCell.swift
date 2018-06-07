//
//  ShowLigaViewCell.swift
//  Real_Madrid_Stats
//
//  Created by Ivan Prokopenko on 20.05.2018.
//  Copyright © 2018 Ivan Prokopenko. All rights reserved.
//

import UIKit

class ShowLigaViewCell: UITableViewCell {
    
    @IBOutlet weak var teamPositionLabel: UILabel!
    @IBOutlet weak var teamNameText: UITextField!
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

