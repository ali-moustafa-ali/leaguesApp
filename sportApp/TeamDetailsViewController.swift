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
    @IBOutlet weak var TeamLogo: UIImageView!
    var dataTeam : TeamResponse?
    @IBOutlet weak var teamName: UILabel!
    var sportType = ""
    var teamKey = ""
    var Id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TeamLogo.backgroundColor = .cyan
        TeamLogo.layer.masksToBounds = true
        TeamLogo.layer.cornerRadius = TeamLogo.frame.height / 1.9
        
        
        //fetch data
        fetchData { result in
            DispatchQueue.main.async {
                self.dataTeam = result
                
                if self.sportType == "tennis"
                {
                    self.teamName.text = self.dataTeam?.result[0].player_name
                    
                    
                    let url = URL(string: (self.dataTeam?.result[0].player_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                    self.TeamLogo.kf.setImage(with: url)
                    
                    
                    
                    print(self.dataTeam?.result[0].player_name ?? "dd")
                }
                else {
                    self.teamName.text = self.dataTeam?.result[0].team_name
                    
                    let url = URL(string: (self.dataTeam?.result[0].team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                    self.TeamLogo.kf.setImage(with: url)
                    
                    print(self.dataTeam?.result[0].team_name ?? "dd")
                }

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
        let metParam = "\(Id)\(teamKey)"
        let urlString = "\(baseURL)/\(sportType)/?met=\(metParam)&APIkey=\(apiKey)"
        
        print(urlString)
        
        
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
