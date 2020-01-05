//
//  Receita.swift
//  AMov1920P2ios1
//
//  Created by Marco on 04/01/2020.
//  Copyright © 2020 DEIS-ISEC. All rights reserved.
//

import Foundation

class Receita {
    var nome : String
    var categoria : String
    var tempo : Int
    var ingredientes : [Ingrediente] = []
    var descricao : String
   
    init(nome : String, categoria : String, tempo : Int, ingredientes : [Ingrediente], descricao : String){
        self.nome = nome
        self.categoria = categoria
        self.tempo = tempo
        self.ingredientes = ingredientes
        self.descricao = descricao
   }
   
   
   
    var description : String{//espécie de .toString do JAVA 
        return "Receita: \(nome) Categoria:[\(categoria)] Tempo:\(tempo) descricao \(descricao)"
    }
}
