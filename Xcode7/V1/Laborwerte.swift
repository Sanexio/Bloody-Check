//
//  Laborwerte.swift
//  BloodyCheckV1
//
//  Created by CEO Sanexio on 07.07.16.
//  Copyright © 2016 Sanexio. All rights reserved.
//

import Foundation

class Laborwerte {
    var name: String
    var laborwerte: [[String: String]]
    
    init(laborwertName: String, dieLaborwerte: [[String: String]]) {
        name = laborwertName
        laborwerte = dieLaborwerte
    }
}
