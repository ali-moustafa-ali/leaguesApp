//
//  LeaguesResponse.swift
//  sportApp
//
//  Created by Ali Moustafa on 17/02/2023.
//
import Foundation



class Result:Decodable{
    var league_key:Int?
    var league_name:String?
    var country_key:Int?
    var country_name:String?
    var league_logo:String?
    var country_logo: String?
}


class LeaguesResponse:Decodable{
    
    var success:Int?
    var result:[Result]
}
