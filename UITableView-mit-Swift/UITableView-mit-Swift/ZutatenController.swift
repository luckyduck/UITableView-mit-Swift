//
//  ZutatenController.swift
//  UITableView-mit-Swift
//
//  Created by Jan Brinkmann on 15/11/15.
//  Copyright © 2015 Jan Brinkmann. All rights reserved.
//

import UIKit

class ZutatenController: UITableViewController, UISearchBarDelegate {

    var isSearching = false
    
    var rezept: Rezept?
    var zutaten = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var filterZutaten = [String]()
    
    @IBOutlet weak var searchBar: UISearchBar!
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
        
        if isSearching {
            return filterZutaten.count
        }
        
        return zutaten.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("zutatCell", forIndexPath: indexPath)

        if isSearching {
            cell.textLabel?.text = filterZutaten[indexPath.row]
        } else {
            cell.textLabel?.text = zutaten[indexPath.row]
        }
        
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
    
    //
    //
    // searchbar delegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        isSearching = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        isSearching = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        isSearching = false;
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        isSearching = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterZutaten = zutaten.filter({
            (zutat: String) -> Bool in
            
            return zutat.containsString(searchText)
        })
        
        if filterZutaten.count == 0 {
            isSearching = false
        } else {
            isSearching = true
        }
        
        self.tableView.reloadData()
    }
}
