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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filterZutaten.count
        }
        
        return zutaten.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zutatCell", for: indexPath)

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
    
    @IBAction func editTapped(_ sender: AnyObject) {
        self.isEditing = !isEditing
        
        if self.isEditing {
            editToggle.title = "Done"
        } else {
            editToggle.title = "Edit"
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // ...
        // reihenfolge im attribut 
        // xyz speichern/verändern
        // ...
    }
    
    //
    //
    // einträge löschen
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            zutaten.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath],
                with: .automatic
            )
        }
    }
    
    //
    //
    // zutaten hinzufügen
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "neueZutat" {
            let ctrl = segue.destination as! SaveController
            ctrl.saveDelegate = {
                (newEntry: String) in
                
                self.zutaten.append(newEntry)
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }
    
    //
    //
    // searchbar delegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterZutaten = zutaten.filter({
            (zutat: String) -> Bool in
            
            return zutat.contains(searchText)
        })
        
        if filterZutaten.count == 0 {
            isSearching = false
        } else {
            isSearching = true
        }
        
        self.tableView.reloadData()
    }
}
