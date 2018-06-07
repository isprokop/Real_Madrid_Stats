//
//  Data.swift
//  Real_Madrid_Stats
//
//  Created by Ivan Prokopenko on 07.06.2018.
//  Copyright © 2018 Ivan Prokopenko. All rights reserved.
//

struct Data {
    static let apiKey = "8mhmppntmm6mqcfrhe6xcuhm"
    
    static func statsByPlayerID(playerID: String) -> String {
        return "https://api.sportradar.us/soccer-t3/eu/en/players/\(playerID)/profile.json?api_key=\(Data.apiKey)"
    }
    
    static func getPlayers() -> String {
        return "https://api.sportradar.us/soccer-t3/eu/en/teams/sr:competitor:2829/profile.json?api_key=\(Data.apiKey)"
    }
    
}
