//
//  LaunchScreenViewController.swift
//  sportApp
//
//  Created by Ali Moustafa on 17/02/2023.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {
    
    private let animationView = AnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimations()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
               let vc = self.storyboard?.instantiateViewController(identifier: "NavigationController") as! NavigationController
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }
        }
            
    
        
//        UIView.animate(withDuration: 2, animations: {
//            self.setupAnimations(completion: <#() -> ()#>)
//
//        }) { done in
//            let vc = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
//            vc.modalTransitionStyle = .crossDissolve
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true)
//        }
    

    private func setupAnimations(){
       
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.width , height: 400)
        animationView.center = view.center
        //animationView.backgroundColor = .red
        view.addSubview(animationView)
        animationView.animation = Animation.named("36621-sports-app-loading-indicator")
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFit
        animationView.play()

    }


}
