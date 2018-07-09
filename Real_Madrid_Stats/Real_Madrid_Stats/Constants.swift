//
//  Data.swift
//  Real_Madrid_Stats
//
//  Created by Ivan Prokopenko on 07.06.2018.
//  Copyright © 2018 Ivan Prokopenko. All rights reserved.
//

struct Constants {
    static let apiKey = "8mhmppntmm6mqcfrhe6xcuhm"
    
    static let tournamentID = "sr:tournament:8"
    
    static func statsByPlayerID(playerID: String) -> String {
        return "https://api.sportradar.us/soccer-t3/eu/en/players/\(playerID)/profile.json?api_key=\(Constants.apiKey)"
    }
    
    // Get URL for team standings
    static func urlTeamStandings(ID: String) -> String {
        return "https://api.sportradar.us/soccer-t3/eu/en/tournaments/\(ID)/standings.json?api_key=\(Constants.apiKey)"
    }
    
    
    // Get URL for year and seasons ID
    static func urlForYearsAndSeasonIDs() -> String {
        return "https://api.sportradar.us/soccer-t3/eu/en/tournaments/\(tournamentID)/seasons.json?api_key=\(apiKey)"
    }
    
    static func getPlayers() -> String {
        return "https://api.sportradar.us/soccer-t3/eu/en/teams/sr:competitor:2829/profile.json?api_key=\(Constants.apiKey)"
    }
    
    
    
}
