//
//  Item.swift
//  eggplant-brownie
//
//  Created by Daniel Fillol on 14/03/20.
//  Copyright © 2020 Entendendo Direito. All rights reserved.
//

import UIKit

class Item: NSObject {
    let nome: String
    let calorias: Double
      
      init(_ nome: String, _ calorias: Double) {
          self.nome = nome
          self.calorias = calorias
      }
}
