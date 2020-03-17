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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UItableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let linhaDaTabela = indexPath.row
        let item = itens[linhaDaTabela]
        celula.textLabel?.text = item.nome
        return celula
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = tableView.cellForRow(at: indexPath) else {return}
        if celula.accessoryType == .none{
            celula.accessoryType = .checkmark
            let linhaDaTabela = indexPath.row
            itensSelecionados.append(itens[linhaDaTabela])
        }else{
            celula.accessoryType = .none
            let item = itens[indexPath.row]
            if let posicao = itensSelecionados.index(of: item){
                itensSelecionados.remove(at: posicao)
            }
        }
    }
    
    // MARK: - Atributos
    
    var delegate : AdicionaRefeicaoDelegate?
    var itens: [Item] = [Item("Molho de tomate", 40),
                         Item("Queijo", 40),
                         Item("Molho Apimentado", 40),
                         Item("Manjericão", 40)]
    var itensSelecionados: [Item] = []
    
    // MARK: - IBO
    
    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var felicidade: UITextField?
    
    // MARK: IBA Actions
      
    @IBAction func adicionar(_ sender: UIButton) {
        
        if let nomeDaRefeicao = nomeTextField?.text , let felicidadeDaRefeicao = felicidade?.text {
            let nome   = nomeDaRefeicao
            if let felicidade = Int(felicidadeDaRefeicao){
                let refeicao = Refeicao(nome, felicidade, itensSelecionados)
                print("Alimento \(refeicao.nome) e nível de satisfação \(refeicao.felicidade) adicionado com sucesso!")
                delegate?.add(refeicao)
            }
        }else{
            print("Erro ao criar refeição")
        }
        navigationController?.popViewController(animated: true)
    }
}

