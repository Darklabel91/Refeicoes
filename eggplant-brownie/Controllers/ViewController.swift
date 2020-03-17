//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Daniel Fillol on 14/03/20.
//  Copyright © 2020 Entendendo Direito. All rights reserved.
//

import UIKit
protocol AdicionaRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource {
    
    // MARK: - UItableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let linhaDaTabela = indexPath.row
        let item = itens[linhaDaTabela]
        celula.textLabel?.text = item
        return celula
    }
    
    // MARK: - Atributos
    
    var delegate : AdicionaRefeicaoDelegate?
    var itens: [String] = ["Molho de tomate", "Queijo", "Molho Apimentado", "Manjericão"]
    
    // MARK: - IBO
    
    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var felicidade: UITextField?
    
    // MARK: IBA Actions
      
    @IBAction func adicionar(_ sender: UIButton) {
        
        if let nomeDaRefeicao = nomeTextField?.text , let felicidadeDaRefeicao = felicidade?.text {
            let nome   = nomeDaRefeicao
            
            if let felicidade = Int(felicidadeDaRefeicao){
            
                let refeicao = Refeicao(nome, felicidade)
                
                print("Alimento \(refeicao.nome) e nível de satisfação \(refeicao.felicidade) adicionado com sucesso!")
                delegate?.add(refeicao)
            }
        }else{
            print("Erro ao criar refeição")
        }
        navigationController?.popViewController(animated: true)
    }
}

