//
//  Athlete.swift
//  FavoriteAthlete
//
//  Created by Jestin Dorius on 3/5/25.
//
struct Athlete {
    var name: String
    var age: Int
    var league: String
    var team: String
    
    var description: String {
        return "\(name) is \(age) years old, and plays for the \(team) in the \(league) league."
    }
}
