//
//  sportsCollectionViewCell.swift
//  sportApp
//
//  Created by Ali Moustafa on 17/02/2023.
//

import UIKit

class sportsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sportsName: UILabel!
    @IBOutlet weak var sportsImage: UIImageView!
    
    
    
    func setupCell(photo:UIImage, name:String){
        sportsName.text = name
        sportsImage.image = photo
    }
}
