//
//  DetailPokeViewController.swift
//  FinalProject
//
//  Created by olga.krjuckova on 22/08/2021.
//

import UIKit
//here we gonna save data , so
import CoreData

class DetailPokeViewController: UIViewController {
    
    //saved Poke items of previously assigned PokeItemS in ENTITY Class
    var savedPokeItems = [PokeItems]()
    //created to help acces AppDelegate
    var context: NSManagedObjectContext?
    //prepare var for passing to VC
    //read full article->weburlPokeString
    var weburlPokeString = String()
    var titlePokeString = String()
    var contentPokeString = String()
    //image -> type of IUimage
    var newsPokeImage: UIImage?
    
    @IBOutlet weak var titleLabelPoke: UILabel!
    @IBOutlet weak var newsPokeImageView: UIImageView!
    @IBOutlet weak var contentPokeTextView: UITextView!
    
    @IBOutlet weak var getFullArticleButton: UIButton!
    @IBOutlet weak var saveArticleButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabelPoke.text = titlePokeString
        contentPokeTextView.text = contentPokeString
        
        newsPokeImageView.image = newsPokeImage
        
        //access AppDelegate
        //as! Appdelegate Class
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    //already have seg.
   
    
    @IBAction func saveArticleButtonTapped(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination:WebPokeViewController = segue.destination as! WebPokeViewController
        destination.urlPokeString = weburlPokeString
    }
}
