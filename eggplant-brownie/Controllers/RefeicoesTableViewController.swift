//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Daniel Fillol on 15/03/20.
//  Copyright © 2020 Entendendo Direito. All rights reserved.
// 

import UIKit


class RefeicoesTableViewController: UITableViewController, AdicionaRefeicaoDelegate {
    
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
        
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_gesture:)))
        celula.addGestureRecognizer(longPress)
        
        return celula
    }
    
    func add(_ refeicao: Refeicao){
        refeicoes.append(refeicao)
        tableView.reloadData()
    }
    
    
    @objc func mostrarDetalhes (_gesture : UILongPressGestureRecognizer) {
        if _gesture.state == .began {
            let celula = _gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: celula) else {return}
            let refeicao = refeicoes[indexPath.row]
            
            let alerta = UIAlertController(title: refeicao.nome, message: "Felicidade:\(refeicao.felicidade)", preferredStyle: .alert)
            let botaoCancelar = UIAlertAction(title: "Ok", style: .cancel, handler : nil)
            alerta.addAction(botaoCancelar)
            
            present(alerta, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            viewController.delegate = self
        }
    }
}
