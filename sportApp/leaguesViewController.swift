//
//  leaguesViewController.swift
//  sportApp
//
//  Created by Ali Moustafa on 17/02/2023.
//

import UIKit

class leaguesViewController: UIViewController {
   
    var leagues = ["1","2","2"]

    @IBOutlet weak var leaguesTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaguesTabelView.dataSource = self
    }
    
    
}
  
extension leaguesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

