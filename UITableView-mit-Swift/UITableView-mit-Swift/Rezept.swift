//
//  Rezept.swift
//  UITableView-mit-Swift
//
//  Created by Jan Brinkmann on 15/11/15.
//  Copyright © 2015 Jan Brinkmann. All rights reserved.
//

import Foundation

class Rezept {
    var title: String
    var bild: String
    var zutaten: [String]
    
    init(title: String, bild: String, zutaten: [String]) {
        self.title = title
        self.bild = bild
        self.zutaten = zutaten
    }
}