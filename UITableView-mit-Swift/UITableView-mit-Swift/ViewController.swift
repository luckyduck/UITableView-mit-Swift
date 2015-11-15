//
//  ViewController.swift
//  UITableView-mit-Swift
//
//  Created by Jan Brinkmann on 15/11/15.
//  Copyright © 2015 Jan Brinkmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let rezeptbuch = Rezeptbuch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //
    //
    // datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return rezeptbuch.rezepte.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rezeptbuch.rezepte[section].count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let rezept = rezeptbuch.rezepte[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("rezeptCell") as! RezeptCell
        
        cell.rezeptName.text = rezept.title
        cell.rezeptImage.image = UIImage(named: rezept.bild)
        
        let zutatenCount = rezept.zutaten.count
        cell.rezeptZutaten.text = "\(zutatenCount) Zutaten"
        
        // accessory type
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return CGFloat(80)
    }
    
    //
    //
    // header für sections
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return rezeptbuch.getNameForSection(section)
    }
}

