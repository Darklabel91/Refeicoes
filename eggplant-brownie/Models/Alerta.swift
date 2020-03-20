//
//  Alerta.swift
//  eggplant-brownie
//
//  Created by Daniel Fillol on 20/03/20.
//  Copyright © 2020 Entendendo Direito. All rights reserved.
//

import UIKit

class Alerta {
    
    let controller: UIViewController
    
    init(controler: UIViewController) {
        self.controller = controler
    }
    
    func exibe () {
        let alerta = UIAlertController(title: "Desculpe", message: "não foi possível adicionar o item", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerta.addAction(ok)
        controller.present(alerta, animated: true, completion: nil)
    }
}
