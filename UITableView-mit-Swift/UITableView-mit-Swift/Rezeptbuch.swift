//
//  Rezeptbuch.swift
//  UITableView-mit-Swift
//
//  Created by Jan Brinkmann on 15/11/15.
//  Copyright © 2015 Jan Brinkmann. All rights reserved.
//

import Foundation

class Rezeptbuch {
    let kategorien = ["Frühstück", "Mittag"]
    var rezepte: [[Rezept]]
    
    init() {
        rezepte = [[Rezept]]()
        
        // frühstück
        rezepte.append([Rezept]())
        rezepte[0].append(Rezept(
            title: "Rührei",
            bild: "scrambledeggs",
            zutaten: ["Eier", "Muskatnuss", "Salz"])
        )
        
        rezepte[0].append(Rezept(
            title: "Pancakes",
            bild: "pancakes",
            zutaten: [
                "2 Eier", "1 Scoop Proteinpulver", "1/2 TL Backpulver",
                "Prise Salz", "1 EL Magerquark", "1/2 TL Zimt"
            ]
        ))
        
        // mittag
        rezepte.append([Rezept]())
        rezepte[1].append(Rezept(
            title: "Nudeln mit Tomatensoße",
            bild: "pasta",
            zutaten: [
                "Nudeln nach Wahl", "passierte Tomaten", "Knoblauch",
                "Prise Salz", "Olivenöl", "Gewürze"
            ]
        ))
        
        rezepte[1].append(Rezept(
            title: "Tofu Salat",
            bild: "salat",
            zutaten: [
                "Tofu", "Kurkuma", "Beliebiger Salat",
                "Essig", "Speiseöl", "Gewürze"
            ]
        ))
    }
    
    func getNameForSection(section: Int) -> String {
        return kategorien[section]
    }
}



/*
Image credits:

1) pasta
https://www.flickr.com/photos/nebulux/7148182009
by Luca Nebuloni
License: CC Atribution 2.0 Generic
https://creativecommons.org/licenses/by/2.0/

2) pancakes
https://www.flickr.com/photos/59247791@N08/5505408276/
by rob_rob2001
License: CC Attribution-ShareAlike 2.0 Generic
https://creativecommons.org/licenses/by-sa/2.0/

3) scrambledeggs
https://www.flickr.com/photos/stevendepolo/4298287138
by Steven Depolo
License: CC Atribution 2.0 Generic
https://creativecommons.org/licenses/by/2.0/

4) salat
https://www.flickr.com/photos/maltehempel_de/18937812818
by Malte Hempel
License: CC Attribution-ShareAlike 2.0 Generic
https://creativecommons.org/licenses/by-sa/2.0/
*/
