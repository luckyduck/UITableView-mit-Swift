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
        let cell = tableView.dequeueReusableCellWithIdentifier("rezeptCell")!
        
        cell.textLabel?.text = rezept.title
        
        return cell
    }
}

