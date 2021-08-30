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
    
    @IBOutlet var styleLabelOutletCollection: [UILabel]!
    @IBOutlet weak var pokeNewsLabel: UILabel!
    @IBOutlet weak var pokeDayFinderLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
       
        
        styleLabelOutletCollection.forEach { label in
            label.layer.cornerRadius = 10
            label.layer.borderWidth = 1
            label.layer.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.7096483451, blue: 0.3958534476, alpha: 1)
            label.layer.borderColor = UIColor.black.cgColor
        }
        
        styleButtonOutletCollection.forEach { button  in
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            
        }
        welcomeLabel.text = "Welcome to final project"
        pokeNewsLabel.text = "Pokemon World News"
        pokeDayFinderLabel.text = "Find a week Day"
        
    }
    

    @IBAction func infoButtonTapped(_ sender: Any) {
        basicAlert(title: "App Info", message: "Using this application You can read Pokemon World News and Find a Day of week")
    }
}
