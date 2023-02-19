//
//  LeaguesResponse.swift
//  sportApp
//
//  Created by Ali Moustafa on 17/02/2023.
//
import Foundation

class Result:Decodable{
    var league_name:String?
    var league_logo:String?
    
}

class LeaguesResponse:Decodable{
    
    var success:Int?
    var result:[Result]
}
