//
//  LeagueDetailsViewController.swift
//  sportApp
//
//  Created by Ali Moustafa on 17/02/2023.
//




import UIKit
import Alamofire

class LeagueDetailsViewController: UIViewController
{
    
    
    //variable to response data
    var dataDetails : DetailsResponse?
//    var arrayOfTeams = [teamss]()
    var sportType = ""
    @IBOutlet weak var TeamsCollection: UICollectionView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        
        TeamsCollection.dataSource = self
        TeamsCollection.delegate = self
//        arrayOfTeams.append(teamss(photo: UIImage(named: "1")!))
//        arrayOfTeams.append(teamss(photo: UIImage(named: "1")!))
//        arrayOfTeams.append(teamss(photo: UIImage(named: "1")!))
//        arrayOfTeams.append(teamss(photo: UIImage(named: "1")!))
//
        //fetch data
        fetchData { result in
            DispatchQueue.main.async {
                self.dataDetails = result
                self.TeamsCollection.reloadData()
            }
        }
        //
        
    }
    
}

//MARK: - DataSource for collection view
extension LeagueDetailsViewController :UICollectionViewDataSource, UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataDetails?.result.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = TeamsCollection.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCellCollectionViewCell
        let team = dataDetails?.result[indexPath.row]
        
        switch sportType {
        case "football":
            let url = URL(string: (team?.home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
            cell.teamImage.kf.setImage(with: url)
        case "basketball":
            let url = URL(string: (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
            cell.teamImage.kf.setImage(with: url)
        case "cricket":
            let url = URL(string: (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
            cell.teamImage.kf.setImage(with: url)
        case "tennis":
            let url = URL(string: (team?.event_first_player_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
            cell.teamImage.kf.setImage(with: url)
        default:
            break
        }
       
        return cell
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
          
            let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
        let team = dataDetails?.result[indexPath.row]
        let homeTeamKey = team?.home_team_key ?? 0
        storyBoard.teamKey = String(homeTeamKey) 
        
        switch sportType {
        case "football":
            storyBoard.sportType = "football"
        case "basketball":
            storyBoard.sportType = "basketball"
        case "cricket":
            storyBoard.sportType = "cricket"
        case "tennis":
            storyBoard.sportType = "tennis"
        default:
            break
        }
        
        
            self.navigationController?.pushViewController(storyBoard, animated: true)
       
    }
    
    
}




//MARK: - fetch the data for teams

extension LeagueDetailsViewController{
    func fetchData(compilation: @escaping (DetailsResponse?) -> Void)
    {
        
        
        
        let baseURL = "https://apiv2.allsportsapi.com"
        let apiKey = "ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
        let metParam = "Fixtures"
        let date = "&from=2022-05-18&to=2022-05-18"
//        let date = "&from=2021-05-18&to=2021-05-18"
        let urlString = "\(baseURL)/\(sportType)/?met=\(metParam)&APIkey=\(apiKey)\(date)"
        
        
        
        AF.request(urlString).response
        { response in
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(DetailsResponse.self, from: data)
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

//struct teamss{
//    let photo:UIImage
//}



