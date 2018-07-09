//
//  Downloader.swift
//  Real_Madrid_Stats
//
//  Created by Ivan Prokopenko on 27.06.2018.
//  Copyright © 2018 Ivan Prokopenko. All rights reserved.
//

import Foundation

class Downloader {
    
    static let sharedInstance = Downloader()
    
    func fetchData(player: String, chosenSeason: String, completion: @escaping (_ statData:StatData) -> ()) {
        guard let url = URL(string: Constants.statsByPlayerID(playerID: player)) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject> else { return }
                
                let playerStat = json?["player"] as? Dictionary<String,AnyObject>
                let height = playerStat?["height"] as? Int
                let weight = playerStat?["weight"] as? Int
                
                var arrOfStat = ["matches_played":0, "goals_scored":0, "assists":0, "yellow_cards":0, "red_cards":0] as [String : Any]
                
                guard let allStatistics = json?["statistics"] as? Dictionary<String,AnyObject> else {return}
                let statisticsBySeason = allStatistics["seasons"] as? Array<Dictionary<String, AnyObject>>
                for dict in statisticsBySeason! {
                    guard let teamStat = dict["team"] as? Dictionary<String,AnyObject> else { continue }
                    guard let team = teamStat["name"] as? String else { continue }
                    guard let season = dict["name"] as? String else { continue }
                    
                    if team.contains("Real Madrid") && season == chosenSeason
                    {
                        arrOfStat = (dict["statistics"] as? Dictionary<String,AnyObject>)!
                    }
                }
                
                let matchesPlayed = arrOfStat["matches_played"] as? Int
                let goals = arrOfStat["goals_scored"] as? Int
                let assists = arrOfStat["assists"] as? Int
                let yellowCards = arrOfStat["yellow_cards"] as? Int
                let redCards = arrOfStat["red_cards"] as? Int
                
                DispatchQueue.main.async {
                    completion(StatData(height: height, weight: weight, matchesPlayed: matchesPlayed, goals: goals, assists: assists, yellowCards: yellowCards, redCards: redCards))
                }
                
            }
        }
        dataTask.resume()
    }
    
    //Fetch PLayers. DONE
    func fetchPlayers(completion: @escaping (_ playersData:PlayersData) -> ()) {
        guard let url = URL(string: Constants.getPlayers()) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject> else { return }
                
                let players = json?["players"] as? Array<Dictionary<String, AnyObject>>
                
                var playersNames = [:] as [String:String]
                
                for dict in players! {
                    guard var name = dict["name"] as? String else { continue }
                    name = self.getNormalName(name: name)
                    
                    guard let id = dict["id"] as? String else { continue }
                    playersNames[name] = id
                }
                
                DispatchQueue.main.async {
                    completion(PlayersData(players: playersNames))
                }
                
            }
        }
        dataTask.resume()
    }
    
    func getNormalName(name: String) -> String {
        _ = name.components(separatedBy: ",")
        var normalName = name
        normalName = normalName.replacingOccurrences(of: ",", with: "")
        return normalName
    }
    
    // Fetch Years and Seasons. DONE
    func fetchYears(completion: @escaping (_ yearsData:YearsData) -> ()) {
        guard let url = URL(string: Constants.urlForYearsAndSeasonIDs()) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject> else { return }
                
                let years = json?["seasons"] as? Array<Dictionary<String, AnyObject>>
                
                var yearsNames = [:] as [String:String]
                
                for dict in years! {
                    guard let name = dict["name"] as? String else { continue }
                    guard let id = dict["id"] as? String else { continue }
                    yearsNames[id] = name
                }
                
                DispatchQueue.main.async {
                    completion(YearsData(years: yearsNames))
                }
                
            }
        }
        dataTask.resume()
    }
    
    
    
    
    
    // Fetch Standings TO DO!!!!
    
    func fetchStandings(chosenSeason: String, completion: @escaping (_ standingsData:StandingsData) -> ()) {
        guard let url = URL(string: Constants.urlTeamStandings(ID: chosenSeason)) else {return}
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject> else { return }
                
                var arrOfStat = ["rank":0, "name":"0", "points":0] as [String : Any]
                
                guard let allStatistics = json?["standings"] as? Array<Dictionary<String,AnyObject>> else {return}
                guard let allTypes = allStatistics[0] as? Dictionary<String,AnyObject> else {return}
                guard let allGroups = allTypes["groups"] as? Array<Dictionary<String,AnyObject>> else {return}
                guard let allTeamStandigs = allGroups[0] as? Dictionary<String,AnyObject> else {return}
                guard let allTeamStand = allTeamStandigs["team_standings"] as? Array<Dictionary<String,AnyObject>> else {return}
                for dict in allTeamStand {
                    guard let rank = dict["rank"] as? Int else {continue}
                    guard let points = dict["points"] as? Int else {continue}
                    guard let nameDict = dict["team"] as? Dictionary<String,AnyObject> else {continue}
                    guard let name = nameDict["name"] as? String else {continue}
                    
                    //записать полученные в цикле данные
                    
                    
                    arrOfStat = (dict["team_standings"] as? Dictionary<String,AnyObject>)!
                    
                    let finalRank = arrOfStat["rank"] as? Int
                    let finalName = arrOfStat["name"] as? String
                    let finalPoints = arrOfStat["points"] as? Int
                    
                
                    DispatchQueue.main.async {
                        completion(StandingsData(rank: finalRank, name: finalName, points: finalPoints))
                    }
                }
            }
            }
        dataTask.resume()
    }
}

