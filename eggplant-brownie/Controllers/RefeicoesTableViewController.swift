//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Daniel Fillol on 15/03/20.
//  Copyright © 2020 Entendendo Direito. All rights reserved.
//

import UIKit


class RefeicoesTableViewController: UITableViewController, ViewControllerDelegate {
    
    var refeicoes = [Refeicao("Macarrão", 4),
                     Refeicao("Pizza", 4),
                     Refeicao("Japa", 5)]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let refeicao = refeicoes[indexPath.row]
        celula.textLabel?.text = refeicao.nome
        
        return celula
    }
    
    func add(_ refeicao: Refeicao){
        refeicoes.append(refeicao)
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            viewController.delegate = self
        }
    }
}
