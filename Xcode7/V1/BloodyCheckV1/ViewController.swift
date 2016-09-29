//
//  ViewController.swift
//  BloodyCheckV1
//
//  Created by CEO Sanexio on 07.07.16.
//  Copyright © 2016 Sanexio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tableData = [Laborwerte]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let kleinesBlutbild = Laborwerte(laborwertName: "Kleines Blutbild", dieLaborwerte: [
                ["name": "Leukozyten:     ", "wert": "Wert_Leukos"],
                ["name": "Erythrozyten:   ", "wert": "Wert_Erys"],
                ["name": "Hämoglobin:     ", "wert": "Wert_Hb"],
                ["name": "Hämatokrit:     ", "wert": "Wert_Hkt"],
                ["name": "MCV:            ", "wert": "Wert_MCV"],
                ["name": "MCH:            ", "wert": "Wert_MCH"],
                ["name": "MCHC:           ", "wert": "Wert-MCHC"],
                ["name": "Thrombozyten:   ", "wert": "Wert_Thrombos"],
                ["name": "Neutrophile:    ", "wert": "Wert_Neutros"],
                ["name": "Lymphocyten:    ", "wert": "Wert_Lymphos"],
                ["name": "Monocyten:      ", "wert": "Wert_Monos"],
                ["name": "Eosinophile:    ", "wert": "Wert_Eos"],
                ["name": "Basophile:      ", "wert": "Wert_Basos"],
                ["name": "Retikulozyten:  ", "wert": "Wert_Retis"]
            ])
        
        tableData.append(kleinesBlutbild)
        
        let großesBlutbild = Laborwerte(laborwertName: "Großes Blutbild", dieLaborwerte: [
                ["name": "Leukozyten:     ", "wert": "Wert_Leukos"],
                ["name": "Erythrozyten:   ", "wert": "Wert_Erys"],
                ["name": "Hämoglobin:     ", "wert": "Wert_Hb"],
                ["name": "Hämatokrit:     ", "wert": "Wert_Hkt"],
                ["name": "MCV:            ", "wert": "Wert_MCV"],
                ["name": "MCH:            ", "wert": "Wert_MCH"],
                ["name": "MCHC:           ", "wert": "Wert-MCHC"],
                ["name": "Thrombozyten:   ", "wert": "Wert_Thrombos"],
                ["name": "Neutrophile:    ", "wert": "Wert_Neutros"],
                ["name": "Lymphocyten:    ", "wert": "Wert_Lymphos"],
                ["name": "Monocyten:      ", "wert": "Wert_Monos"],
                ["name": "Eosinophile:    ", "wert": "Wert_Eos"],
                ["name": "Basophile:      ", "wert": "Wert_Basos"],
                ["name": "Retikulozyten:  ", "wert": "Wert_Retis"]
            ])
        
        tableData.append(großesBlutbild)
        
        let gerinnung = Laborwerte(laborwertName: "Gerinnung", dieLaborwerte: [
                ["name": "Leukozyten:     ", "wert": "Wert_Leukos"],
                ["name": "Erythrozyten:   ", "wert": "Wert_Erys"],
                ["name": "Hämoglobin:     ", "wert": "Wert_Hb"],
                ["name": "Hämatokrit:     ", "wert": "Wert_Hkt"],
                ["name": "MCV:            ", "wert": "Wert_MCV"],
                ["name": "MCH:            ", "wert": "Wert_MCH"],
                ["name": "MCHC:           ", "wert": "Wert-MCHC"],
                ["name": "Thrombozyten:   ", "wert": "Wert_Thrombos"],
                ["name": "Neutrophile:    ", "wert": "Wert_Neutros"],
                ["name": "Lymphocyten:    ", "wert": "Wert_Lymphos"],
                ["name": "Monocyten:      ", "wert": "Wert_Monos"],
                ["name": "Eosinophile:    ", "wert": "Wert_Eos"],
                ["name": "Basophile:      ", "wert": "Wert_Basos"],
                ["name": "Retikulozyten:  ", "wert": "Wert_Retis"]
            ])
        
        tableData.append(gerinnung)
        
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK: - Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return tableData.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("laborWert")!
        
        cell.textLabel?.text = tableData[indexPath.row].name
        
        return cell
    
    }
    
    // MARK: - Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("showDetail", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let ctrl = segue.destinationViewController as! DetailController
        let indexPath = tableView.indexPathForSelectedRow
        let laborwert = tableData[indexPath!.row]
        
        ctrl.aktuelleLaborkonstellation = laborwert
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            tableData.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

}


