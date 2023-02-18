//
//  TeamResponse.swift
//  sportApp
//
//  Created by Ali Moustafa on 18/02/2023.
//

import Foundation

class TeamResult:Decodable{
    var team_name:String?

}


class TeamResponse:Decodable{
    
    var success:Int?
    var result:[TeamResult]
}
