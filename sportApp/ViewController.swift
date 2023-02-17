//
//  ViewController.swift
//  sportApp
//
//  Created by Ali Moustafa on 16/02/2023.
//

import UIKit
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
   
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    var arrayOfSports = [sports]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
        arrayOfSports.append(sports(photo: UIImage(named: "1")!, name: "Football"))
        arrayOfSports.append(sports(photo: UIImage(named: "2")!, name: "BasketBall"))
        arrayOfSports.append(sports(photo: UIImage(named: "3")!, name: "Cricket"))
        arrayOfSports.append(sports(photo: UIImage(named: "4")!, name: "Tennis"))
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayOfSports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: "sports", for: indexPath) as! sportsCollectionViewCell
        let sport = arrayOfSports[indexPath.row]
        cell.setupCell(photo: sport.photo, name: sport.name)
//        cell.backgroundColor = UIColor .red
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.496, height: self.view.frame.height * 0.35)
    }
    
   
    
//    between colomn
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
//    between  row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //between top: , left: , bottom: , right:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 90, left: 1, bottom: 50, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("football")
            let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "leaguesViewController") as! leaguesViewController
            storyBoard.sportType = "football"
            self.navigationController?.pushViewController(storyBoard, animated: true)
        case 1:
            print("basketball")
            let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "leaguesViewController") as! leaguesViewController
            storyBoard.sportType = "basketball"
            self.navigationController?.pushViewController(storyBoard, animated: true)
        case 2:
            print("cricket")
            let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "leaguesViewController") as! leaguesViewController
            storyBoard.sportType = "cricket"
            self.navigationController?.pushViewController(storyBoard, animated: true)
        case 3:
            print("tennis")
            let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "leaguesViewController") as! leaguesViewController
            storyBoard.sportType = "tennis"
            self.navigationController?.pushViewController(storyBoard, animated: true)
        default:
            break
        }
    }
    
    
    
}

struct sports{
    let photo:UIImage
    let name :String
}
