//
//  leaguesViewController.swift
//  sportApp
//
//  Created by Ali Moustafa on 17/02/2023.
//

import UIKit

class leaguesViewController: UIViewController {
   
    var leagues = ["1","2","2","2","2","2","2","2","2","2","2","2","2","2","2"]

    @IBOutlet weak var leaguesTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaguesTabelView.dataSource = self
        leaguesTabelView.delegate = self
        // no line between cell
        leaguesTabelView.separatorStyle = .none
        leaguesTabelView.showsHorizontalScrollIndicator = false
    }
    
    
}
  
extension leaguesViewController: UITableViewDataSource, UITableViewDelegate{
    //DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = leaguesTabelView.dequeueReusableCell(withIdentifier: "leaguesCell") as! leaguesTableViewCell
        let leagues = leagues[indexPath.row]
        cell.leaguesName.text = leagues
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

