//
//  Item.swift
//  eggplant-brownie
//
//  Created by Daniel Fillol on 14/03/20.
//  Copyright © 2020 Entendendo Direito. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {

    // MARK: - Atributos
    
    let nome: String
    let calorias: Double
    
    // MARK: - Init
    
      init(_ nome: String, _ calorias: Double) {
          self.nome = nome
          self.calorias = calorias
      }
    
    // MARK: - NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(nome, forKey: "nome")
        coder.encode(calorias, forKey: "calorias")
    }
    
    required init?(coder: NSCoder) {
        nome = coder.decodeObject(forKey: "nome") as! String
        calorias = coder.decodeDouble(forKey: "calorias")
    }
}
