//
//  WerteController.swift
//  BloodyCheckV2
//
//  Created by CEO Sanexio on 12.07.16.
//  Copyright © 2016 Sanexio. All rights reserved.
//

import UIKit

class WerteController: UITableViewController, UISearchBarDelegate {
    
    var isSearching = false
    
    var laborWert: Laborwerte?
    var werte = [String]()
        
    /*
        {
        didSet {
            self.tableView.reloadData()                 // 2. Möglichkeit der Aktualisierung über einen Property Observer
        }                                               // Vorteil: Code wird nur an dieser Stelle eingefügt
    }                                                   // und nicht überall dort, wo wir Veränderungen an den Daten vornehmen
    
                                                        // !!! Bei der Ausführung kommt es allerdings zu einem schweren Ausnahmefehler!!!
    
    */
    
    var filteredValues = [String]()
    
    @IBOutlet weak var editToggle: UIBarButtonItem!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let finalLaborWert = laborWert {
            self.title = finalLaborWert.title
            self.werte = finalLaborWert.werte
        }

    }


    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filteredValues.count
        }
        
        return werte.count
        
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("laborWertCell", forIndexPath: indexPath)
        
        if isSearching {
            cell.textLabel?.text = filteredValues[indexPath.row]
        } else {
            // Zelle konfigurieren:
            cell.textLabel?.text = werte[indexPath.row]
        }
        
        return cell
    }
    
    @IBAction func editTapped(sender: AnyObject) {
        
        self.editing = !editing             // es wird immer der gegenteilige Zustand hergestellt.
                                            // Kein Editiermodus -> Klick -> Editiermodus (und umgekehrt)
        if self.editing {
            editToggle.title = "Done"
        } else {
            editToggle.title = "Edit"
        }
    }
    
    
    
    // Tabellenzeilen neu ordnen:
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // Reihenfolge im Attribut xyz speichern/verändern -> Core Data!
    }
    
    
    
    // Einträge löschen
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            werte.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    
    
    // Werte hinzufügen:
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "neuerWert" {
            let ctrl = segue.destinationViewController as! SaveController
            ctrl.saveDelegate = {
                (newEntry: String) in
                self.werte.append(newEntry)
                self.navigationController?.popViewControllerAnimated(true)
                
                // Tabelle neu laden (initiale Möglichkeit):
                self.tableView.reloadData()
            }
        }
    }

    
    
    // Searchbar Delegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        isSearching  = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredValues = werte.filter({
            (wert: String) -> Bool in
            
            return wert.containsString(searchText)
            
        })
        
        if filteredValues.count == 0 {
            isSearching = false
        } else {
            isSearching = true
        }
        self.tableView.reloadData()
        
    }
}

