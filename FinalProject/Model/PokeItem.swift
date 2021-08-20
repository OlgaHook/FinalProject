//
//  PokeItem.swift
//  FinalProject
//
//  Created by olga.krjuckova on 20/08/2021.
//

import UIKit
import Gloss

class PokeItem: JSONDecodable {
    
    var pokeDescription: String
    var pokeTitle: String
    var pokeUrl: String
    var pokeUrlToImage: String
    var pokeImage: UIImage?
    
    
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
    
    //restricted area-> visible here only
    private func loadImage() -> UIImage?{
        var returnPokeImage: UIImage?
        
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
