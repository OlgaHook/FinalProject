//
//  PokeItem.swift
//  FinalProject
//
//  Created by olga.krjuckova on 20/08/2021.
//

//Here are specifis String var, that we gonna get from internet and present on TableView
import UIKit
//Gloss helps to JSON data in easier/faster way (added in Final project ->Swift Packages)
import Gloss

class PokeItem: JSONDecodable {
    
    var pokeDescription: String
    var pokeTitle: String
    var pokeUrl: String
    var pokeUrlToImage: String
    //poke image created to save in CoreData
    var pokeImage: UIImage?
    
    //accesing JSON from GET request, by specific key -> String. Using some keys from Array of articles
    required init?(json: JSON) {
        //if description is not a String, well present ""
        self.pokeDescription = "description" <~~ json ?? ""
        self.pokeTitle = "title" <~~ json ?? ""
        self.pokeUrl = "url" <~~ json ?? ""
        self.pokeUrlToImage = "urlToImage" <~~ json ?? ""
   
        //for image.If we Load and Save the data
        
        DispatchQueue.main.async {
            // func needed.Func in closure-> need self.
            self.pokeImage = self.loadImage()
        }
        
    }
    
    //Image controller,restricted area-> visible here only
    private func loadImage() -> UIImage?{
        var returnPokeImage: UIImage?
        //check if url is valid to get image from url
        guard let url = URL(string: pokeUrlToImage) else {
            return returnPokeImage
        }
        
        if let data = try? Data(contentsOf: url){
            if let pokeImage = UIImage(data: data){
                returnPokeImage = pokeImage
            }
        }
        return returnPokeImage
    }
    
}
