//
//  Laborbuch.swift
//  BloodyCheckV2
//
//  Created by CEO Sanexio on 12.07.16.
//  Copyright © 2016 Sanexio. All rights reserved.
//

import Foundation

class Laborbuch {
    let kategorien = ["Blutbild", "Gerinnungsdiagnostik", "Klinische Chemie"]
    var laborwerte: [[Laborwerte]]                          // durch die Kategorisierung verwendet man hier Arrays in einem Array
    
    init() {
        laborwerte = [[Laborwerte]]()
        
        // Blutbild:
        laborwerte.append([Laborwerte]())
        
        laborwerte[0].append(Laborwerte(
            title: "Kleines Blutbild",
            bild: "Kleines Blutbild",
            werte: ["Leukozyten", "Erythrozyten", "Hämoglobin", "Hämatokrit", "MCV", "MCH", "MCHC", "Thrombozyten"])
        )
        
        laborwerte[0].append(Laborwerte(
            title: "Großes Blutbild",
            bild: "Großes Blutbild",
            werte: ["Neutrophile", "Lymphocyten", "Monocyten", "Eosinophile", "Basophile", "Retikulozyten", "Jugendliche", "Segmentkernige", "Polychromasie"])
        )
        
        // Gerinnung:
        laborwerte.append([Laborwerte]())
        
        laborwerte[1].append(Laborwerte(
            title: "Gerinnung",
            bild: "Gerinnung",
            werte: ["Quick", "INR", "PTT", "Fibrinogen", "AT3", "D-Dimere"])
        )
        
        // Serum:
        laborwerte.append([Laborwerte]())
        
        laborwerte[2].append(Laborwerte(
            title: "Serum",
            bild: "Serum",
            werte: ["CRP", "Natrium", "Kalium", "Calcium", "Phosphat", "Kreatinin", "Harnstoff", "CK-NAK", "CK-MB", "LDH", "GOT/AST", "GPT/ALT", "GGT", "AP", "CHE", "Eiweiß"])
        )
    }
    
    func getNameForSection(section: Int) -> String {        // section 0: Blutbild, section 1: Gerinnung, section 2: Serum
        return kategorien[section]
    }
}


// Image credits

