//
//  SaveController.swift
//  BloodyCheckV2
//
//  Created by CEO Sanexio on 13.07.16.
//  Copyright © 2016 Sanexio. All rights reserved.
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
