//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Daniel Fillol on 14/03/20.
//  Copyright © 2020 Entendendo Direito. All rights reserved.
//

import UIKit

class Refeicao: NSObject {
       let nome: String
       let felicidade: Int
       let itens: Array <Item> = []
       
       init(_ nome: String, _ felicidade: Int){
           self.nome = nome
           self.felicidade = felicidade
       }
       func totalDeCalorias () -> Double{
           var total: Double = 0
           for item in itens {
               total += item.calorias
           }
           return total
       }
}
