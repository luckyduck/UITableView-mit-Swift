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
        refreshControl.addTarget(self, action: "refreshRezepte:", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
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
    
    //
    //
    // delegate / interaktion
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("zutatenAnzeigen", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "zutatenAnzeigen" {
            let indexPath = sender as! NSIndexPath
            
            let rezept = rezeptbuch.rezepte[indexPath.section][indexPath.row]
        
            let ctrl = segue.destinationViewController as! ZutatenController
            ctrl.rezept = rezept
        }
    }
    
    //
    //
    // editactions
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let mailAction = UITableViewRowAction(
            style: .Default,
            title: "Mail") {
                (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
                
            let rezept = self.rezeptbuch.rezepte[indexPath.section][indexPath.row]
                
            let composeView = MFMailComposeViewController()
                composeView.mailComposeDelegate = self
                composeView.setToRecipients(["info@codingtutor.de"])
                composeView.setSubject("Es funktioniert!")
                composeView.setMessageBody(
                    "Hi Jan,\nHier ist mein \(rezept.title) Rezept", isHTML: false)
                
                if MFMailComposeViewController.canSendMail() {
                    self.presentViewController(composeView, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Oh",
                        message: "Mailversand nicht möglich",
                        preferredStyle: .Alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                
                    self.presentViewController(alert, animated: true, completion: nil)
                }
        }
        
        mailAction.backgroundColor = UIColor.blueColor()
        
        return [mailAction]
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        controller.dismissViewControllerAnimated(true, completion: nil)
        tableView.setEditing(false, animated: true)
    }
    
    //
    //
    // Tabellenindex
    
    var indexChars = [String]()
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        
        for name in rezeptbuch.kategorien {
            let firstChar = String(name.characters.first!)
            
            if !indexChars.contains(firstChar) {
                indexChars.append(firstChar)
            }
        }
        
        return indexChars
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
        return indexChars.indexOf(title)!
    }
    
    //
    //
    // Pull to refresh
    
    func refreshRezepte(sender: AnyObject) {
        print("Rezepte werden heruntergeladen...")
        refreshControl.endRefreshing()
    }
}

