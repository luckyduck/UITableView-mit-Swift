//
//  ZutatenController.swift
//  UITableView-mit-Swift
//
//  Created by Jan Brinkmann on 15/11/15.
//  Copyright © 2015 Jan Brinkmann. All rights reserved.
//

import UIKit

class ZutatenController: UITableViewController {

    var rezept: Rezept?
    var zutaten = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var editToggle: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let finalRezept = rezept {
            self.title = finalRezept.title
            self.zutaten = finalRezept.zutaten
        }
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return zutaten.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("zutatCell", forIndexPath: indexPath)

        cell.textLabel?.text = zutaten[indexPath.row]
        
        return cell
    }

    //
    //
    // Tabellenzeilen neu ordnen
    
    @IBAction func editTapped(sender: AnyObject) {
        self.editing = !editing
        
        if self.editing {
            editToggle.title = "Done"
        } else {
            editToggle.title = "Edit"
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        // ...
        // reihenfolge im attribut 
        // xyz speichern/verändern
        // ...
    }
    
    //
    //
    // einträge löschen
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            zutaten.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath],
                withRowAnimation: .Automatic
            )
        }
    }
    
    //
    //
    // zutaten hinzufügen
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "neueZutat" {
            let ctrl = segue.destinationViewController as! SaveController
            ctrl.saveDelegate = {
                (newEntry: String) in
                
                self.zutaten.append(newEntry)
                self.navigationController?.popViewControllerAnimated(true)
                
            }
        }
    }
}
