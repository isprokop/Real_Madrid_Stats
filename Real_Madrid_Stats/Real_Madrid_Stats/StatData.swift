//
//  StatData.swift
//  Real_Madrid_Stats
//
//  Created by Ivan Prokopenko on 20.05.2018.
//  Copyright © 2018 Ivan Prokopenko. All rights reserved.
//

struct StatData {
    var height:Int?
    var weight:Int?
    var matchesPlayed:Int?
    var goals:Int?
    var assists:Int?
    var yellowCards:Int?
    var redCards:Int?
}

struct TeamData {
    var pos:Int?
    var team:String?
    var points:Int?
}

struct PlayersData {
    var players = [String:String]()
}

struct YearsData {
    var years = [String:String]()
}

struct StandingsData {
    //var standings = [String:String]()
    var rank:Int?
    var name:String?
    var points:Int?
    
    
}

struct TournamentData {
    let tournament = [String]()
}

struct SeasonData {
    var seasons = [String]()
}
