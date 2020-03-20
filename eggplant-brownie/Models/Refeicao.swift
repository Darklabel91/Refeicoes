//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Daniel Fillol on 14/03/20.
//  Copyright © 2020 Entendendo Direito. All rights reserved.
//

import UIKit

class Refeicao: NSObject {
    
    // MARK: - Atributos
    
       let nome: String
       let felicidade: Int
       var itens: Array <Item> = []
    
    // MARK: - Init
    
    init(_ nome: String, _ felicidade: Int, _ itens:[Item] = []){
        self.nome = nome
        self.felicidade = felicidade
        self.itens = itens
        
    }
    
    // MARK: - Métodos
    
    func totalDeCalorias () -> Double{
        var total: Double = 0
        for item in itens {
            total += item.calorias
        }
        return total
       }
    
    func detalhes () -> String {
        var mensagem = "Felicidade:\(felicidade)"
        for item in itens {
            mensagem += ",\(item.nome) - calorias:\(item.calorias)"
        }
        return mensagem
    }
}
