//
//  TeamsCellCollectionViewCell.swift
//  sportApp
//
//  Created by Ali Moustafa on 17/02/2023.
//

import UIKit

class TeamsCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamImage: UIImageView!
    
    func setupCellforteams(photo:UIImage){
        teamImage.image = photo
    }
}
