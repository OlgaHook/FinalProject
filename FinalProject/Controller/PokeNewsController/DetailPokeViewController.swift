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
    
    
    @IBOutlet var buttonOutletCollection: [UIButton]!
    
    
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
        
        buttonOutletCollection.forEach { button in
            button.layer.cornerRadius = 10
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1
        }
        
        titleLabelPoke.text = titlePokeString
        contentPokeTextView.text = contentPokeString
        
        newsPokeImageView.image = newsPokeImage
        
        //access AppDelegate
        //as! Appdelegate Class
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    func saveData(){
        do{
            try context?.save()
            basicAlert(title: "Saved", message: "Go to Saved to find your article")
        }catch{
            print(error.localizedDescription)
        }
    }
    

    @IBAction func saveArticleButtonTapped(_ sender: Any) {
        
        // new PokeItem ->  Core data
        let newPokeItem = PokeItems(context: self.context!)
        newPokeItem.newsTitle = titlePokeString
        newPokeItem.newsContent = contentPokeString
        newPokeItem.pokeUrl = weburlPokeString
        
        //save image as Binary data
        guard let imageData: Data = newsPokeImage?.pngData() else {
            return
        }
        if !imageData.isEmpty{
            //lets access
            newPokeItem.pokeImage = imageData
        }
        self.savedPokeItems.append(newPokeItem)
        saveData()
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination:WebPokeViewController = segue.destination as! WebPokeViewController
        destination.urlPokeString = weburlPokeString
    }
}
