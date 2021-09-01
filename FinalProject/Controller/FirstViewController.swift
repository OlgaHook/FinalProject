//
//  FirstViewController.swift
//  FinalProject
//
//  Created by olga.krjuckova on 24/08/2021.
//

import UIKit

class FirstViewController: UIViewController {

    
    @IBOutlet var styleButtonOutletCollection: [UIButton]!
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var openSettingsButton: UIButton!
    @IBOutlet weak var goToPokeNewsButton: UIButton!
    
    

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
       
        
        styleButtonOutletCollection.forEach { button  in
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 1
            button.layer.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.7096483451, blue: 0.3958534476, alpha: 1)
            button.layer.borderColor = UIColor.black.cgColor
            
        }
      
        goToPokeNewsButton.layer.cornerRadius = 15
        //goToPokeNewsButton.layer.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6168883878, blue: 0.1608045791, alpha: 1)
      //  goToPokeNewsButton.layer.borderWidth = 1
        //goToPokeNewsButton.layer.borderColor = UIColor.black.cgColor
    }
    
  
    
    @IBAction func openSettingsButtonTapped(_ sender: Any) {
        openSettings()
    }
    
    func openSettings() {
        guard let settingURL = URL(string: UIApplication.openSettingsURLString) else {return}
        if UIApplication.shared.canOpenURL(settingURL){
            UIApplication.shared.open(settingURL, options: [:]) { success in
                print("success :", success)
            }
        }
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        basicAlert(title: "App Info", message: "Using this application You can read Pokemon World News and Find a Day of week")
    }
}
