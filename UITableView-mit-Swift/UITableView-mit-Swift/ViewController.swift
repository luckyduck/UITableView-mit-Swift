//
//  ViewController.swift
//  UITableView-mit-Swift
//
//  Created by Jan Brinkmann on 15/11/15.
//  Copyright © 2015 Jan Brinkmann. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    let rezeptbuch = Rezeptbuch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Neue Rezepte laden...")
        refreshControl.addTarget(self, action: #selector(ViewController.refreshRezepte(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    //
    //
    // datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return rezeptbuch.rezepte.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rezeptbuch.rezepte[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let rezept = rezeptbuch.rezepte[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "rezeptCell") as! RezeptCell
        
        cell.rezeptName.text = rezept.title
        cell.rezeptImage.image = UIImage(named: rezept.bild)
        
        let zutatenCount = rezept.zutaten.count
        cell.rezeptZutaten.text = "\(zutatenCount) Zutaten"
        
        // accessory type
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(80)
    }
    
    //
    //
    // header für sections
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return rezeptbuch.getNameForSection(section)
    }
    
    //
    //
    // delegate / interaktion
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "zutatenAnzeigen", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "zutatenAnzeigen" {
            let indexPath = sender as! IndexPath
            
            let rezept = rezeptbuch.rezepte[indexPath.section][indexPath.row]
        
            let ctrl = segue.destination as! ZutatenController
            ctrl.rezept = rezept
        }
    }
    
    //
    //
    // editactions
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let mailAction = UITableViewRowAction(
            style: .default,
            title: "Mail") {
                (action: UITableViewRowAction, indexPath: IndexPath) -> Void in
                
            let rezept = self.rezeptbuch.rezepte[indexPath.section][indexPath.row]
                
            let composeView = MFMailComposeViewController()
                composeView.mailComposeDelegate = self
                composeView.setToRecipients(["info@codingtutor.de"])
                composeView.setSubject("Es funktioniert!")
                composeView.setMessageBody(
                    "Hi Jan,\nHier ist mein \(rezept.title) Rezept", isHTML: false)
                
                if MFMailComposeViewController.canSendMail() {
                    self.present(composeView, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Oh",
                        message: "Mailversand nicht möglich",
                        preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                    self.present(alert, animated: true, completion: nil)
                }
        }
        
        mailAction.backgroundColor = UIColor.blue
        
        return [mailAction]
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
        tableView.setEditing(false, animated: true)
    }
    
    //
    //
    // Tabellenindex
    
    var indexChars = [String]()
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        for name in rezeptbuch.kategorien {
            let firstChar = String(name.characters.first!)
            
            if !indexChars.contains(firstChar) {
                indexChars.append(firstChar)
            }
        }
        
        return indexChars
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
        return indexChars.index(of: title)!
    }
    
    //
    //
    // Pull to refresh
    
    func refreshRezepte(_ sender: AnyObject) {
        print("Rezepte werden heruntergeladen...")
        refreshControl.endRefreshing()
    }
}

