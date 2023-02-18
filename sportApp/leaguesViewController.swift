//
//  leaguesViewController.swift
//  sportApp
//
//  Created by Ali Moustafa on 17/02/2023.
//

import UIKit
import Alamofire
import Kingfisher
class leaguesViewController: UIViewController
{
    //variable to response data
    var data : LeaguesResponse?
    var sportType = ""
    @IBOutlet weak var leaguesTabelView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        leaguesTabelView.dataSource = self
        leaguesTabelView.delegate = self
        // no line between cell
        leaguesTabelView.separatorStyle = .none
        leaguesTabelView.showsHorizontalScrollIndicator = false
        
        
        
        //fetch data
        fetchData { result in
            DispatchQueue.main.async {
                self.data = result
                self.leaguesTabelView.reloadData()
            }
        }
        //
        
    }
    
    
    
}


extension leaguesViewController: UITableViewDataSource, UITableViewDelegate{
    //DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = leaguesTabelView.dequeueReusableCell(withIdentifier: "leaguesCell") as! leaguesTableViewCell
        let leagues =  data?.result[indexPath.row]
        cell.leaguesName.text = leagues?.league_name
        //MARK: - predicate
        let string = leagues?.league_logo
        let predicate = NSPredicate(format:"SELF ENDSWITH[c] %@", ".png")
        let result = predicate.evaluate(with: string)
        //        print(result) // true
        
        //MARK: - kingfisher
        if result{
            let url = URL(string: (leagues?.league_logo)!)
            cell.leaguesImage.kf.setImage(with: url)
            
        }else
        {
            
            switch sportType {
            case "football":
                cell.leaguesImage.image = UIImage(named: "1")
            case "basketball":
                cell.leaguesImage.image = UIImage(named: "2")
            case "cricket":
                cell.leaguesImage.image = UIImage(named: "3")
            case "tennis":
                cell.leaguesImage.image = UIImage(named: "4")
            default:
                break
            }
            
            
        }
        
        //MARK: - make the cell look round
        cell.leaguesView.layer.cornerRadius = cell.contentView.frame.height / 2.5
        //make the image look round
        cell.leaguesImage.layer.cornerRadius = cell.leaguesImage.frame.height / 2.5
        return cell
    }
    
    
    //Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // This method is called when a row is selected in the table view
        
        let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        
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
//fetch the data
extension leaguesViewController{
    //MARK: - Alamofire
    func fetchData(compilation: @escaping (LeaguesResponse?) -> Void)
    {
        
        let baseURL = "https://apiv2.allsportsapi.com"
        let apiKey = "ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
        let metParam = "Leagues"
        let urlString = "\(baseURL)/\(sportType)/?met=\(metParam)&APIkey=\(apiKey)"
        
        
        AF.request(urlString).response
        { response in
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(LeaguesResponse.self, from: data)
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
    
    //MARK: - URLSession
    /*
     func fetchData(compilation:@escaping (LeaguesResponse?)->Void){
     
     let baseURL = "https://apiv2.allsportsapi.com"
     let apiKey = "ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
     let metParam = "Leagues"
     let urlString = "\(baseURL)/\(sportType)/?met=\(metParam)&APIkey=\(apiKey)"
     
     
     
     guard let url = URL(string: urlString) else {
     print("Invalid URL")
     return
     }
     
     
     //        URLSession
     let req = URLRequest(url: url)
     let session = URLSession(configuration: URLSessionConfiguration.default)
     let task =  session.dataTask(with: req) { Data, URLResponse, Error in
     
     //code
     
     do{
     let result = try JSONDecoder().decode(LeaguesResponse.self, from: Data!)
     
     
     compilation(result)
     }
     catch{
     compilation(nil)
     }
     
     }
     
     task.resume()
     }
     */
    
    
}



