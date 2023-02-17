//
//  leaguesTableViewCell.swift
//  sportApp
//
//  Created by Ali Moustafa on 17/02/2023.
//

import UIKit

class leaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var leaguesView: UIView!
    
    @IBOutlet weak var leaguesImage: UIImageView!
    
    @IBOutlet weak var leaguesName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
