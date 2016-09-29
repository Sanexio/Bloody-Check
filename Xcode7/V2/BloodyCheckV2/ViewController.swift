//
//  ViewController.swift
//  BloodyCheckV2
//
//  Created by CEO Sanexio on 12.07.16.
//  Copyright © 2016 Sanexio. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    let laborbuch = Laborbuch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Neue Werte laden...")
        refreshControl.addTarget(self, action: #selector(ViewController.refreshValues(_:)), forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    
    
    // DATA-SOURCE:
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return laborbuch.laborwerte.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laborbuch.laborwerte[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let wert = laborbuch.laborwerte[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("laborCell") as! LaborwertCell!
        
        // Werte setzen:
        // "cell.textLabel?.text = wert.title" war initial nur ein "Lückenfüller" bis die Klasse
        // LaborwertCell definiert wurde
        
        // Zugriff auf die Eigenschaften der Klasse LaborwertCell:
        
        // Name:
        cell.laborName.text = wert.title
        // Bild:
        cell.laborImage.image = UIImage(named: wert.bild)
        // Werte:
        let laborwerteCount = wert.werte.count
        cell.laborWerte.text = "\(laborwerteCount) Laborwerte"
        
        // accessory type:
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    
    
    // HEADER FÜR SECTIONS:
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return laborbuch.getNameForSection(section)
    }
    
    
    
    // DELEGATE / INTERAKTION:
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("werteAnzeigen", sender: indexPath)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "werteAnzeigen" {
            
            let indexPath = sender as! NSIndexPath
            
            let laborwert = laborbuch.laborwerte[indexPath.section][indexPath.row]
            
            let ctrl = segue.destinationViewController as! WerteController
            ctrl.laborWert = laborwert
        }
        
    }
    
    
    // EDIT-ACTIONS:
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let mailAction = UITableViewRowAction (
            style: .Default,
            title: "Mail") {
                (action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
                
            let werte = self.laborbuch.laborwerte[indexPath.section][indexPath.row]
                
            let composeView = MFMailComposeViewController()
                composeView.mailComposeDelegate = self
                composeView.setToRecipients(["stracke.md@me.com"])
                composeView.setSubject("Labordaten")
                composeView.setMessageBody(
                    "Hier sind meine Werte: \(werte.werte)", isHTML: false)
                
                
                // Testen, ob Mailversand überhaupt möglich ist:
                if MFMailComposeViewController.canSendMail() {
                    // falls ja, wird oben definiertes ComposeView versendet:
                    self.presentViewController(composeView, animated: true, completion: nil)
                } else {
                    // falls nein, wird der UIAlertController aufgerufen:
                    let alert = UIAlertController(title: "Oh",
                                                  message: "Mailversand nicht möglich",
                                                  preferredStyle: .Alert)
                    
                    // das Hinweisfenster kann folgendermaßen wieder geschlossen werden:
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    
                    // Ähnlich wie oben mit der ComposeView kann man hier dann den Alert anzeigen
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        
        mailAction.backgroundColor = UIColor.blueColor()
        return [mailAction]
    }
    
    // Ist die Mail fertiggestellt, kann mit der folgenden Methode der Ausgangszustand wieder hergestellt werden:
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        tableView.setEditing(false, animated: true)
    }
    
    
    
    // Tabellenindex:
    
    var indexChars = [String]()
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        
        for name in laborbuch.kategorien {
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
    
    
    
    // Pull to refresh
    
    func refreshValues(sender: AnyObject) {
        print("Werte werden heruntergeladen....")
        refreshControl.endRefreshing()
    }

}
    