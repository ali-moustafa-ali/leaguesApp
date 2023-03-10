//
//  DetailsResponse.swift
//  sportApp
//
//  Created by Ali Moustafa on 17/02/2023.
//

import Foundation

class Results:Decodable{
    var event_date:String?
    var event_time:String?
    var event_home_team:String?
    var home_team_key:Int?//teams
    var event_away_team:String?
    var away_team_key:Int?//teams
    var event_final_result:String?
    var home_team_logo:String?//teams
    var away_team_logo:String?//teams
    var event_home_team_logo:String?//basketball
    var event_first_player_logo:String?//tennis
    var first_player_key: Int?//tennis

}


class DetailsResponse:Decodable{
    
    var success:Int?
    var result:[Results]
}
