//
//  Laborwerte.swift
//  BloodyCheckV2
//
//  Created by CEO Sanexio on 12.07.16.
//  Copyright © 2016 Sanexio. All rights reserved.
//

import Foundation

class Laborwerte {
    var title: String
    var bild: String
    var werte: [String]
    
    init(title: String, bild: String, werte: [String]) {
        self.title = title
        self.bild = bild
        self.werte = werte
    }
}
