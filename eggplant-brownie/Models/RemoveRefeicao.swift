//
//  RemoveRefeicaoViewController.swift
//  eggplant-brownie
//
//  Created by Daniel Fillol on 20/03/20.
//  Copyright © 2020 Entendendo Direito. All rights reserved.
//

import UIKit

class RemoveRefeicao{
    
    let controller : UIViewController
        
    init(controller : UITableViewController) {
        self.controller = controller
    }
    
    func exibe(_ refeicao: Refeicao, handler: @escaping (UIAlertAction) -> Void) {
        
        let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        
        let botaoCancelar = UIAlertAction(title: "Sair", style: .cancel, handler : nil)
        let botaoRemover = UIAlertAction(title: "Remover", style: .destructive, handler: handler)
        alerta.addAction(botaoCancelar)
        alerta.addAction(botaoRemover)
        
        controller.present(alerta, animated: true, completion: nil)
    }
}
