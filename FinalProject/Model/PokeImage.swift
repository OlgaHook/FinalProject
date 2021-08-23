//
//  PokeImage.swift
//  FinalProject
//
//  Created by olga.krjuckova on 23/08/2021.
//

import Foundation

class PokeImageModel{
    
    
    var condition: String = " "
    var day: String = ""
    var pokeIconName: String = ""
    
    func updatePokeIcon(condition: String) -> String {
        switch (condition) {
        case "Monday" :
            return "Braviary"
        case "Tuesday" :
            return "Decidueye"
        case "Wednesday" :
            return "Empoleon"
        case "Thursday" :
            return "Ho-oH"
        case "Friday" :
            return "Prinplup"
        case "Saturday" :
            return "Rowlet"
        case "Sunday" :
            return "Torchic"
        
        default :
            return ""
        }
    }
    
}
