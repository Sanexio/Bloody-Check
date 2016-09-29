//
//  DetailController.swift
//  BloodyCheckV1
//
//  Created by CEO Sanexio on 07.07.16.
//  Copyright © 2016 Sanexio. All rights reserved.
//

import UIKit

class DetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var aktuelleLaborkonstellation: Laborwerte?

    // MARK: View Methoden:
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = aktuelleLaborkonstellation!.name
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("einzelwerte")
        
        let laborwert = aktuelleLaborkonstellation!.laborwerte[indexPath.row]
        let name = laborwert["name"]!
        let laborwerte = laborwert["wert"]!
        cell!.textLabel!.text = "\(name) \(laborwerte)"
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if aktuelleLaborkonstellation != nil {
            return aktuelleLaborkonstellation!.laborwerte.count
        }
        
        return 0
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("showInfo", sender: self)
        
    }
    
}
