//
//  INgrediente.swift
//  AMov1920P2ios1
//
//  Created by Marco on 04/01/2020.
//  Copyright © 2020 DEIS-ISEC. All rights reserved.
//

import Foundation

class Ingrediente {
    var nome : String
    var quantidade : Int
    var unidade : String
    
    init(nome: String, quantidade: Int, unidade : String){
        self.nome = nome
        self.quantidade = quantidade
        self.unidade = unidade
    }
    
    
    
    var description : String{//espécie de .toString do JAVA para imprimir os dados do objeto no ecra
        return "Ingrediente: \(nome) Qnt:[\(quantidade)] \(unidade)"
    }
}
