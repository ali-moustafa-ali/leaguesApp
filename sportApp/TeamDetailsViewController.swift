//
//  TeamDetailsViewController.swift
//  sportApp
//
//  Created by Ali Moustafa on 18/02/2023.
//

import UIKit
import Alamofire
class TeamDetailsViewController: UIViewController {
    //variable to response data
    var dataTeam : TeamResponse?
    @IBOutlet weak var teamName: UILabel!
    var sportType = ""
    var teamKey = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetch data
        fetchData { result in
            DispatchQueue.main.async {
                self.dataTeam = result
                print(self.dataTeam?.result[0].team_name ?? "dd")
                self.teamName.text = self.dataTeam?.result[0].team_name
            }
        }
        //
       
    }
    
    
    
}

//MARK: - fetch the data for teams

extension TeamDetailsViewController{
    func fetchData(compilation: @escaping (TeamResponse?) -> Void)
    {
        
        
        
        let baseURL = "https://apiv2.allsportsapi.com"
        let apiKey = "ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
        let metParam = "Teams&teamId=\(teamKey)"
        let urlString = "\(baseURL)/\(sportType)/?met=\(metParam)&APIkey=\(apiKey)"
        
        
        
        
        AF.request(urlString).response
        { response in
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(TeamResponse.self, from: data)
                    compilation(result)
                }
                catch{
                    compilation(nil)
                }
            } else {
                compilation(nil)
            }
        }
    }
    
    
}
