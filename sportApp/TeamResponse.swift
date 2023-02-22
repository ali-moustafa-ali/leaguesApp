//
//  TeamResponse.swift
//  sportApp
//
//  Created by Ali Moustafa on 18/02/2023.
//

import Foundation

class TeamResponse:Decodable{
    
    var success:Int?
    var result:[TeamResult]
}

class TeamResult:Decodable{
    var team_name:String?//football - basketball - cricket
    var team_logo:String?//football - basketball - cricket
    var player_name:String?//tennis
    var player_logo:String?//tennis
//    var players:[player]
   

}

//class player:Decodable{
//    var player_key: String
//    var player_name: String
//    var player_number: String
//    var player_country: String
//    var player_type: String
//    var player_age: String
//    var player_match_playedy: String
//    var player_goals: String
//    var player_yellow_cards: String
//    var player_red_cards: String
//}







//class TeamResult:Decodable{
//    var team_name:String?
//    var players: [Player]
//    var coaches:[coach]
//}
//class coach:Decodable {
//    var coach_name:String?
//}
//class TeamResponse:Decodable{
//    var success:Int?
//    var result:[TeamResult]
//}
//class Player : Decodable{
//    var player_name: String?
//    var player_number: String?
//    var player_image: String?
//}
