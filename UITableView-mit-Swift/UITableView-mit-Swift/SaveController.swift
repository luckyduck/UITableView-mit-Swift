//
//  SaveController.swift
//  UITableView-mit-Swift
//
//  Created by Jan Brinkmann on 15/11/15.
//  Copyright © 2015 Jan Brinkmann. All rights reserved.
//

import UIKit

class SaveController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var saveDelegate: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        let newEntry = textField.text
        
        if saveDelegate != nil {
            saveDelegate!(newEntry!)
        }
    }
    

}
