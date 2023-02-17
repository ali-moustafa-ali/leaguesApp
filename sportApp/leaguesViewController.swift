//
//  leaguesViewController.swift
//  sportApp
//
//  Created by Ali Moustafa on 17/02/2023.
//

import UIKit


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
        cell.leaguesImage.image = UIImage(named: "1")
        //make the cell look round
        cell.leaguesView.layer.cornerRadius = cell.contentView.frame.height / 2.5
        //make the image look round
        cell.leaguesImage.layer.cornerRadius = cell.leaguesImage.frame.height / 2.5
        return cell
    }
    
    
    //Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

//fetch the data
extension leaguesViewController{
    
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
}



