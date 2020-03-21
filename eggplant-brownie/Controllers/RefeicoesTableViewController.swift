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
    
    override func viewDidLoad() {
        
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return}
        let caminho = diretorio.appendingPathComponent("refeicao")
        
        do {
            let dados = try Data(contentsOf: caminho)
            guard let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else { return }
            refeicoes = refeicoesSalvas
        } catch {
            print(error.localizedDescription)
            
        }
    }
    
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
        
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return}
        let caminho = diretorio.appendingPathComponent("refeicao")
        
        do {
            
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            try dados.write(to: caminho)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func mostrarDetalhes (_gesture : UILongPressGestureRecognizer) {
        
        if _gesture.state == .began {
            let celula = _gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: celula) else {return}
            let refeicao = refeicoes[indexPath.row]
            
            RemoveRefeicao(controller: self).exibe(refeicao, handler: { alert in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            viewController.delegate = self
        }
    }
}
