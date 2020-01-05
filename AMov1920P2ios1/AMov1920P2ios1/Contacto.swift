//
//  Contacto.swift
//  AMov1920P2ios1z
//
//  Created by Alvaro Santos on 29/11/2019.
//  Copyright © 2019 DEIS-ISEC. All rights reserved.
//

import Foundation

class Contacto {
    var nome : String
    var telefone : String
    var latitude : Double
    var longitude : Double
    
    init(nome: String, telefone: String, latitude: Double, longitude: Double) {
        self.nome = nome
        self.telefone = telefone
        self.latitude = latitude
        self.longitude = longitude
    }
    
    convenience init(nome: String, telefone: String) {
        self.init(nome: nome, telefone: telefone, latitude: 0, longitude: 0)
    }
    
    var description : String {
        return "Contacto: \(nome) [\(telefone)] \(latitude) \(longitude)"
    }
    
}
