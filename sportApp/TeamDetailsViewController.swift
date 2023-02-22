//
//  TeamDetailsViewController.swift
//  sportApp
//
//  Created by Ali Moustafa on 18/02/2023.
//

import UIKit
import Alamofire
import CoreData
class TeamDetailsViewController: UIViewController {
    //variable to response data
    @IBOutlet weak var TeamLogo: UIImageView!
    var dataTeam : TeamResponse?
    @IBOutlet weak var teamName: UILabel!
    
    var sportType = ""
    var teamKey = ""
    var Id = ""
    var isFavorite = false
    var favoriteButton :UIButton! = nil
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
//       Ali
        // ...

        favoriteButton = UIButton(type: .system)
        favoriteButton.setTitleColor(.white, for: .normal)
        favoriteButton.layer.cornerRadius = 8
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        view.addSubview(favoriteButton)

        // Set initial state of the button based on whether the player name is favorited or not
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePlayer")
        
        
        
        if self.sportType == "tennis"
        {
            request.predicate = NSPredicate(format: "name == %@", dataTeam?.result[0].player_name ?? "")
        }
        else {
            request.predicate = NSPredicate(format: "name == %@", dataTeam?.result[0].team_name ?? "")
        }
        
        
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                isFavorite = true
                favoriteButton.backgroundColor = .blue
                favoriteButton.setTitle("Remove from favorites", for: .normal)
            } else {
                isFavorite = false
                favoriteButton.backgroundColor = .gray
                favoriteButton.setTitle("Add to favorites", for: .normal)
            }
        } catch {
            print("Error fetching favorite status: \(error)")
        }

        // Position the button using constraints or frames
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        favoriteButton.topAnchor.constraint(equalTo: teamName.bottomAnchor, constant: 16).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        Ali
    }
  //Ali
    @objc func favoriteButtonTapped() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        if isFavorite {
            // Remove the player name from favorites
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePlayer")
            
            
            if self.sportType == "tennis"
            {
                request.predicate = NSPredicate(format: "name == %@", dataTeam?.result[0].player_name ?? "")
            }
            else {
                request.predicate = NSPredicate(format: "name == %@", dataTeam?.result[0].team_name ?? "")

            }
            
            
            request.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(request)
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                }
                try context.save()
                isFavorite = false
            } catch {
                print("Error removing from favorites: \(error)")
            }

            // Update the button appearance
            favoriteButton.backgroundColor = .gray
            favoriteButton.setTitle("Add to favorites", for: .normal)
        } else {
            // Add the player name to favorites
            let entity = NSEntityDescription.entity(forEntityName: "FavoritePlayer", in: context)!
            let favoritePlayer = NSManagedObject(entity: entity, insertInto: context)
            
            
            
            if self.sportType == "tennis"
            {
                favoritePlayer.setValue(dataTeam?.result[0].player_name, forKey: "name")

            }
            else {
                favoritePlayer.setValue(dataTeam?.result[0].team_name, forKey: "name")

            }
            
            
            do {
                try context.save()
                isFavorite = true
            } catch {
                print("Error adding to favorites: \(error)")
            }

            // Update the button appearance
            favoriteButton.backgroundColor = .blue
            favoriteButton.setTitle("Remove from favorites", for: .normal)
        }
    }

    @IBAction func navigayion(_ sender: Any) {
        let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "FavoriteTeam") as! FavoriteTeam
        
        self.navigationController?.pushViewController(storyBoard, animated: true)
    }
    //    Ali
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




